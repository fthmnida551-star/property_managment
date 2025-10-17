import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';

class FilteringContainer extends StatefulWidget {
  final String text;
  final double width;
  final VoidCallback onTap;
  const FilteringContainer({
    super.key,
    required this.text,
    required this.width,
    required this.onTap
  });

  @override
  State<FilteringContainer> createState() => _FilteringContainerState();
}

class _FilteringContainerState extends State<FilteringContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: GestureDetector(
       onTap:  widget.onTap,
        child: Container(
          width: widget.width,
          height: 32.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              Text(
                widget.text,
                style: TextStyle(fontSize: 12.sp, color: AppColors.black),
              ),
              SizedBox(width: 5),
              Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
