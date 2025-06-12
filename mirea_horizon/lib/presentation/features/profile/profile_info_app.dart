import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirea_horizon/presentation/features/widgets/custom_widget.dart';

class ProfileInfoAppScreen extends StatefulWidget {
  const ProfileInfoAppScreen({super.key});

  @override
  State<ProfileInfoAppScreen> createState() => _ProfileInfoAppScreenState();
}

class _ProfileInfoAppScreenState extends State<ProfileInfoAppScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _copyEmail(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: 'beskhmelnov@mirea.ru'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email скопирован в буфер обмена')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomWidget(
      nameAppBar: 'О приложении',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .cardColor, // Используем цвет карты из текущей темы
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Это приложение и все относящиеся к нему сервисы являются бесплатными и Open Source продуктами.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Данным проектом занимался студент кафедры КБ-9',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    'Бесхмельнов Артём Игоревич',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'С огромным удовольствием приму все предложения и сообщения касаемо проекта.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withOpacity(0.7),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _copyEmail(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.email,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'beskhmelnov@mirea.ru',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
