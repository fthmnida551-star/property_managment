import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/presentation/adduser-screen.dart';
import 'package:property_managment/presentation/auth/filter.dart';
import 'package:property_managment/presentation/auth/login.dart';
import 'package:property_managment/presentation/propertydetails/propertydetails.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';




import 'package:property_managment/presentation/propertydetails/propertydetails.dart';







void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        390,
        844,
      ), // base width & height of your design (e.g. iPhone X)
      minTextAdapt: true, // text scales with system font
      splitScreenMode: true, // handles tablet split screen
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home:PropertydetailsScreen(),
        );
      },
    );
  }
}
