import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  const AppbarWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Container(
        height: 200.h,
        // width: 244.w,
        color: AppColors.greenColor,
        alignment: Alignment.centerLeft,
        child: child ?? const Text('App Bar', style: TextStyle(color: Colors.white,)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}