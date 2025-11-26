import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/features/auth/screens/splashscreen.dart';
import 'package:property_managment/features/auth/screens/splashscreen.dart';
import 'package:property_managment/features/auth/screens/splashscreen.dart';
import 'package:property_managment/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseService().initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // set settings
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp( const ProviderScope(child: MyApp()));
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
          home: Splashscreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  } 
}
