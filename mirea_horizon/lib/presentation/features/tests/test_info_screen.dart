import 'package:flutter/material.dart';
import 'package:mirea_horizon/presentation/features/widgets/custom_widget.dart';

class TestInfoScreen extends StatelessWidget {
  // Создаем словарь с данными
  final Map<String, String> infoMap = {
    "Backend":
        "Backend — это серверная часть приложения, которая обрабатывает бизнес-логику, взаимодействует с базами данных и предоставляет API для фронтенда.",
    "Frontend":
        "Frontend — это клиентская часть приложения, которая отвечает за пользовательский интерфейс и взаимодействие с пользователем.",
    "Analytics":
        "Использование средств MySQL, PostgreSQL, MongoDB, Apex Oracle, а также средства для создания бизнес процессов, благодаря Aris EXpress, idef0, bpmn 2.0",
  };

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: "Техническая информация",
      body: ListView.builder(
        itemCount: infoMap.length, // Количество элементов в словаре
        itemBuilder: (context, index) {
          // Получаем ключ и значение по индексу
          String key = infoMap.keys.elementAt(index);
          String value = infoMap[key]!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor:
                      Colors.transparent, // Убираем разделительную линию
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
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(value), // Описание
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
