import 'package:flutter/material.dart';
import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  bottomSheet: const InteractiveBottomSheet(
    options: InteractiveBottomSheetOptions(),
    child: Text(
       'Lorem ipsum dolor sit amet.'
    ),
  ),
);

  }
}