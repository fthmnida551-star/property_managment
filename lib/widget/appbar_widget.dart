
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:propertymanagementapp/core/theme/app_colors.dart';

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
        height: 144.h,
        color: AppColors.greencolor,
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: 30,left: 5),
        child: child 
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

