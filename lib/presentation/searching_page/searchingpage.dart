import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/presentation/propertydetails/property_details/booked.dart';
import 'package:property_managment/presentation/searching_page/filter.dart';
import 'package:property_managment/presentation/searching_page/add_property.dart';
import 'package:property_managment/presentation/searching_page/widget/filtering.dart';
import 'package:property_managment/presentation/searching_page/widget/property_container.dart';
import 'package:property_managment/widget/appbar_widget.dart';

class Searchingpage extends StatefulWidget {
  // final BookingModel bookedProperty;
  const Searchingpage({super.key});

  @override
  State<Searchingpage> createState() => _SearchingpageState();
}

class _SearchingpageState extends State<Searchingpage> {
  List<PropertyModel> propertyDetailsList = [];
  FirebaseFirestore fdb = FirebaseFirestore.instance;

  TextEditingController srchbrcntlr = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllPropertyDetailsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.propertyContainer,
      appBar: AppbarWidget(
        child: Row(
          children: [
            SizedBox(width: 15),
            Text(
              'Properties',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 21.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // searching section
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: AppColors.propertyContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: srchbrcntlr,
                      //                      onChanged: (value) {
                      //   searchProperties(value);
                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: AppColors.black),
                          onPressed: () {
                            searchProperties(srchbrcntlr.text);
                          },
                        ),

                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  height: 46.h,
                  width: 46.w,
                  decoration: BoxDecoration(
                    color: AppColors.propertyContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddProperty()),
                      );
                    },
                    child: Icon(
                      Icons.add_box_sharp,
                      color: AppColors.greenColor,
                      size: 35.sp,
                    ),
                  ),
                ),
              ],
            ),
            //↬ Filtering section
            SizedBox(
              height: 40.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilterSortPage(),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AssetResource.filteringImage),
                          const SizedBox(width: 4),
                          const Text(
                            'Filter',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //(FilteringContainer only takes text,it means constructor is const)
                  FilteringContainer(
                    text: 'Property Type',
                    width: 121,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterSortPage(),
                        ),
                      );
                    },
                  ),
                  FilteringContainer(
                    text: 'Price',
                    width: 71,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterSortPage(),
                        ),
                      );
                    },
                  ),
                  FilteringContainer(
                    text: 'Area sqf',
                    width: 96,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilterSortPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Propert Containers
            SizedBox(height: 15.h),
            propertyDetailsList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: Text(
                        "No properties",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: propertyDetailsList.length,
                    itemBuilder: (context, index) {
                      var item = propertyDetailsList[index];

                      return item.isBooked
                          ? PropertyContainer(
                              text: 'Booked',
                              textColor: AppColors.white,
                              color: AppColors.booked,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookedPropertyScreen(property: item),
                                  ),
                                );
                              },
                              property: item,
                            )
                          : PropertyContainer(
                              text: "Booking Now",
                              property: item,
                            );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void getAllPropertyDetailsList() async {
    propertyDetailsList.clear();

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await fdb
          .collection('PROPERTIES')
          .get();

      for (var element in querySnapshot.docs) {
        // final String id = element.id;
        final Map<String, dynamic> data = element.data();
        data.keys.forEach((element) => log(element));
        log("Document keys: ${data.keys}");
        log("jjjjjjjjjj ${data['PROPERTY PRICE']}");
        log("jghjfhfgjh ${(data[' BHK'] is int) ? 1111 : 666}");

        // Make sure PropertyModel.fromJson can handle the ID
        propertyDetailsList.add(PropertyModel.fromMap(data));
      }

      setState(() {}); // Refresh the UI
    } catch (e) {
      debugPrint("Error fetching property details: $e");
    }
    // propertyDetailsList.notifyListeners();
  }

  void searchProperties(String query) async {
    if (query.isEmpty) {
      getAllPropertyDetailsList();
      return;
    }

    final lowerQuery = query.toLowerCase();

    final allDocs = await fdb.collection('PROPERTIES').get();
    propertyDetailsList = allDocs.docs
        .map((doc) {
          return PropertyModel.fromMap(doc.data());
        })
        .where((property) {
          return property.name.toLowerCase().contains(lowerQuery) ||
              property.location.toLowerCase().contains(lowerQuery);
        })
        .toList();

    setState(() {});
  }
}
