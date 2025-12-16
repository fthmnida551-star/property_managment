import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/app_textstyl.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/features/booking/controller/booking_controllers.dart';
import 'package:property_managment/features/property/screens/propertydetails/property_details/not_booked.dart';
import 'package:property_managment/features/property/screens/searching_page/widget/property_container.dart';
import 'package:property_managment/modelClass/property_model.dart';


class NotBookedPropertiesPage extends ConsumerWidget {
  const NotBookedPropertiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 👉 Watching NOT-BOOKED list provider
    final notBookedState = ref.watch(notBookedPropertyListProvider);

    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            "Not Booked Properties",
            style: AppTextstyle.propertyLargeTextstyle(
              context,
              fontColor: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),

      body: notBookedState.when(

        // ⏳ Loading State
        loading: () =>
            const Center(child: CircularProgressIndicator()),

        // ❌ Error State
        error: (error, stack) => Center(
          child: Text(
            "Error: $error",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),

        // ✅ Success State
        data: (propertyList) {
          log("NOT BOOKED ITEMS: ${propertyList.length}");

          if (propertyList.isEmpty) {
            return Center(
              child: Text(
                "No available properties found",
                style: AppTextstyle.propertyMediumTextstyle(
                  context,
                  fontColor: AppColors.opacitygreyColor,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(12.w),
            itemCount: propertyList.length,
            itemBuilder: (context, index) {
              final PropertyModel property = propertyList[index];

              return PropertyContainer(
                text: 'Available',
                textColor: AppColors.white,
                color: Colors.green,

                // 👉 Navigate to property details
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) =>
                  //         PropertyDetailsScreen(property: property),
                  //   ),
                  // );

                   Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotBookedPropertyScreen(
                  userName: '',
                  property: property,
                ),
              ), //NotBookedPropertyScreen()),
            );
                },

                property: property,
              );
            },
          );
        },
      ),
    );
  }
}
