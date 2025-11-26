import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/provider/sharepreference.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
import 'package:property_managment/features/booking/controller/booking_controllers.dart';
import 'package:property_managment/features/property/controllers/property_cntlr.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/booking/screens/button.dart';
import 'package:property_managment/features/booking/screens/booking_details.dart';
import 'package:property_managment/features/property/screens/propertydetails/property_details/booked.dart';
import 'package:property_managment/features/property/screens/searching_page/widget/property_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookedDetails extends ConsumerWidget {
  final String userName;
  final BookingModel bookedProperty;
  final PropertyModel property;

  BookedDetails({
    super.key,
    required this.userName,
    required this.bookedProperty,
    required this.property,
  });

  

  // String userRole = "";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRole = ref.watch(userRoleProvider);
    final bookingData = ref.watch(bookingProvider(bookedProperty.id));
    log('user role $userRole');
    return Scaffold(
      appBar: AppbarWidget(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.keyboard_arrow_left,
              size: 50.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ),

      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,

      //       children: [
      //         // PropertyContainer(text: 'abc', isShow: false, property:property,),
      //         PropertyContainer(
      //           text: 'Booked',
      //           textColor: AppColors.white,
      //           color: AppColors.booked,
      //           onTap: () async {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => BookedPropertyScreen(
      //                   property: property,
      //                   bookedData: bookedProperty,
      //                 ),
      //               ),
      //             );
      //           },
      //           property: property,
      //         ),

      //         SizedBox(height: 16),
      //         Row(
      //           children: [
      //             Icon(Icons.person_rounded, color: Colors.green),

      //             SizedBox(width: 8),
      //             Text(bookedProperty.name),
      //             // Text('Name\nHrishilal'),
      //           ],
      //         ),

      //         SizedBox(height: 12),

      //         Row(
      //           children: [
      //             Icon(Icons.phone_rounded, color: Colors.green),

      //             SizedBox(width: 8),
      //             Text(bookedProperty.contact),
      //             // Text('Mobile No\n+91 960592260'),
      //           ],
      //         ),

      //         SizedBox(height: 12),

      //         Row(
      //           children: [
      //             Icon(Icons.mail_rounded, color: Colors.green),

      //             SizedBox(width: 8),
      //             Text("${bookedProperty.email}"),
      //             // Text('Email\nHrishilal@gmail.com'),
      //           ],
      //         ),

      //         SizedBox(height: 12),

      //         Row(
      //           children: [
      //             Icon(Icons.calendar_month_rounded, color: Colors.green),

      //             SizedBox(width: 8),
      //             Text("${bookedProperty.date}"),
      //             // Text('Date\n2-3-2025'),
      //           ],
      //         ),

      //         SizedBox(height: 50),
      //         if (userRole == "Manager")
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               Button(
      //                 text: 'Delete',
      //                 onTap: () async {
      //                   ref
      //                       .read(bookingRepoProvider)
      //                       .deleteBooking(property.bookingid, property.id);
      //                   Navigator.pushReplacement(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => BottomNavigationWidget(
      //                         currentIndex: 1,

      //                         propertytype: [],

      //                         price: null,

      //                         sqft: null,
      //                       ),
      //                     ),
      //                   );
      //                 },
      //                 icon: Icons.delete_outline_outlined,
      //               ),

      //               Button(
      //                 text: 'Edit',
      //                 onTap: () async {
      //                   final updatedBooking = await Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => BookingDetails(
      //                         propertyId: property.id,
      //                         bookedData: bookedProperty,
      //                       ),
      //                     ),
      //                   );
      //                   if (updatedBooking != null) {
      //                     // updateBookingProperty(updatedBooking);
      //                     ref
      //                         .watch(bookingRepoProvider)
      //                         .updateBooking(
      //                           bookedProperty.id,
      //                           bookedProperty.toMap(),
      //                         );
      //                   }
      //                 },
      //                 icon: Icons.edit_outlined,
      //               ),
      //             ],
      //           ),
      //       ],
      //     ),
      //   ),
      // ),
      body: bookingData.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text("Error: $e")),
        data: (booking) {
          if (booking == null) {
            return Center(child: Text("No booking found"));
          }

          // Use updated booking data instead of bookedProperty
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PropertyContainer(
                    text: 'Booked',
                    textColor: AppColors.white,
                    color: AppColors.booked,
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookedPropertyScreen(
                            property: property,
                            bookedData: booking, // updated data
                          ),
                        ),
                      );
                    },
                    property: property,
                  ),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      Icon(Icons.person_rounded, color: Colors.green),
                      SizedBox(width: 8),
                      Text(booking.name),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(Icons.phone_rounded, color: Colors.green),
                      SizedBox(width: 8),
                      Text(booking.contact),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(Icons.mail_rounded, color: Colors.green),
                      SizedBox(width: 8),
                      Text(booking.email),
                    ],
                  ),

                  SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(Icons.calendar_month_rounded, color: Colors.green),
                      SizedBox(width: 8),
                      Text("${booking.date}"),
                    ],
                  ),

                  SizedBox(height: 50),

                  if (userRole.value == "Manager")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Button(
                          text: 'Delete',
                          onTap: () async {
                            ref
                                .read(bookingRepoProvider)
                                .deleteBooking(property.bookingid, property.id);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigationWidget(
                                  currentIndex: 1,
                                  propertytype: [],
                                  price: null,
                                  sqft: null,
                                ),
                              ),
                            );
                          },
                          icon: Icons.delete_outline_outlined,
                        ),

                        Button(
                          text: 'Edit',
                          onTap: () async {
                            final updatedBooking = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingDetails(
                                  propertyId: property.id,
                                  bookedData: booking, // updated booking
                                ),
                              ),
                            );

                            if (updatedBooking != null) {
                              ref
                                  .read(bookingRepoProvider)
                                  .updateBooking(booking.id, booking.toMap());
                            }
                          },
                          icon: Icons.edit_outlined,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
