import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';

class TextFieldContainer extends StatelessWidget {
  final String text;
  final Icon? suffixIcon;
  final Icon? priffixIcon;
  final bool readOnly;
  final TextEditingController controllerName;
  final String? Function(String?)? validator;
  const TextFieldContainer({
    super.key,
    required this.text,
    this.suffixIcon,
    this.priffixIcon,
    required this.controllerName,
    this.validator,
    required this.readOnly
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerName,
      validator: validator,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.opacitygreyColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),

        hintText: text,
        hintStyle: TextStyle(
          fontSize: 18.sp,
          color: AppColors.opacitygrayColorText,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: priffixIcon,
      ),
    );
  }
}
