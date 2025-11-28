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
      ref.read(loginRepositoryProvider).checkLoginStatus(context);
    });
    //checkLoginStatus();
  }
  @override
  Widget build(BuildContext context) {
    final repo=ref.read(loginRepositoryProvider);
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: Center(
        child: SvgPicture.asset(AssetResource.logo),
      ),   
    );
  }
}


