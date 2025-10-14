import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';

class RowWidget extends StatefulWidget {
  final String text;
  final IconData icons;
  const RowWidget({super.key, required this.text, required this.icons});

  @override
  State<RowWidget> createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(widget.icons, color: AppColors.black),
        Text(widget.text),
      ],
    );
  }
}
