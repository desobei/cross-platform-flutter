import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  // 1
  const ThemeButton({
    Key? key,
    required this.changeThemeMode,
  }) : super(key: key);

  // 2
  final Function changeThemeMode;

  @override
  Widget build(BuildContext context) {
    // 3
    final isBright = Theme.of(context).brightness == Brightness.light;

    // 4
    return IconButton(
      icon: isBright
          ? const Icon(Icons.dark_mode_outlined) // если светлая тема, показать кнопку для тёмной
          : const Icon(Icons.light_mode_outlined), // если тёмная тема, показать кнопку для светлой
      // 5
      onPressed: () => changeThemeMode(!isBright),
    );
  }
}