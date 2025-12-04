import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/app_textstyl.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';


class BookedPropertiesPage extends StatelessWidget {
  final List bookedItems;

  const BookedPropertiesPage({super.key, required this.bookedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            "Booked Properties",
            style: AppTextstyle.propertyLargeTextstyle(
              context,
              fontColor: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: bookedItems.isEmpty
          ? Center(
              child: Text(
                "No booked properties found",
                style: AppTextstyle.propertyMediumTextstyle(
                  context,
                  fontColor: AppColors.opacitygreyColor,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: bookedItems.length,
              itemBuilder: (context, index) {
                final item = bookedItems[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      item["image"],
                      width: 60.w,
                      height: 60.h,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      item["name"],
                      style: AppTextstyle.propertyMediumTextstyle(
                        context,
                        fontColor: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      item["price"],
                      style: AppTextstyle.propertysmallTextstyle(
                        context,
                        fontColor: AppColors.opacitygreyColor,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
