import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/presentation/dashboard/booked_details/widget/button.dart';
import 'package:property_managment/presentation/propertydetails/booking_details.dart';
import 'package:property_managment/presentation/searching_page/widget/property_container.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';

class BookedDetails extends StatelessWidget {
  const BookedDetails({super.key});

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
              PropertyContainer(text: 'abc', isShow: false),

              SizedBox(height: 16),

              Row(
                children: [
                  Icon(Icons.person_rounded, color: Colors.green),

                  SizedBox(width: 8),

                  Text('Name\nHrishilal'),
                ],
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.phone_rounded, color: Colors.green),

                  SizedBox(width: 8),

                  Text('Mobile No\n+91 960592260'),
                ],
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.mail_rounded, color: Colors.green),

                  SizedBox(width: 8),

                  Text('Email\nHrishilal@gmail.com'),
                ],
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.calendar_month_rounded, color: Colors.green),

                  SizedBox(width: 8),

                  Text('Date\n2-3-2025'),
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
