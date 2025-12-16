import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';


class AppTextStyle {
  static TextStyle propertyMediumTextStyle({
    Color? fontColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSize ?? 16.sp,
        fontFamily: 'Inter',
        color: fontColor ?? AppColors.white,
        fontWeight: fontWeight ?? FontWeight.w400,
      );

  static TextStyle propertySmallTextStyle({
    Color? fontColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSize ?? 14.sp,
        fontFamily: 'Inter',
        color: fontColor ?? AppColors.opacityGrey,
        fontWeight: fontWeight ?? FontWeight.w200,
      );

  static TextStyle propertyLargeTextStyle({
    Color? fontColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) =>
      TextStyle(
        fontSize: fontSize ?? 20.sp,
        fontFamily: 'Inter',
        color: fontColor ?? AppColors.blackColor,
        fontWeight: fontWeight ?? FontWeight.w200,
      );
}
