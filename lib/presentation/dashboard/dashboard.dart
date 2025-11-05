import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/app_textstyl.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/presentation/dashboard/widget/bookingcontainer.dart';
import 'package:property_managment/presentation/dashboard/widget/container_widget.dart';
import 'package:property_managment/widget/appbar_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int totalproperty = 0;
  int bookedproperty = 0;
  int vacantproperty = 0;
  List<BookingModel> bookedDetails = [];

  Future<int> getUserCount() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('PROPERTIES')
          .get();

      int count = snapshot.size;
      print('Total properties: $count');
      return count;
    } catch (e) {
      print('Error getting user count: $e');
      return 0;
    }
  }

  Future<int> getBookedCount() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('BOOKING DETAILS')
          .get();

      int count = snapshot.size;
      print('Booked: $count');
      return count;
    } catch (e) {
      print('Error getting booked count: $e');
      return 0;
    }
  }
  //  
Future<void> getBookedProperty() async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('BOOKING DETAILS')
        .get();

    print('Docs count: ${snapshot.docs.length}');

    // Temporary list to store fetched data
    List<BookingModel> tempList = [];

    for (var element in snapshot.docs) {
      final String id = element.id;
      final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      tempList.add(BookingModel.fromMap(data, id));
    }

    // ✅ Update state once with all fetched data
    setState(() {
      bookedDetails = tempList;
    });

    log("Fetched booked details: ${bookedDetails.length}");
  } catch (e) {
    log("Error while reading booked property: $e");
  }
}




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPropertyCount();
  }

  void _loadPropertyCount() async {
    int count = await getUserCount();
    int booked = await getBookedCount();
    await  getBookedProperty();
   
  
    setState(() {
       
      totalproperty = count;
      bookedproperty = booked;
      if(totalproperty>bookedproperty)
      {vacantproperty = totalproperty - bookedproperty;}
      else{
        vacantproperty=0;
      }
    

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 30),
          child: Column(
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
                          Text(
                            '$bookedproperty',
                            style: AppTextstyle.propertyLargeTextstyle(
                              context,
                              fontColor: AppColors.greenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.w)),
                ContainerWidget(
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
                          '$vacantproperty',
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
                      child: Text(
                        "$totalproperty",
                        style: AppTextstyle.propertyLargeTextstyle(
                          context,
                          fontColor: AppColors.yellowcolor,
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
              child: ListView.builder(
                itemCount: bookedDetails.length,
                itemBuilder: (context, index) {
                   final booking = bookedDetails[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BookingConatainerWidget(bookedProperty:booking),
                    
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

