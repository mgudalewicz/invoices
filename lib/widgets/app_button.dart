import 'package:flutter/material.dart';

class AppButton extends StatelessWidget with PreferredSizeWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 20.0,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.cyan.shade800),
      ),
      child: Text(text),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
