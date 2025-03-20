import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyUtils {
  static Widget buildDirectionInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildStyledButton(
          context,
          'Аналитик',
          'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=1&eduLocations=1&onlyPartners=false&sorting=',
        ),
        buildStyledButton(
          context,
          'Программист',
          'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=3&eduLocations=1&onlyPartners=false&sorting=',
        ),
        buildStyledButton(
          context,
          'Дизайнер',
          'https://priem.mirea.ru/guide?eduLevel=bach-spec&strDirections=7&eduLocations=1&onlyPartners=false&sorting=',
        ),
        const SizedBox(height: 10),
        const Text(
          'Подробнее можете почитать на сайте Мирэа, нажав на кнопку',
          style: TextStyle(fontSize: 16),
        ),
        ElevatedButton(
          onPressed: () =>
              launchInBrowser(Uri.parse('https://priem.mirea.ru/guide')),
          child: Text('Сайт Мирэа',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ),
      ],
    );
  }

  static Widget buildStyledButton(
      BuildContext context, String label, String url) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () => launchInBrowser(Uri.parse(url)),
      child: Text(label),
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
