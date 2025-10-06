import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';

class CheckboxWithListenable extends StatefulWidget {
  final String text;
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  const CheckboxWithListenable({super.key, required this.text,this.value, this.onChanged});

  @override
  State<CheckboxWithListenable> createState() => _CheckboxWithListenableState();
}

class _CheckboxWithListenableState extends State<CheckboxWithListenable> {
  // This holds the state of the checkbox
  final ValueNotifier<bool> _isChecked = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<bool>(
        valueListenable: _isChecked,
        builder: (context, value, child) {
          return CheckboxListTile(
            title: Text(
              widget.text,
              style: TextStyle(fontSize: 18, color: AppColors.black),
            ),
            value:widget.value?? value,
            onChanged:
                widget.onChanged ??
                (newValue) {
                  _isChecked.value = newValue ?? false;
                },
            controlAffinity: ListTileControlAffinity.leading,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(500),
            ),
            activeColor: Colors.green,
          );
        },
      ),
    );
  }
}
