import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertymanagementapp/core/asset_resources.dart';
import 'package:propertymanagementapp/core/theme/app_colors.dart';
import 'package:propertymanagementapp/presentation/dashboard/dashboard.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  final List<Widget> _pages = const [
    DashboardScreen(),
    Center(child: Text('Search page')),
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
            child: ValueListenableBuilder<int>(
              valueListenable: _currentIndex,
              builder: (context, index, _) {
                return BottomNavigationBar(
                  currentIndex: index,
                  onTap: (newIndex) => _currentIndex.value = newIndex,
                  backgroundColor: AppColors.greencolor,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset(
                          
                          AssetResources.home,
                          colorFilter: ColorFilter.mode(
                            index == 0 ? Colors.white : Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset(
                          AssetResources.search,
                          colorFilter: ColorFilter.mode(
                            index == 1 ? Colors.white : Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset(
                          AssetResources.notification,
                          colorFilter: ColorFilter.mode(
                            index == 2 ? Colors.white : Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset(
                          AssetResources.profile,
                          colorFilter: ColorFilter.mode(
                            index == 3 ? Colors.white : Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      label: '',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
