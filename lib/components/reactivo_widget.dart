import 'package:flutter/material.dart';
import 'package:sophie/components/widgets_app.dart';

class ReactivoWidget extends StatelessWidget {
  final String texto;
  final int index;

  const ReactivoWidget({super.key, required this.texto, required this.index});

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: texto,
      size: 20,
    );
  }
}
