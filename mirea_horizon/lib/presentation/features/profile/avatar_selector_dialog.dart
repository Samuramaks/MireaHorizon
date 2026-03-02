// presentation/widgets/avatar_selector_dialog.dart

import 'package:flutter/material.dart';

class AvatarSelectorDialog extends StatelessWidget {
  final List<String> availableAvatars;
  final String? currentAvatar;
  final Function(String) onAvatarSelected;

  const AvatarSelectorDialog({
    super.key,
    required this.availableAvatars,
    this.currentAvatar,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Выберите аватарку',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Сетка аватарок
            SizedBox(
              height: 300,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: availableAvatars.length,
                itemBuilder: (context, index) {
                  final avatarUrl = availableAvatars[index];
                  final isSelected = avatarUrl == currentAvatar;

                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onAvatarSelected(avatarUrl);
                    },
                    child: Stack(
                      children: [
                        // Аватарка
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isSelected ? Colors.blue : Colors.transparent,
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              avatarUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (ctx, child, progress) {
                                if (progress == null) return child;
                                return const Center(
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                );
                              },
                              errorBuilder: (ctx, err, stack) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.person, size: 40),
                              ),
                            ),
                          ),
                        ),
                        // Индикатор выбора
                        if (isSelected)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Кнопка закрытия
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
          ],
        ),
      ),
    );
  }
}
