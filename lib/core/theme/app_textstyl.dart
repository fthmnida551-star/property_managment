import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';



class AppTextstyle {
  static TextStyle propertyMediumTextstyle(
    BuildContext context, {
    Color? fontColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: fontSize ?? 16.sp,
    fontFamily: 'Inter',
    color: fontColor ?? AppColors.white,
    fontWeight: fontWeight ?? FontWeight.w400,
  );
  static TextStyle propertysmallTextstyle(
    BuildContext context, {
    Color? fontColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: fontSize ?? 14.sp,
    fontFamily: 'Inter',
    color: fontColor ?? AppColors.opacitygreyColor,
    fontWeight: fontWeight ?? FontWeight.w200,
  );
  static TextStyle propertyLargeTextstyle(
    BuildContext context, {
    Color? fontColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: fontSize ?? 20.sp,
    fontFamily: 'Inter',
    color: fontColor ?? AppColors.black,
    fontWeight: fontWeight ?? FontWeight.w200,
  );
}
