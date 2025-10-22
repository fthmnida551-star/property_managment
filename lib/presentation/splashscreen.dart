import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
double _size = 0; // start from a point

  @override
  void initState() {
    super.initState();
    // Start animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _size = 200; // final size
      });
    });
    Future.delayed(const Duration(seconds: 8), () {
      if (!mounted) return;
    //   // Navigator.push(
    //   //   context,
    //   //   MaterialPageRoute(
    //   //     ,
    //   //   ),
    //   );
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.greenColor,
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 7),
          curve: Curves.easeOutBack, // smooth and bouncy growth
          width: _size,
          height: _size,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child:
              _size >
                  50 // show text only after it starts expanding
              ? Center(child: SizedBox(child:SvgPicture.asset(AssetResource.logo)))
              : null,
        ),
      ),
    );
  }
}
