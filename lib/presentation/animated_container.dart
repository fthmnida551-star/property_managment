import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';

class GrowContainer extends StatefulWidget {
  const GrowContainer({super.key});

  @override
  State<GrowContainer> createState() => _GrowContainerState();
}

class _GrowContainerState extends State<GrowContainer> {
  double _size = 0; // start from a point

  @override
  void initState() {
    super.initState();
    // Start animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _size = 100; // final size
      });
    });
    Future.delayed(const Duration(seconds: 8), () {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationWidget(currentIndex: 0),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
              ? Center(child: SizedBox(child: Image.asset(AssetResource.tick)))
              : null,
        ),
      ),
    );
  }
}
