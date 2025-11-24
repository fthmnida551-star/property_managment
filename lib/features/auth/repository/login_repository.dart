import 'package:flutter/material.dart';
import 'package:property_managment/core/constant/firebase_const.dart';
import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
import 'package:property_managment/features/auth/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  final FirebaseService service;
  LoginRepository(this.service);
  Future<void> checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 3));

    if (!context.mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationWidget(
            currentIndex: 0,
            propertytype: [],
            price: null,
            sqft: null,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }
}