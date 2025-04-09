import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyUtils {
  static Widget buildDirectionInfo(BuildContext context) {
    // Создаем словарь с данными
    final Map<String, String> infoDirection = {
      "Аналитик":
          "Системное программирование и компьютерные технологии:\n 01.03.02 | Прикладная математика и информатика\n ЕГЭ: математика, русский, информатика\nТехнологии информационно-аналитического мониторинга:\n10.05.04 | Информационно-аналитические системы безопасности\nЕГЭ: математика, русский, информатика",
      "Программист":
          "Цифровые комплексы, системы и сети:\n09.03.01 | Информатика и вычислительная техника\nЕГЭ: математика, русский, физика/информатика\nРазработка кроссплатформенных бизнес-приложений:\n09.03.02 Информационные системы и технологии\nЕГЭ: математика, русский, информатика",
      "Дизайн":
          "Компьютерный дизайн:\n09.03.02 | Информационные системы и технологии\nЕГЭ: математика, русский, информатика\nРазработка и дизайн компьютерных игр и мультимедийных приложений:\n09.03.04 | Программная инженерия\nЕГЭ: математика, русский, информатика",
    };

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Theme.of(context).colorScheme.onSurface),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildStyledButton(
            context,
            infoDirection.keys.elementAt(0),
            infoDirection.values.elementAt(0),
            'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=1&eduLocations=1&onlyPartners=false&sorting=',
          ),
          buildStyledButton(
            context,
            infoDirection.keys.elementAt(1),
            infoDirection.values.elementAt(1),
            'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=3&eduLocations=1&onlyPartners=false&sorting=',
          ),
          buildStyledButton(
            context,
            infoDirection.keys.elementAt(2),
            infoDirection.values.elementAt(2),
            'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=7&eduLocations=1&onlyPartners=false&sorting=',
          ),
          const SizedBox(height: 10),
          const Text(
            'Подробнее можете почитать на сайте Мирэа, нажав на кнопку',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () =>
                launchInBrowser(Uri.parse('https://priem.mirea.ru/guide')),
            child: Text('Сайт Мирэа',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  static Widget buildStyledButton(
      BuildContext context, String key, String value, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent, // Убираем разделительную линию
          ),
          child: ExpansionTile(
            title: Text(
              key,
              textAlign: TextAlign.center,
            ), // Заголовок
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(value), // Описание
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () => launchInBrowser(Uri.parse(url)),
                      child: Text('Подробнее'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}



// import 'package:flutter/material.dart';
// import 'package:mirea_horizon/presentation/features/widgets/custom_widget.dart';

// class TestInfoScreen extends StatelessWidget {
 

//   @override
//   Widget build(BuildContext context) {
//     return CustomWidget(
//       nameAppBar: "Техническая информация",
//       body: ListView.builder(
//         itemCount: infoMap.length, // Количество элементов в словаре
//         itemBuilder: (context, index) {
//           // Получаем ключ и значение по индексу
//           String key = infoMap.keys.elementAt(index);
//           String value = infoMap[key]!;

//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               child: Theme(
//                 data: Theme.of(context).copyWith(
//                   dividerColor:
//                       Colors.transparent, // Убираем разделительную линию
//                 ),
//                 child: ExpansionTile(
//                   title: Text(
//                     key,
//                     textAlign: TextAlign.center,
//                   ), // Заголовок
//                   tilePadding: EdgeInsets.zero,
//                   childrenPadding: EdgeInsets.zero,
//                   backgroundColor: Colors.transparent,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(15.0),
//                         bottomRight: Radius.circular(15.0),
//                       ),
//                       child: Container(
//                         color: Colors.white,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Text(value), // Описание
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
