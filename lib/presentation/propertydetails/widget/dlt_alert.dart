import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/presentation/propertydetails/property_details/not_booked.dart';
import 'package:property_managment/presentation/propertydetails/propertydetails.dart';
import 'package:property_managment/presentation/searching_page/searchingpage.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';

void dltAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    'Delete',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Center(
              child: Text(
                'Are you sure you want to delete this property?',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BottomNavigationWidget(currentIndex: 1),
                      ),
                    );
                  },
                  child: Container(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppColors.opacityGrey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.black, width: 0.5),
                    ),
                    child: Center(
                      child: Text(
                        'YES',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppColors.opacityGrey,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.black, width: 0.5),
                    ),
                    child: Center(
                      child: Text(
                        'NO',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
