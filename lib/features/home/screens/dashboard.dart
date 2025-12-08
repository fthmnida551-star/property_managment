import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/app_textstyl.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
import 'package:property_managment/features/home/controller/dashboard_controller.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/logout_alert.dart';
import 'package:property_managment/features/users/screens/users_screen.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/home/screens/widget/bookingcontainer.dart';
import 'package:property_managment/features/home/screens/widget/container_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class DashboardScreen extends ConsumerStatefulWidget {
  DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final FirebaseFirestore fdb = FirebaseFirestore.instance;

  List<BookingModel> bookedDetails = [];

  List<String> themelist = ["Light", "Dark"];

  PropertyModel? property;

  String profilePic = "";
  String userNme = "";
  String userRole = "";

  getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    profilePic = prefs.getString("profilepic") ?? "";
    userNme = prefs.getString("name") ?? "";
    userRole = prefs.getString("role") ?? "";
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    final bookedAsync = ref.watch(bookedpropertyListProvider);
    final propertyCountAsync = ref.watch(propertyListProvider);
    final bookedcountAsync = ref.watch(bookedListProvider);
    final total = ref.watch(propertyListProvider).value ?? 0;
    final booked = ref.watch(bookedListProvider).value ?? 0;
    final vacant = (total - booked) < 0 ? 0 : (total - booked);
   

    return Scaffold(
      // backgroundColor: Colors.white,
      extendBody: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.greenColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: profilePic.isNotEmpty
                        ? Image.network(profilePic)
                        : Icon(Icons.person),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userNme,
                    style: AppTextstyle.propertyMediumTextstyle(context),
                  ),
                  Text(
                    userRole,
                    style: AppTextstyle.propertyMediumTextstyle(context),
                  ),
                 
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "My profile",
                style: AppTextstyle.propertyMediumTextstyle(
                  context,
                  fontColor: AppColors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationWidget(
                      currentIndex: 3,
                      propertytype: [],
                      price: null,
                      sqft: null,
                    ),
                  ),
                );
              },
            ),
            Divider(color: AppColors.black, thickness: 0.6),
            ListTile(
              leading: Icon(Icons.supervised_user_circle_sharp),
              title: Text(
                "Users",
                style: AppTextstyle.propertyMediumTextstyle(
                  context,
                  fontColor: AppColors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsersScreen()),
                );
              },
            ),
            Divider(color: AppColors.black, thickness: 0.6),
            ListTile(
              leading: Icon(Icons.bookmark_added_rounded),
              title: Text(
                "Booked Properties",
                style: AppTextstyle.propertyMediumTextstyle(
                  context,
                  fontColor: AppColors.black,
                ),
              ),
              onTap: () {},
            ),
            Divider(color: AppColors.black, thickness: 0.6),
            ListTile(
              leading: Icon(Icons.note_add),
              title: Text(
                "Non Booked Poperties",
                style: AppTextstyle.propertyMediumTextstyle(
                  context,
                  fontColor: AppColors.black,
                ),
              ),
              onTap: () {},
            ),
            Divider(color: AppColors.black, thickness: 0.6),
            ListTile(
              leading: Icon(Icons.notifications_active),
              title: Text(
                "Notifications",
                style: AppTextstyle.propertyMediumTextstyle(
                  context,
                  fontColor: AppColors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationWidget(
                      currentIndex: 2,
                      propertytype: [],
                      price: null,
                      sqft: null,
                    ),
                  ),
                );
              },
            ),
            Divider(
              thickness: 0.6,
              color: AppColors.black,
            ),
            // Divider(color: AppColors.black, thickness: 0.6),
            // ListTile(
            //   leading: Icon(Icons.dark_mode),
            //   title: Text("Theme"),
            //   subtitle: Text(
            //     isDark ? "Dark" : "Light",
            //     style: Theme.of(context).textTheme.bodySmall,
            //   ),

            //   // style: AppTextstyle.propertyMediumTextstyle(
            //   //   context,
            //   //   fontColor: AppColors.black,
            //   // ),
            //   onTap: () {
            //     showThemePop(context);
            //   },
            // ),
            SizedBox(height: 140),
            InkWell(
              onTap: () {
                logoutAlert(context);
              },
              child: Center(
                child: Container(
                  width: 120,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.redcolor),borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: AppColors.redcolor),
                      SizedBox(width: 10,),
                      Text(
                        "Logout",
                        style: AppTextstyle.propertyMediumTextstyle(
                          context,
                          fontColor: AppColors.redcolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppbarWidget(
        height: MediaQuery.of(context).size.height * .12,
        child: Row(
          children: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(Icons.menu),
                color:Colors.blueGrey.shade100,
                iconSize: 30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AssetResource.appLogo),
                Text(
                  'Property Mangement',
                  style: AppTextstyle.propertyMediumTextstyle(
                    context,
                    fontColor: AppColors.black,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ContainerWidget(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(AssetResource.booked),
                          SizedBox(height: 5),
                          Text(
                            'Booked',
                            style: AppTextstyle.propertyMediumTextstyle(
                              context,
                              fontColor: AppColors.black,
                            ),
                          ),

                          SizedBox(height: 5),

                          bookedcountAsync.when(
                            data: (count) => Text(
                              '$count',
                              style: AppTextstyle.propertyLargeTextstyle(
                                context,
                                fontColor: AppColors.greenColor,
                              ),
                            ),
                            loading: () => const Text("..........."),
                            error: (e, s) => Text(
                              "0",
                              style: AppTextstyle.propertyLargeTextstyle(
                                context,
                                fontColor: AppColors.redcolor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.w)),
                ContainerWidget(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(AssetResource.vacant),
                        SizedBox(height: 5),
                        Text(
                          'vacant',
                          style: AppTextstyle.propertyMediumTextstyle(
                            context,
                            fontColor: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '$vacant',
                          style: AppTextstyle.propertyLargeTextstyle(
                            context,
                            fontColor: AppColors.redcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: ContainerWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigationWidget(
                        currentIndex: 1,
                        propertytype: [],
                        price: null,
                        sqft: null,
                      ),
                    ),
                  );
                },
                height: 70.h,
                width: 350.w,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SvgPicture.asset(AssetResource.totalproperty),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Total Properties',
                        style: AppTextstyle.propertyMediumTextstyle(
                          context,
                          fontColor: AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: propertyCountAsync.when(
                        data: (count) => Text(
                          "$count",
                          style: AppTextstyle.propertyLargeTextstyle(
                            context,
                            fontColor: AppColors.yellowcolor,
                          ),
                        ),
                        loading: () => CircularProgressIndicator(),
                        error: (e, s) => Text(
                          "0",
                          style: AppTextstyle.propertyLargeTextstyle(
                            context,
                            fontColor: AppColors.redcolor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.h),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Recent Booking',
                    style: AppTextstyle.propertyLargeTextstyle(
                      context,
                      fontWeight: FontWeight.bold,
                      fontColor: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),

            Expanded(
              child: bookedAsync.when(
                data: (bookedList) {
                  if (bookedList.isEmpty) {
                    return const Center(child: Text("No bookings available"));
                  }

                  return ListView.builder(
                    itemCount: bookedList.length,
                    itemBuilder: (context, index) {
                      final booking = bookedList[index];

                      final propertyAsync = ref.watch(
                        propertyByIdProvider(booking.propertyId),
                      );

                      return propertyAsync.when(
                        data: (property) {
                          if (property == null) return SizedBox.shrink();

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BookingConatainerWidget(
                              bookedProperty: booking,
                              property: property,
                            ),
                          );
                        },
                        loading: () => SizedBox(),
                        error: (e, s) => Text("Error loading property"),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Center(child: Text("Error loading bookings")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
