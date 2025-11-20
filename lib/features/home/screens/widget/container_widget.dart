import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';

class ContainerWidget extends StatefulWidget {
  final Widget child;
  final Color? color;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  const ContainerWidget({
    super.key,
    required this.child,
    this.color,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 130.h,
      width: widget.width ?? 169.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.opacitygreyColor1,
            blurRadius: 0.5.r,
            spreadRadius: 0.5.r,
          ),
        ],
        color: widget.color ?? AppColors.white,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
      ),
      child: widget.child,
    );
  }
}
