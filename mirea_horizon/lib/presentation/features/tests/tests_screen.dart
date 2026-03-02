import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:mirea_horizon/data/repositories/user_repository/user_repository.dart';
import 'package:mirea_horizon/data/models/tests/direction.dart';
import 'package:mirea_horizon/data/models/tests/test_models.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/test_bloc/test_event.dart';
import 'package:mirea_horizon/presentation/features/widgets/tramslation.dart';

import '../../../data/models/tests/institute_model.dart';
import '../../../data/repositories/local_data/sp_repository.dart';
import '../../bloc/test_bloc/test_state.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  _TestsScreenState createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  final UserRepository userRepository = UserRepository();
  int coins = 0;
  User? user = FirebaseAuth.instance.currentUser!;
  final spRepository = GetIt.instance<SPRepository>();

  List<Institute> _institutes = [];
  List<Direction> _directions = [];
  List<Direction> _allDirections = [];
  Institute? _selectedInstitute;

  final Map<int, bool> _expandedDirections = {};
  Map<int, List<Test>> _directionTests = {};

  bool _isLoading = false;
  bool _hasSelectedInstitute = false;
  bool _isFilterApplied = false;

  @override
  void initState() {
    super.initState();
    _updateCoins();
    context.read<TestBloc>().add(FetchInstitutes());
    _subscribeToBloc();
  }

  void _onBackToInstitutes() {
    print('🔙 Возврат к выбору института');
    setState(() {
      _selectedInstitute = null;
      _hasSelectedInstitute = false;
      _directions.clear();
      _allDirections.clear();
      _directionTests.clear();
      _expandedDirections.clear();
      _isLoading = false;
    });

    // 🔥 Загружаем все тесты (сброс фильтров)
    context.read<TestBloc>().add(FetchTests());
  }

  void _subscribeToBloc() {
    final blocState = context.read<TestBloc>().state;
    if (_hasSelectedInstitute && _selectedInstitute != null) {
      context.read<TestBloc>().add(FetchDirections(_selectedInstitute!.id));
    }
    // else if (blocState is TestInitial) {
    //   context.read<TestBloc>().add(FetchTests());
    // }
  }

  void _updateDirectionTestsFromBloc(List<Test> tests) {
    print('📥 _updateDirectionTestsFromBloc: ${tests.length} тестов');

    // 🔥 Группируем тесты и собираем ID направлений
    final grouped = <int, List<Test>>{};
    final directionIds = <int>{};

    for (final test in tests) {
      if (test.directionId != null) {
        grouped.putIfAbsent(test.directionId!, () => []).add(test);
        directionIds.add(test.directionId!);
      }
    }

    if (mounted) {
      setState(() {
        // Обновляем кэш тестов
        _directionTests = grouped;

        // 🔥 Если тестов мало И направлений много — это фильтрация
        if (_isFilterApplied && _allDirections.isNotEmpty) {
          // Показываем только направления с тестами
          _directions = _allDirections
              .where((dir) => directionIds.contains(dir.id))
              .toList();
          // Раскрываем единственное направление
          if (directionIds.length == 1) {
            _expandedDirections[directionIds.first] = true;
          }
          print(
              '🔍 Фильтрация: ${_directions.length} направлений, ${tests.length} тестов');
        } else if (!_isFilterApplied && _allDirections.isNotEmpty) {
          _directions = List.from(_allDirections);
          _expandedDirections.clear();
          print(
              '🔄 Сброс фильтра: ${_directions.length} направлений, ${tests.length} тестов');
        }
      });
    }
  }

  Future<void> _onInstituteSelected(Institute institute) async {
    print('🎯 Выбран институт: ${institute.name} (id=${institute.id})');

    // 🔥 Сбрасываем флаг фильтрации при выборе института
    setState(() {
      _selectedInstitute = institute;
      _hasSelectedInstitute = true;
      _isLoading = true;
      _directions.clear();
      _directionTests.clear();
      _expandedDirections.clear();
      _allDirections.clear();
      _isFilterApplied = false;
    });

    context.read<TestBloc>().add(FetchDirections(institute.id));
    // context.read<TestBloc>().add(FetchTests());

    setState(() => _isLoading = false);
  }

  Future<void> _loadTestsForDirection(Direction direction) async {
    if (_directionTests.containsKey(direction.id)) return;
    print('🔄 Загрузка тестов для: ${direction.name}');
    context.read<TestBloc>().add(FetchTestForDirection(direction.code));
  }

  void _toggleDirection(int directionId) {
    setState(() {
      _expandedDirections[directionId] =
          !(_expandedDirections[directionId] ?? false);
    });
    if (_expandedDirections[directionId] == true) {
      final direction = _directions.firstWhere((d) => d.id == directionId);
      _loadTestsForDirection(direction);
    }
  }

  Future<void> _updateCoins() async {
    if (user != null) {
      int updatedCoins = await userRepository.getUserCoins(user!.email!) as int;
      if (mounted) setState(() => coins = updatedCoins);
    }
  }

  Future<void> _refreshData(BuildContext context) async {
    _updateCoins();
    if (_hasSelectedInstitute && _selectedInstitute != null) {
      await _onInstituteSelected(_selectedInstitute!);
    } else {
      context.read<TestBloc>().add(RefreshTests());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _hasSelectedInstitute
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _onBackToInstitutes,
                tooltip: 'Выбрать другой институт',
              )
            : null,
        title: Row(
          children: [
            Text('$coins',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            Image.asset('assets/images/coin.png', width: 23, height: 23),
            const Spacer(),
            Text('Тестирование',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            const Spacer(),
            IconButton(
              onPressed: () => context.go('/app/tests/info'),
              icon: const Icon(Icons.info_outline),
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 🔥 BlocListener — ВСЕ setState ТОЛЬКО ЗДЕСЬ
          BlocListener<TestBloc, TestState>(
            listenWhen: (previous, current) =>
                current is TestsLoaded ||
                current is InstitutesLoaded ||
                current is DirectionsLoaded ||
                current is TestError,
            listener: (context, state) {
              // 🔥 defer setState до конца фрейма

              if (state is InstitutesLoaded) {
                setState(() {
                  _institutes = state.institutes;
                  _isLoading = false;
                });
                // if (state.institutes.length == 1) {
                //   _onInstituteSelected(state.institutes.first);
                // }
              }
              if (state is DirectionsLoaded) {
                setState(() {
                  _directions = state.directions;
                  _allDirections = List.from(_directions);
                  _isLoading = false;
                });
              }
              if (state is TestsLoaded) {
                print(
                    '🎧 BlocListener: TestsLoaded (${state.tests.length} тестов)');
                // 🔥 Обновляем тесты (setState внутри _updateDirectionTestsFromBloc не нужен)
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    final isFiltered = state.tests.length < 10 &&
                        state.tests.length < _allDirections.length;

                    setState(() {
                      _isFilterApplied = isFiltered;
                    });
                    _updateDirectionTestsFromBloc(state.tests);
                  }

                  // 🔥 Перестраиваем UI после обновления кэша
                });
              }
              if (state is TestError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Ошибка: ${state.message}')),
                );
                setState(() => _isLoading = false);
              }
            },
            child: Container(), // пустой, listener работает независимо
          ),

          // 🔥 BlocBuilder — ТОЛЬКО для лоадера/ошибки, БЕЗ setState
          BlocBuilder<TestBloc, TestState>(
            buildWhen: (previous, current) =>
                current is TestLoading || current is TestError,
            builder: (context, state) {
              if (state is TestLoading &&
                  _institutes.isEmpty &&
                  !_hasSelectedInstitute) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              }
              if (state is TestError && _institutes.isEmpty) {
                return Expanded(
                    child: Center(child: Text('Ошибка: ${state.message}')));
              }
              return Expanded(
                child: RefreshIndicator(
                  onRefresh: () => _refreshData(context),
                  backgroundColor: Colors.white,
                  child: _buildBody(), // ← читает из локальных переменных
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    print('🎨 _buildBody() вызван');
    print('   📊 _directionTests keys: ${_directionTests.keys.toList()}');
    print('   📊 _directions count: ${_directions.length}');

    if (_isLoading && !_hasSelectedInstitute) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_hasSelectedInstitute) {
      if (_institutes.isEmpty) {
        return const Center(child: Text('Нет доступных институтов'));
      }
      return ListView.builder(
        itemCount: _institutes.length,
        itemBuilder: (context, index) {
          final institute = _institutes[index];
          return ListTile(
            title: Text(institute.name),
            subtitle: institute.description != null
                ? Text(institute.description!)
                : null,
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => _onInstituteSelected(institute),
          );
        },
      );
    }

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_directions.isEmpty) {
      return const Center(child: Text('Нет доступных направлений'));
    }

    return ListView.builder(
      itemCount: _directions.length,
      itemBuilder: (context, index) {
        final direction = _directions[index];
        final isExpanded = _expandedDirections[direction.id] ?? false;
        final tests = _directionTests[direction.id];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            title: Text(direction.name,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: direction.description != null
                ? Text(direction.description!)
                : null,
            initiallyExpanded: isExpanded,
            onExpansionChanged: (expanded) => _toggleDirection(direction.id),
            children: [
              if (tests == null)
                const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()))
              else if (tests.isEmpty)
                const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Нет доступных тестов'))
              else
                ...tests.map((test) => _buildTestTile(test, context)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTestTile(Test test, BuildContext context) {
    return ListTile(
      title: Text(TestTranslations.getDirectionRu(test.nameTest),
          style: const TextStyle(fontSize: 14)),
      subtitle: Text(
          'Сложность: ${TestTranslations.getDifficultyRu(test.difficultyLevel)}'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => context.go('/app/tests/details', extra: test),
    );
  }
}
