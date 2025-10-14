import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/presentation/propertydetails/propertydetails.dart';
import 'package:property_managment/presentation/searching_page/widget/icon_row.dart';

class PropertyContainer extends StatefulWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final bool isShow;
  const PropertyContainer({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.isShow = true,
  });
  @override
  State<PropertyContainer> createState() => _PropertyContainerState();
}

class _PropertyContainerState extends State<PropertyContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PropertydetailsScreen()),
        );
      },
      child: Container(
        height: 400.h,
        color: AppColors.propertyContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                AssetResource.building,
                fit: BoxFit.cover,
                height: 209,
                width: 356,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Apartment',
              style: TextStyle(fontSize: 21.sp, color: AppColors.black),
            ),
            Text(
              '90,000',
              style: TextStyle(fontSize: 44.sp, color: AppColors.black),
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 20),
                Text(
                  'Azizi Aliyah,al jaddaf, Dubai',
                  style: TextStyle(fontSize: 19.sp, color: AppColors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconRow(icon: Icons.bed_outlined, value: '2'),
                IconRow(icon: Icons.bathtub_outlined, value: '2'),
                IconRow(icon: Icons.crop_square_outlined, value: '2'),
                Text('866 ft', style: TextStyle(fontSize: 13.sp)),
                widget.isShow
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 99.75.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            color: widget.color ?? AppColors.propertyContainer,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.bookingNow),
                          ),
                          child: Center(
                            child: Text(
                              widget.text,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: widget.textColor ?? AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
