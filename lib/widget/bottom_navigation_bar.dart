import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/presentation/dashboard/dashboard.dart';
import 'package:property_managment/presentation/searching_page/searchingpage.dart';

class BottomNavigationWidget extends StatefulWidget {
  
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  final List<Widget> _pages = const [
    Center(child: DashboardScreen()),
   Center(child: Searchingpage()),
    Center(child: Text('Notification page')),
    Center(child: Text('Profile page')),
  ];

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, _) => _pages[index],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50), 
            child: BottomNavigationBar(
              currentIndex: _currentIndex.value,
              onTap: (newIndex) => _currentIndex.value = newIndex,
              backgroundColor: AppColors.greenColor,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.blueGrey,
              type: BottomNavigationBarType.fixed,
              items:  [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SvgPicture.asset(AssetResource.home),
                  ),
                  label: '',
                  
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SvgPicture.asset(AssetResource.search),
                  ),
                  label: '',
                  
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SvgPicture.asset(AssetResource.notification),
                  ),
                  label: '',
                
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SvgPicture.asset(AssetResource.profile),
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