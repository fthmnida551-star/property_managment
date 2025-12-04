import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';

class GreenButton extends StatefulWidget {
  final double? width;
  final double? height;
  final String text;
  final VoidCallback onTap;
  const GreenButton({this.width, this.height,required this.text,required this.onTap, super.key});
  @override
  State<GreenButton> createState() => _GreenButtonState();
}

class _GreenButtonState extends State<GreenButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width ?? 350.w,
        height: widget.height ?? 53.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.greenColor,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(color: AppColors.white, fontSize: 21),
          ),
        ),
      ),
    );
  }
}
