import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';

class TextFieldContainer extends StatefulWidget {
  final String text;
  final Icon? suffixIcon;
  final Icon? priffixIcon;
  final TextEditingController controllerName;
  final String? Function(String?)? validator;
  const TextFieldContainer({
    super.key,
    required this.text,
    this.suffixIcon,
    this.priffixIcon,
    required this.controllerName, this.validator,
   
  });

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
  controller: widget.controllerName,
  validator: widget.validator,
  decoration: InputDecoration(
    border: OutlineInputBorder(
       borderSide: BorderSide(
        color: AppColors.opacitygreyColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    
    hintText: widget.text,
    hintStyle: TextStyle(
      fontSize: 18.sp,
      color: AppColors.opacitygrayColorText,
    ),
    suffixIcon: widget.suffixIcon,
    prefixIcon: widget.priffixIcon,
  ),
);

  }
}
