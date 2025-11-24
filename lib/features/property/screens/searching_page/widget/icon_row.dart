import 'package:flutter/material.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/modelClass/property_model.dart';

class IconRow extends StatefulWidget {
  final IconData icon;
  final String value;
final PropertyModel property;

  const IconRow({
    super.key,
    required this.icon,
    required this.value,
    required this.property,
  });

  @override
  State<IconRow> createState() => _IconRowState();
}

class _IconRowState extends State<IconRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(widget.icon, size: 17.sp, color: AppColors.black),
        SizedBox(width: 4.w),
        Text(
          widget.value,
          style: TextStyle(color: AppColors.black, fontSize: 12.sp),
        ),
      ],
    );
  }
}
