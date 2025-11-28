import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/core/provider/sharepreference.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/features/booking/controller/booking_controllers.dart';
import 'package:property_managment/features/property/controllers/property_cntlr.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/property/screens/searching_page/filter.dart';
import 'package:property_managment/features/property/screens/propertydetails/property_details/booked.dart';
import 'package:property_managment/features/property/screens/searching_page/add_property.dart';
import 'package:property_managment/features/property/screens/searching_page/widget/filtering.dart';
import 'package:property_managment/features/property/screens/searching_page/widget/property_container.dart';

class Searchingpage extends ConsumerWidget {
  Searchingpage({super.key});

  List<PropertyModel> propertyDetailsList = [];
  List<PropertyModel> filterPropertyDetailsList = [];
  FirebaseFirestore fdb = FirebaseFirestore.instance;

  TextEditingController srchbrcntlr = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertyListProvider);
    final repo = ref.read(propertyRepoProvider);
    final list = ref.watch(localFilteredListProvider);
    final userRole = ref.watch(userRoleProvider);
    log('user role $userRole');
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
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(searchProvider.notifier).state = "";
          ref.read(filterProvider.notifier).state = "All";
          ref.read(typeFilterProvider.notifier).state = null;
          ref.read(priceFilterProvider.notifier).state = null;
          ref.read(sqftFilterProvider.notifier).state = null;
          ref.refresh(propertyListProvider);
          srchbrcntlr.clear();
        },
        child: SingleChildScrollView(
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
                        border: Border.all(
                          width: 1,
                          color: AppColors.opacityGrey,
                        ),
                      ),
                      child: TextField(
                        controller: srchbrcntlr,
                        onChanged: (value) {
                          ref.read(searchProvider.notifier).state = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.opacityGrey,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.opacityGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.w),
                  if (userRole.value == "Staff" || userRole.value =="Manager")
                    Container(
                      height: 46.h,
                      width: 46.w,
                      decoration: BoxDecoration(
                        color: AppColors.propertyContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          // pickAndUpload();
                          ref.read(propertyFormProvider.notifier).clear();
                          ref.read(propertyImagesProvider.notifier).clear();
                          ref.read(isOwnPropertyProvider.notifier).state =
                              false;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddProperty(from: 'new', property: null),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add_box_sharp,
                          color: AppColors.greenColor,
                          size: 50.sp,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 10),

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
                              builder: (context) =>
                                  FilterSortPage(initialIndex: 0),
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
                            builder: (context) =>
                                FilterSortPage(initialIndex: 0),
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
                            builder: (context) =>
                                FilterSortPage(initialIndex: 1),
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
                            builder: (context) =>
                                FilterSortPage(initialIndex: 2),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Propert Containers
              SizedBox(height: 15.h),

              _buildList(list, context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(
    List<PropertyModel> list,
    BuildContext context,
    WidgetRef ref,
  ) {
    if (list.isEmpty) {
      return SizedBox(
        height: 300,
        child: Center(
          child: Text(
            "No properties",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        final item = list[index];

        return item.isBooked
            ? PropertyContainer(
                text: 'Booked',
                textColor: AppColors.white,
                color: AppColors.booked,
                onTap: () async {
                  log("item.isBooked ${item.isBooked} bbb ${item.bookingid}");
                  // await getPropertyBookingData(item.bookingid);
                  // ref.watch(bookingProvider.from()).
                  // final bookingData = await ref.read(
                  //   bookingProvider(item.bookingid),
                  // );

                  final bookingData = await ref
                      .read(bookingRepoProvider)
                      .getBooking(item.bookingid);

                  log("bookingData ${bookingData}");
                  Future.delayed(Duration(seconds: 5), () {
                    
                  });
                  log("bookingData1111 ${bookingData}");

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookedPropertyScreen(
                          property: item,
                          bookedData: bookingData,
                        ),
                      ),
                    );
                },
                property: item,
              )
            : PropertyContainer(text: 'Book Now', property: item);
      },
    );
  }
}
