import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';

class TextFieldContainer extends StatefulWidget {
  final String text;
  final Icon? suffixIcon;
  final Icon? priffixIcon;
  const TextFieldContainer({super.key, required this.text,this.suffixIcon,this.priffixIcon});

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: BoxBorder.all(width: 1, color: AppColors.OpacitygreyColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.text,
            hintStyle: TextStyle(
              fontSize: 18.sp,
              color: AppColors.OpacitygrayColorText,
            ),
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.priffixIcon,
          ),
        ),
      ),
    );
  }
}
