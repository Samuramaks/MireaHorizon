import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mirea_horizon/data/repositories/auth_repository.dart';
import 'package:mirea_horizon/data/services/avatar/user_avatar_service.dart';
import 'package:mirea_horizon/data/services/user/user_direction_service.dart';
import 'package:mirea_horizon/data/models/tests/direction.dart';
import 'package:mirea_horizon/data/models/tests/institute_model.dart';
import 'package:mirea_horizon/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:mirea_horizon/presentation/bloc/base/navigation_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/calendar_bloc/calendar_event.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_event.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_state.dart';
import 'package:mirea_horizon/presentation/features/widgets/utils.dart';
import '../widgets/custom_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String email = '';
  User? user = FirebaseAuth.instance.currentUser;
  final AuthRepository authRepository = GetIt.instance<AuthRepository>();
  final UserAvatarService _avatarService = GetIt.instance<UserAvatarService>();

  // 🔥 Выбор института (управляется через TestBloc)
  Institute? _selectedInstitute;
  List<Direction> _availableDirections = [];
  bool _isLoadingDirections = false;

  // 🔥 Маппинг name → code для динамических направлений
  Map<String, String> _directionCodeMap = {'Общее': 'Total'};

  // 🔥 Направления (теперь динамические)
  String? selectedDirection = 'Общее';

  // 🔥 2. Выпадающий список: Типы тестов (статический)
  String? selectedTestType = 'Общее';
  final Map<String, String> testTypeMap = {
    'Общее': 'Total',
    'Программирование': 'Programmer',
    'Аналитика': 'Analyst',
    'Дизайн': 'Designer',
  };

  // Переменные для аватарки
  String? _avatarUrl;
  List<String> _availableAvatars = [];
  bool _isLoadingAvatars = false;
  bool _isUpdatingAvatar = false;
  final String baseUrl = 'http://127.0.0.1:8080';
  String _userBio = '';
  bool _isEditingAbout = false;
  final _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('🚀 ProfileScreen: initState()');

    _getNameAndEmailBySP();
    _checkEmailVerification();
    _loadUserData();
    _loadAvailableAvatars();

    // 🔥 Синхронизируемся с TestBloc при старте
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncWithTestBloc();
      _bioController.text = _userBio;
    });
  }

  // 🔥 Синхронизация с TestBloc: проверяем, выбран ли уже институт
  void _syncWithTestBloc() {
    final blocState = context.read<TestBloc>().state;
    if (blocState is DirectionsLoaded && blocState.directions.isNotEmpty) {
      // Институт уже выбран в TestsScreen — синхронизируем UI
      final instituteId = blocState.directions.first.instituteId;
      final instituteName =
          blocState.directions.first.instituteName ?? 'Институт #$instituteId';
      setState(() {
        _availableDirections = blocState.directions;
        _isLoadingDirections = false;
        _directionCodeMap = {
          'Общее': 'Total',
          for (var d in blocState.directions) d.name: d.code,
        };
        selectedDirection = 'Общее';
        // 🔥 Пытаемся получить институт из первого направления
        if (blocState.directions.isNotEmpty) {
          _selectedInstitute = Institute(
            id: 1, // Можно уточнить через отдельный запрос
            name: instituteName,
          );
        }
      });
      print(
          '✅ ProfileScreen: синхронизирован с TestBloc, направлений: ${blocState.directions.length}');
    }
  }

  // 🔥 Единый метод применения фильтров — с логированием
  void _applyFilters() {
    print('🔧 _applyFilters() вызван');

    // 🔥 Получаем code направления из динамического маппинга
    final directionCode = _directionCodeMap[selectedDirection] ?? 'Total';
    final testTypeCode = testTypeMap[selectedTestType] ?? 'Total';

    print('   🔑 directionCode="$directionCode", testTypeCode="$testTypeCode"');

    // 🔥 Обновляем календарь ТОЛЬКО по типу теста
    print('   📅 Календарь: устанавливаем фильтр type=$testTypeCode');
    final directionService = GetIt.instance<UserDirectionService>();
    directionService.setDirection(testTypeCode);
    context.read<CalendarBloc>()?.add(RefreshCalendar());
    print('   ✅ CalendarBloc: отправлен RefreshCalendar()');

    // 🔥 Обновляем тесты по направлению + типу
    print('   📚 Тесты: определяем событие...');
    if (directionCode == 'Total' && testTypeCode == 'Total') {
      print('   📡 Отправляем: FetchTests()');
      context.read<TestBloc>().add(FetchTests());
    } else if (directionCode == 'Total') {
      print('   📡 Отправляем: FetchTestForType($testTypeCode)');
      context.read<TestBloc>().add(FetchTestForType(testTypeCode));
    } else if (testTypeCode == 'Total') {
      print('   📡 Отправляем: FetchTestForDirection($directionCode)');
      context.read<TestBloc>().add(FetchTestForDirection(directionCode));
    } else {
      print(
          '   📡 Отправляем: FetchTestForDirectionAndType(dir=$directionCode, type=$testTypeCode)');
      context.read<TestBloc>().add(FetchTestForDirectionAndType(
            directionCode: directionCode,
            testType: testTypeCode,
          ));
    }
    print('   ✅ TestBloc: событие отправлено');
  }

  void _getNameAndEmailBySP() async {
    if (user != null) {
      setState(() {
        name = user!.displayName ?? 'Имя не указано';
        email = user!.email ?? 'Электронная почта не указана';
      });
    }
  }

  Future<void> _checkEmailVerification() async {
    if (user != null) {
      await user!.reload();
      setState(() {
        user = FirebaseAuth.instance.currentUser;
      });
    }
  }

  Future<void> _loadUserData() async {
    if (email.isEmpty || email == 'Электронная почта не указана') return;
    try {
      final uri = Uri.parse('$baseUrl/api/user?email=$email');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final avatarUrl = json['avatarUrl'] as String?;
        if (avatarUrl != null && avatarUrl.isNotEmpty) {
          setState(() {
            _avatarUrl = '$baseUrl$avatarUrl';
          });
          _avatarService.setAvatar('$baseUrl$avatarUrl');
        }
      }
    } catch (e) {
      print('❌ Ошибка загрузки данных пользователя: $e');
    }
  }

  Future<void> _loadAvailableAvatars() async {
    print('🔄 Загрузка списка аватарок...');
    setState(() => _isLoadingAvatars = true);
    try {
      final uri = Uri.parse('$baseUrl/api/user/avatars');
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final avatars = jsonList.map<String>((url) => '$baseUrl$url').toList();
        setState(() {
          _availableAvatars = avatars;
          _isLoadingAvatars = false;
        });
      } else {
        setState(() => _isLoadingAvatars = false);
      }
    } catch (e) {
      setState(() => _isLoadingAvatars = false);
    }
  }

  Future<void> _selectAvatar(String avatarUrl) async {
    setState(() => _isUpdatingAvatar = true);
    try {
      final uri = Uri.parse('$baseUrl/api/user/avatar?email=$email');
      final body = {'avatarUrl': avatarUrl.replaceFirst(baseUrl, '')};
      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 && mounted) {
        setState(() => _avatarUrl = avatarUrl);
        _avatarService.setAvatar(avatarUrl);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('✅ Аватарка обновлена'),
              backgroundColor: Colors.green),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('❌ Ошибка: ${response.body}'),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isUpdatingAvatar = false);
    }
  }

  void _showAvatarSelector() {
    if (_isLoadingAvatars) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('⏳ Загрузка аватарок...')));
      return;
    }
    if (_availableAvatars.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('⚠️ Нет доступных аватарок')));
      return;
    }
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Выберите аватарку',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1),
                  itemCount: _availableAvatars.length,
                  itemBuilder: (context, index) {
                    final avatarUrl = _availableAvatars[index];
                    final isSelected = avatarUrl == _avatarUrl;
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _selectAvatar(avatarUrl);
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: isSelected
                                      ? Colors.blue
                                      : Colors.transparent,
                                  width: 3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                avatarUrl,
                                fit: BoxFit.cover,
                                cacheWidth: 120,
                                cacheHeight: 120,
                                loadingBuilder: (ctx, child, progress) =>
                                    progress == null
                                        ? child
                                        : const Center(
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2)),
                                errorBuilder: (ctx, err, stack) => Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.person, size: 40)),
                              ),
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                                top: 4,
                                right: 4,
                                child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.check,
                                        color: Colors.white, size: 16))),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отмена')),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Подтверждение почты'),
        content: const Text(
            'Подтверждение отправлено на почту, которая была указана при регистрации'),
        actions: [
          TextButton(
              child: const Text('Закрыть'),
              onPressed: () => Navigator.of(context).pop())
        ],
      ),
    );
  }

  void _saveAboutMeLocal() {
    setState(() {
      _userBio = _bioController.text.trim();
      _isEditingAbout = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Сохранено'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return CustomWidget(
      nameAppBar: 'Профиль',
      actions: [
        user != null && user!.emailVerified
            ? Icon(Icons.verified, color: colorScheme.onSurface)
            : Container()
      ],
      body: Column(
        children: [
          // 🔥 Слушаем TestBloc для синхронизации института и направлений
          BlocListener<TestBloc, TestState>(
            listenWhen: (previous, current) =>
                current is InstitutesLoaded ||
                current is DirectionsLoaded ||
                current is TestsLoaded,
            listener: (context, state) {
              if (state is InstitutesLoaded && state.institutes.isNotEmpty) {
                print(
                    '✅ ProfileScreen: загружено институтов ${state.institutes.length}');
              }

              if (state is DirectionsLoaded) {
                // 🔥 Направления для выбранного института загружены
                setState(() {
                  _availableDirections = state.directions;
                  _isLoadingDirections = false;
                  // 🔥 Создаём маппинг name → code
                  _directionCodeMap = {
                    'Общее': 'Total',
                    for (var d in state.directions) d.name: d.code,
                  };
                  // 🔥 Сбрасываем выбор направления
                  selectedDirection = 'Общее';
                  // 🔥 Устанавливаем институт (можно уточнить через сервис)
                  _selectedInstitute = Institute(
                    id: 1,
                    name: 'Выбранный институт',
                  );
                });
                print(
                    '✅ ProfileScreen: загружено направлений ${state.directions.length}');
              }
            },
            child: Container(), // пустой, listener работает независимо
          ),

          // 🔥 Основной контент (всегда доступен)
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ═══════════════════════════════════════════════════════
                    // 🔥 РАЗДЕЛ 1: Аватарка и имя (ВСЕГДА доступен)
                    // ═══════════════════════════════════════════════════════
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _showAvatarSelector,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[300],
                                  child: _avatarUrl != null
                                      ? ClipOval(
                                          child: Image.network(_avatarUrl!,
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                              cacheWidth: 120,
                                              cacheHeight: 120,
                                              loadingBuilder: (ctx, child,
                                                      progress) =>
                                                  progress == null
                                                      ? child
                                                      : const CircularProgressIndicator(
                                                          strokeWidth: 2),
                                              errorBuilder: (ctx, err, stack) =>
                                                  const Icon(Icons.person,
                                                      size: 30)))
                                      : const Icon(Icons.person, size: 30)),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2)),
                                      child: const Icon(Icons.edit,
                                          color: Colors.white, size: 12))),
                              if (_isUpdatingAvatar)
                                Positioned.fill(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            shape: BoxShape.circle),
                                        child: const Center(
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Colors.white))))),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(email, style: const TextStyle(fontSize: 18))
                            ]),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Кнопка подтверждения почты (ВСЕГДА доступна)
                    if (user != null && !user!.emailVerified)
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.onSurface,
                              foregroundColor: colorScheme.onPrimary,
                              elevation: 2),
                          onPressed: () {
                            authRepository.emailVerification();
                            _showDialog(context);
                          },
                          child: const Text('Подтвердить почту')),

                    const SizedBox(height: 20),
                    // ═══════════════════════════════════════════════════════
// 🔥 РАЗДЕЛ: О себе (одно поле)
// ═══════════════════════════════════════════════════════
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Заголовок + кнопка редактирования
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'О себе',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    if (_isEditingAbout) {
                                      _bioController.text = _userBio; // отмена
                                    }
                                    setState(() =>
                                        _isEditingAbout = !_isEditingAbout);
                                  },
                                  icon: Icon(
                                    _isEditingAbout ? Icons.close : Icons.edit,
                                    size: 18,
                                  ),
                                  label: Text(_isEditingAbout
                                      ? 'Отмена'
                                      : 'Редактировать'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: colorScheme.primary,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 8),

                            // 🔹 Поле ввода / отображение
                            _isEditingAbout
                                ? TextField(
                                    controller: _bioController,
                                    maxLines: 4,
                                    maxLength: 500,
                                    decoration: InputDecoration(
                                      hintText: 'Напишите немного о себе...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 10),
                                      counterText:
                                          '', // скрыть счётчик символов, если не нужен
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () =>
                                        setState(() => _isEditingAbout = true),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey.shade50,
                                      ),
                                      child: Text(
                                        _userBio.isEmpty
                                            ? 'Нажмите, чтобы добавить информацию о себе'
                                            : _userBio,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _userBio.isEmpty
                                              ? Colors.grey
                                              : colorScheme.onSurface,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ),

                            // 🔹 Кнопка "Сохранить" (только в режиме редактирования)
                            if (_isEditingAbout) ...[
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _saveAboutMeLocal,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    foregroundColor: colorScheme.onPrimary,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                  ),
                                  child: const Text('Сохранить'),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    MyUtils.buildDirectionInfo(context),
                    const SizedBox(height: 20),

                    // ═══════════════════════════════════════════════════════
                    // 🔥 РАЗДЕЛ 2: Фильтрация (только если выбран институт)
                    // ═══════════════════════════════════════════════════════
                    if (_selectedInstitute == null)
                      // 🔹 Placeholder: институт не выбран
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Icon(Icons.filter_list_off,
                                  size: 48, color: Colors.grey[400]),
                              const SizedBox(height: 12),
                              Text(
                                'Фильтрация тестов',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Чтобы фильтровать тесты по направлению,\nсначала выберите институт на вкладке "Тестирование"',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                ),
                                onPressed: () => context.go('/app/tests'),
                                icon: const Icon(Icons.school),
                                label: const Text('Перейти к выбору института'),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      // 🔹 Dropdowns доступны (институт выбран)
                      Card(
                        // color: colorScheme.primaryContainer.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              // Показываем выбранный институт
                              Row(
                                children: [
                                  Icon(Icons.school,
                                      size: 20, color: colorScheme.primary),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Институт',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: colorScheme.onSurface,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // 🔥 Сброс института — возвращаемся к placeholder
                                      setState(() {
                                        _selectedInstitute = null;
                                        _availableDirections = [];
                                        _directionCodeMap = {'Общее': 'Total'};
                                        selectedDirection = 'Общее';
                                      });
                                    },
                                    child: const Text('Сменить'),
                                  ),
                                ],
                              ),
                              const Divider(),
                              const SizedBox(height: 8),

                              // 🔥 Dropdown: Направление (динамический)
                              Row(
                                children: [
                                  Icon(Icons.menu_book,
                                      size: 18, color: colorScheme.primary),
                                  const SizedBox(width: 8),
                                  const Text('Направление',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: _isLoadingDirections
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : DropdownButton<String>(
                                        focusColor: colorScheme.onSurface,
                                        value: selectedDirection,
                                        hint: const Text('Направление'),
                                        isExpanded: true,
                                        items: [
                                          const DropdownMenuItem<String>(
                                            value: 'Общее',
                                            child: Text('Общее',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          ..._availableDirections.map(
                                              (direction) =>
                                                  DropdownMenuItem<String>(
                                                    value: direction.name,
                                                    child: Text(direction.name),
                                                  )),
                                        ].toList(),
                                        onChanged: (String? newValue) {
                                          if (newValue == null) return;
                                          setState(() =>
                                              selectedDirection = newValue);
                                          _applyFilters();
                                        },
                                      ),
                              ),
                              const SizedBox(height: 12),

                              // 🔥 Dropdown: Тип теста (статический)
                              Row(
                                children: [
                                  Icon(Icons.category,
                                      size: 18, color: colorScheme.primary),
                                  const SizedBox(width: 8),
                                  const Text('Тип теста',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: DropdownButton<String>(
                                  focusColor: colorScheme.onSurface,
                                  value: selectedTestType,
                                  hint: const Text('Тип теста'),
                                  isExpanded: true,
                                  items: testTypeMap.keys
                                      .map((name) => DropdownMenuItem(
                                          value: name, child: Text(name)))
                                      .toList(),
                                  onChanged: (newValue) {
                                    if (newValue == null) return;
                                    setState(() => selectedTestType = newValue);
                                    _applyFilters();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // ═══════════════════════════════════════════════════════
                    // 🔥 РАЗДЕЛ 3: Кнопки навигации (ВСЕГДА доступны)
                    // ═══════════════════════════════════════════════════════
                    TextButton(
                        onPressed: () => context.go('/app/profile/info'),
                        child: Text('О приложении',
                            style: TextStyle(color: colorScheme.onSurface))),
                    TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(SignOutRequested());
                          context
                              .read<NavigationBloc>()
                              .add(ResetNavigationEvent());
                        },
                        child: const Text('Выйти из профиля',
                            style: TextStyle(
                                fontSize: 16, color: Colors.redAccent))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
