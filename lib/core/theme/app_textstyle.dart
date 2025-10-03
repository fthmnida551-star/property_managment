import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:propertymanagementapp/core/theme/app_colors.dart';

class AppTextstyle {
  static TextStyle propertyMediumTextstyle(
    BuildContext context, {
    Color? fontColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: fontSize ?? 16.sp,
    fontFamily: 'Inter',
    color: fontColor ?? AppColors.whitecolor,
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
    color: fontColor ?? AppColors.blackcolor,
    fontWeight: fontWeight ?? FontWeight.w200,
  );
}
