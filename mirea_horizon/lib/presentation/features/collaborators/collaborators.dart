import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/collab_bloc/collab_bloc.dart';
import 'package:mirea_horizon/presentation/bloc/collab_bloc/collab_event.dart';
import 'package:mirea_horizon/presentation/features/widgets/custom_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Collaborators extends StatelessWidget {
  Future<void> _refreshData(BuildContext context) async {
    BlocProvider.of<CollabBloc>(context).add(RefreshCollab());
  }

  // 🔗 Ссылки для кликабельных слов (замените на актуальные)
  static const _urls = {
    'центр карьеры': 'https://career.mirea.ru',
    'моя работа': 'https://czn.mos.ru/EE/',
    'моя карьера': 'https://mycareer.moscow/#/applicant',
    'вработе':
        'https://vrabote.me/?tr_uuid=20260221-1312-24bb-a56b-b9414ac108e6&fp=6899a720794bd9974c51744155543df7',
    'vk': 'https://vk.com/careercenterrtumirea',
    'telegram': 'https://t.me/CenterCareer_RTU_MIREA',
    'мероприятия': 'https://career.mirea.ru/career-events/',
    'индивидуальная карьерная консультация':
        'https://career.mirea.ru/consultations/karernye-konsultatsii.php',
  };

  Future<void> _launchUrl(String keyword, BuildContext context) async {
    final url = _urls[keyword.toLowerCase()];
    if (url != null) {
      final uri = Uri.parse(url.trim());
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось открыть ссылку: $keyword')),
        );
      }
    }
  }

  /// 🔥 Создаёт кликабельный текст с выделением ключевых слов
  Widget _buildLinkText(String text, BuildContext context) {
    // 🔥 Создаём список всех ключевых слов для поиска (сортируем по длине - сначала длинные)
    final keywords = _urls.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    // 🔥 Создаём регулярное выражение для поиска всех ключевых слов
    final pattern = keywords.map((keyword) => RegExp.escape(keyword)).join('|');
    final regex = RegExp('($pattern)', caseSensitive: false);

    // 🔥 Используем allMatches для поиска всех вхождений
    final matches = regex.allMatches(text);

    final spans = <TextSpan>[];
    int start = 0;

    // 🔥 Проходим по всем найденным совпадениям
    for (final match in matches) {
      // Добавляем текст ДО ключевого слова
      if (match.start > start) {
        final textBefore = text.substring(start, match.start);
        spans.add(
          TextSpan(
            text: textBefore,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        );
      }

      // Добавляем ключевое слово как ссылку
      final keyword = match.group(0)!;
      final cleanKeyword = keyword.trim().toLowerCase();

      spans.add(
        TextSpan(
          text: keyword, // 🔥 Сохраняем оригинальный регистр и пробелы
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
            fontSize: 14,
            height: 1.5,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => _launchUrl(cleanKeyword, context),
        ),
      );

      start = match.end;
    }

    // 🔥 Добавляем оставшийся текст ПОСЛЕ последнего ключевого слова
    if (start < text.length) {
      final textAfter = text.substring(start);
      spans.add(
        TextSpan(
          text: textAfter,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: 'Центр карьеры РТУ МИРЭА',
      body: RefreshIndicator(
        onRefresh: () => _refreshData(context),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 Заголовок
              // Center(
              //   child: Column(
              //     children: [
              //       Icon(Icons.work_outline,
              //           size: 48, color: Theme.of(context).colorScheme.primary),
              //       const SizedBox(height: 12),
              //       Text(
              //         'Центр карьеры РТУ МИРЭА',
              //         style:
              //             Theme.of(context).textTheme.headlineSmall?.copyWith(
              //                   fontWeight: FontWeight.bold,
              //                   color: Theme.of(context).colorScheme.onSurface,
              //                 ),
              //         textAlign: TextAlign.center,
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 24),

              // 🔥 Девиз
              _buildSection(
                context,
                title: 'Наш девиз',
                content:
                    '«Центр Карьеры РТУ МИРЭА — вместе с нами ты построишь свой карьерный путь! Поможем тебе найти первую работу или выбрать подходящую стажировку. Делимся самыми актуальными вакансиями и советами по трудоустройству для того, чтобы студенты и выпускники смогли определиться с направлением своей карьеры».',
              ),

              // 🔥 Миссия
              _buildSection(
                context,
                title: 'Миссия',
                content:
                    'Помочь выпускникам найти достойную работу и реализовать свой потенциал.',
              ),

              // 🔥 На что направлена деятельность
              _buildSection(
                context,
                title: 'Деятельность',
                content:
                    'На развитие деловых и партнёрских связей между университетом, компаниями-работодателями, студентами и выпускниками.',
              ),

              // 🔥 Партнёры
              _buildSection(
                context,
                title: 'Партнёры',
                content:
                    'Более 300 отечественных и международных компаний и предприятий сотрудничают с Центром карьеры РТУ МИРЭА.',
              ),

              // 🔥 Проекты (с кликабельными названиями)
              _buildSection(
                context,
                title: 'Наши проекты',
                content: '• «Моя работа»\n• «Моя карьера»\n• «ВРаботе»',
                isLinkText: true,
              ),

              // 🔥 Направления работы
              _buildSection(
                context,
                title: 'Направления работы',
                content:
                    '• Увеличение востребованности студентов РТУ МИРЭА на рынке труда\n'
                    '• Формирование аналитики данных по запросам рынка труда к системе образования\n'
                    '• Повышение вовлечённости предприятий и организаций в образовательный процесс, в том числе в вопросах практической подготовки и целевого обучения',
              ),

              // 🔥 Возможности (с кликабельными элементами)
              _buildSection(
                context,
                title: 'Возможности для студентов',
                content:
                    'Группы в VK и Telegram с вакансиями, стажировками, статьями и результатами исследований рынка труда\n\n'
                    'Мероприятия по поиску практик, стажировок и работы («Ярмарки вакансий», «Дни компаний», «Дни карьеры», мастер-классы и встречи с ведущими работодателями, конференции, форумы, производственные экскурсии, внешние мероприятия)\n\n'
                    'Индивидуальная карьерная консультация, где можно создать крутое резюме и портфолио, научиться успешно проходить собеседования, овладеть навыками успешной самопрезентации, построить эффективный карьерный план',
                isLinkText: true,
              ),

              const SizedBox(height: 24),

              // 🔥 Призыв к действию
              Center(
                child: Column(
                  children: [
                    Text(
                      'Хотите узнать больше?',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    _buildLinkText(
                      'Скорее переходите в их группы в VK и Telegram за дополнительной информацией!',
                      context,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 🔥 Контакты
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.email,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Напишите нам:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        'career@mirea.ru',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Центр карьеры РТУ МИРЭА всегда на связи со студентами, от первокурсников до выпускников.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 Вспомогательный метод для секций
  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
    bool isLinkText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 8),
          isLinkText
              ? _buildLinkText(content, context)
              : Text(
                  content,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
        ],
      ),
    );
  }
}
