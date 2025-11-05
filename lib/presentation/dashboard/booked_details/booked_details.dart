import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/presentation/dashboard/booked_details/widget/button.dart';
import 'package:property_managment/presentation/propertydetails/booking_details.dart';
import 'package:property_managment/presentation/searching_page/widget/property_container.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';

class BookedDetails extends StatelessWidget {
 final String userName;
  final BookingModel bookedProperty;
  final PropertyModel property;
  const BookedDetails({super.key, required this.userName,  required this.bookedProperty, required this.property});
  @override
  Widget build(BuildContext context) {
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

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              PropertyContainer(text: 'abc', isShow: false, property:property,),

              SizedBox(height: 16),

              Row(
                children: [
                  Icon(Icons.person_rounded, color: Colors.green),

                  SizedBox(width: 8),
                  Text("${bookedProperty.name}"),
                  // Text('Name\nHrishilal'),
                ],
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.phone_rounded, color: Colors.green),

                  SizedBox(width: 8),
                   Text("${bookedProperty.contact}"),
                  // Text('Mobile No\n+91 960592260'),
                ],
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.mail_rounded, color: Colors.green),

                  SizedBox(width: 8),
                  Text("${bookedProperty.email}"),
                  // Text('Email\nHrishilal@gmail.com'),
                ],
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.calendar_month_rounded, color: Colors.green),

                  SizedBox(width: 8),
                   Text("${bookedProperty.date}"),
                  // Text('Date\n2-3-2025'),
                ],
              ),

              SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    text: 'Delete',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BottomNavigationWidget(currentIndex: 1),
                        ),
                      );
                    },
                    icon: Icons.delete_outline_outlined,
                  ),
                  Button(
                    text: 'Edit',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetails(),
                        ),
                      );
                    },
                    icon: Icons.edit_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
