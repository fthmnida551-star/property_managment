import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/presentation/animated_container.dart';


import 'package:property_managment/presentation/booking_details.dart';
import 'package:property_managment/presentation/notification_screen/notificationscreen.dart';
import 'package:property_managment/presentation/propertydetails/propertydetails.dart';
import 'package:property_managment/presentation/searching_page/add_landlord_details.dart';
import 'package:property_managment/presentation/searching_page/add_property.dart';
import 'package:property_managment/presentation/searching_page/searchingpage.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';
import 'package:property_managment/widget/date_picker.dart';

import 'presentation/propertydetails/propertydetails.dart';

import 'package:property_managment/presentation/dashboard/dashboard.dart';
import 'package:property_managment/presentation/users_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
        home:BottomNavigationWidget(currentIndex: 0,), 
        debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}