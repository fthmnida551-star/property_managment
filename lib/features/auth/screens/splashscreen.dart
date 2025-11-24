import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/features/auth/controller/login_controller.dart';

class Splashscreen extends ConsumerStatefulWidget {
  const Splashscreen({super.key});

  @override
  ConsumerState<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends ConsumerState<Splashscreen> {

  @override
  void initState() {
    super.initState();
     Future.microtask(() {
      ref.read(LoginRepositoryProvider).checkLoginStatus(context);
    });
    //checkLoginStatus();
  }

//   // ✅ Function to check if the user is already logged in
//   Future<void> checkLoginStatus() async {
//     final prefs = await SharedPreferences.getInstance();
//     final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//     // Add delay for splash animation
//     await Future.delayed(const Duration(seconds: 3));
// log("eeeeeeeeeeeeeeeeeeeee $isLoggedIn   mounted $mounted");
//     if (!mounted) return;

//     if (isLoggedIn) {
//       // ✅ If user is logged in, go to BottomNavigationWidget
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BottomNavigationWidget(
//             currentIndex: 0,
//             propertytype: [],
//             price: null,
//             sqft: null,
            
//           ),
//         ),
//       );
//     } else {
//       // 🔑 If not logged in, go to LoginPage
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     }
//   }

  // ✅ The required build() method — this fixes your error!
  @override
  Widget build(BuildContext context) {
    final repo=ref.read(LoginRepositoryProvider);
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: Center(
        child: SvgPicture.asset(AssetResource.logo),
      ),   
    );
  }
}


