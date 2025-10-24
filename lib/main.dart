import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/firebase_options.dart';
import 'package:property_managment/presentation/adduser-screen.dart';
import 'package:property_managment/presentation/propertydetails/property_details/booked.dart';
import 'package:property_managment/presentation/searching_page/filter.dart';
import 'package:property_managment/presentation/auth/login.dart';
import 'package:property_managment/presentation/dashboard/booked_details/booked_details.dart';
import 'package:property_managment/presentation/profile/profile.dart';
import 'package:property_managment/presentation/propertydetails/widget/popup_mssg_cntnr.dart';
import 'package:property_managment/presentation/propertydetails/propertydetails.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';

import 'package:property_managment/presentation/propertydetails/propertydetails.dart';
import 'package:property_managment/presentation/dashboard/dashboard.dart';
import 'package:property_managment/presentation/splashscreen.dart';
import 'package:property_managment/presentation/profile/users_screen.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
        home:Splashscreen() ,
        debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
