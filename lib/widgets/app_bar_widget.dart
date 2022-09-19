import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarWidget({super.key, required this.title, this.leading, this.actions});

  final Widget? leading;
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        actions: actions,
        leading: leading,
        title: title != null ? Text(title!) : null,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.cyan.shade700, Colors.cyan.shade900])),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
