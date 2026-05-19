import 'package:flutter/material.dart';

/// 긴 앱 이름이 AppBar에서 잘리지 않도록 처리.
class AppBarTitle extends StatelessWidget {
  const AppBarTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
