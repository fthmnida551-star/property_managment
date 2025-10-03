import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/presentation/booking_details.dart';
import 'package:property_managment/presentation/searching_page/searchingpage.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // base design size (width, height)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
        home:BottomNavigationWidget(), 
        debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}