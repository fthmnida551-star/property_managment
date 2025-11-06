import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/presentation/auth/login.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // ✅ Function to check if the user is already logged in
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Add delay for splash animation
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    if (isLoggedIn) {
      // ✅ If user is logged in, go to BottomNavigationWidget
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationWidget(
            currentIndex: 0,
            propertytype: [],
            price: null,
            sqft: null,
            loginUser: null,
          ),
        ),
      );
    } else {
      // 🔑 If not logged in, go to LoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  // ✅ The required build() method — this fixes your error!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: Center(
        child: SvgPicture.asset(AssetResource.logo),
      ),   
    );
  }
}
