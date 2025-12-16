// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:property_managment/core/constant/app_colors.dart';
// import 'package:property_managment/core/constant/app_textstyl.dart';
// import 'package:property_managment/core/utils/appbar_widget.dart';
// import 'package:property_managment/features/booking/controller/booking_controllers.dart';
// import 'package:property_managment/features/property/screens/propertydetails/property_details/booked.dart';
// import 'package:property_managment/features/property/screens/searching_page/widget/property_container.dart';
// import 'package:property_managment/modelClass/bookingmodel.dart';
// import 'package:property_managment/modelClass/property_model.dart';

// class BookedPropertiesPage extends ConsumerWidget {
//   final List<PropertyModel> bookedItems;

//   const BookedPropertiesPage({super.key, required this.bookedItems});

//   @override
//   Widget build(BuildContext context ,WidgetRef ref) {
//     final bookedstate= ref.watch(bookedPropertyRepoProvider);
//     log('booked  :$bookedItems');
//     return Scaffold(
//       appBar: AppbarWidget(
//         child: Padding(
//           padding: EdgeInsets.only(left: 20.w),
//           child: Text(
//             "Booked Properties",
//             style: AppTextstyle.propertyLargeTextstyle(
//               context,
//               fontColor: AppColors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ),
//       body: bookedItems.isEmpty

//           ? Center(
//               child: Text(
//                 "No booked properties found",
//                 style: AppTextstyle.propertyMediumTextstyle(
//                   context,
//                   fontColor: AppColors.opacitygreyColor,
//                 ),
//               ),
//             )
//           : ListView.builder(
//               padding: EdgeInsets.all(12.w),
//               itemCount: bookedItems.length,
//               itemBuilder: (context, index) {
//                 final item = bookedItems[index];
//                 return PropertyContainer(
//                 text: 'Booked',
//                 textColor: AppColors.white,
//                 color: AppColors.booked,
//                 onTap: () async {
//                   final bookingData = await ref
//                       .read(bookingRepoProvider)
//                       .getBooking(item.bookingid);

//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => BookedPropertyScreen(
//                         property: item,
//                         bookedData: bookingData,
//                       ),
//                     ),
//                   );
//                 },
//                 property: item,
//               );
//               },
//             ),
//     );
//   }
// }

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/app_textstyl.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/features/booking/controller/booking_controllers.dart';
import 'package:property_managment/features/property/screens/propertydetails/property_details/booked.dart';
import 'package:property_managment/features/property/screens/searching_page/widget/property_container.dart';
import 'package:property_managment/modelClass/property_model.dart';

class BookedPropertiesPage extends ConsumerWidget {
  const BookedPropertiesPage({super.key, required List bookedItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookedState = ref.watch(bookedPropertyListProvider); // FIXED

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
      body: bookedState.when(
        data: (bookedItems) {
          log("BOOKED ITEMS: $bookedItems");

          if (bookedItems.isEmpty) {
            return Center(
              child: Text(
                "No booked properties found",
                style: AppTextstyle.propertyMediumTextstyle(
                  context,
                  fontColor: AppColors.opacitygreyColor,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(12.w),
            itemCount: bookedItems.length,
            itemBuilder: (context, index) {
              final item = bookedItems[index];

              return PropertyContainer(
                text: 'Booked',
                textColor: AppColors.white,
                color: AppColors.booked,
                onTap: () async {
                  final bookingData = await ref
                      .read(bookingRepoProvider)
                      .getBooking(item.bookingid);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookedPropertyScreen(
                        property: item,
                        bookedData: bookingData,
                      ),
                    ),
                  );
                },
                property: item,
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Error: $error")),
      ),
    );
  }
}
