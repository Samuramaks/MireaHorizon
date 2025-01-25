import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentIndex = 0;

  final List<IntroPage> _introPages = [
    IntroPage(
        image: 'assets/images/intro1.jpeg',
        title: 'Учитесь быстро и качественно',
        subTitle:
            'Раскройте свой потенциал, включитесь в образовательный процесс'),
    IntroPage(
        image: 'assets/images/intro2.jpeg',
        title: 'Найдите себя, делая то, что вы делаете!',
        subTitle: 'Определитесь со своей будущей профессией'),
    IntroPage(
        image: 'assets/images/intro3.jpeg',
        title: 'Это не просто обучение, а вклад в своё будущее',
        subTitle: 'Учитесь сегодня, руководите завтра'),
  ];

  void _nextPage() {
    if (_currentIndex < _introPages.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // После последнего экрана переходим на главный экран приложения
      context.go('/auth'); // или '/app/main', в зависимости от вашей логики
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_introPages[_currentIndex].image),
                const SizedBox(height: 20),
                Text(
                  _introPages[_currentIndex].title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  // maxLines: 5,
                ),
                // const SizedBox(height: 20),
                Text(
                  _introPages[_currentIndex].subTitle,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                  // maxLines: 5,
                )
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.surface)),
            onPressed: _nextPage,
            child: Text(
              'Далее',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
              onPressed: () => context.go('/auth'),
              child: Text(
                'Пропустить',
                style: TextStyle(color: Theme.of(context).colorScheme.surface),
              ))
        ],
      ),
    );
  }
}

class IntroPage {
  final String image;
  final String title;
  final String subTitle;

  IntroPage({required this.image, required this.title, required this.subTitle});
}
