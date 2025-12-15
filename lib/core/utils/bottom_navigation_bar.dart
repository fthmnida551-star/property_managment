import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/features/home/screens/dashboard.dart';
import 'package:property_managment/features/notification/screens/notificationscreen.dart';
import 'package:property_managment/features/profile/screens/profile.dart';
import 'package:property_managment/features/property/screens/searching_page/searchingpage.dart';

class BottomNavigationWidget extends StatefulWidget {
  int currentIndex;

  List <String> propertytype;
  RangeValues? price;
  RangeValues? sqft;

  BottomNavigationWidget({super.key, required this.currentIndex,required this.propertytype,required this.price,required this.sqft ,});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  // final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  List<Widget> get _pages => [
    Center(child: DashboardScreen()),
    Center(child: Searchingpage()),//propertytype: widget.propertytype, price: widget.price,sqft: widget.sqft,)),
    Center(child: Notificationscreen()),
    Center(child: Profilescreen()),
  ];

  @override
  void dispose() {
    // _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: _pages[widget.currentIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BottomNavigationBar(
              currentIndex: widget.currentIndex,
              onTap: (newIndex) {
                setState(() {
                  widget.currentIndex = newIndex;
                });
              },
              backgroundColor: AppColors.greenColor,
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color.fromARGB(130, 0, 0, 0),
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    // child: SvgPicture.asset(AssetResource.home),
                    child: Icon(Icons.home_outlined),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    // child: SvgPicture.asset(AssetResource.search),
                    child: Icon(Icons.search),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    // child: SvgPicture.asset(AssetResource.notification),
                    child: Icon(Icons.notifications_outlined),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    // child: SvgPicture.asset(AssetResource.profile),
                    child: Icon(Icons.person_outline),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
