import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:propertymanagementapp/presentation/adduser-screen.dart';
import 'package:propertymanagementapp/presentation/dashboard/dashboard.dart';
import 'package:propertymanagementapp/widget/bottomnavigation.dart';

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
        home:AddUserScreen(),
        debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

