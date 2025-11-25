import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:property_managment/core/utils/cloudinary_img/picking_img.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/features/property/controllers/property_cntlr.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/property/screens/searching_page/filter.dart';
import 'package:property_managment/features/property/screens/propertydetails/property_details/booked.dart';
import 'package:property_managment/features/property/screens/searching_page/add_property.dart';
import 'package:property_managment/features/property/screens/searching_page/widget/filtering.dart';
import 'package:property_managment/features/property/screens/searching_page/widget/property_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Searchingpage extends ConsumerWidget {
  // final List<String> propertytype;
  // final RangeValues? price;
  // final RangeValues? sqft;

  Searchingpage({
    super.key,
    // required this.propertytype,
    // required this.price,
    // required this.sqft,
  });

  List<PropertyModel> propertyDetailsList = [];
  List<PropertyModel> filterPropertyDetailsList = [];
  FirebaseFirestore fdb = FirebaseFirestore.instance;
  String userRole = "";
  getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    // final Set<String> keyss = prefs.getKeys();
    userRole = prefs.getString('role') ?? "";
    log("vvvvvvvvv $userRole");
  }

  TextEditingController srchbrcntlr = TextEditingController();
  BookingModel? bookingData;

  // getPropertyBookingData(String bookingId) async {
  //   await fdb.collection("BOOKING DETAILS").doc(bookingId).get().then((value) {
  //     if (value.exists) {
  //       Map<String, dynamic> data = value.data()!;
  //       bookingData = BookingModel.fromMap(value.id, data);
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getUserRole();
  //   getAllPropertyDetailsList();
  //   getFilteredPropertyList(widget.propertytype, widget.price, widget.sqft);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final properties = ref.watch(propertyListProvider);
    final repo = ref.read(propertyRepoProvider);
    // / 🔥 SEARCH STREAM
    final query = ref.watch(searchQueryProvider);
    final search = ref.watch(searchPropertyProvider(query));


    // /// 🔥 FILTER STREAM
    // final filter = ref.watch(
    //   filteredPropertyProvider(
    //     FilterParams(types: propertytype, price: price, sqft: sqft),
    //   ),
    // );

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
                      border: Border.all(
                        width: 1,
                        color: AppColors.opacityGrey,
                      ),
                    ),
                    child: TextField(
                      controller: srchbrcntlr,
                      onChanged: (value) {
                        // if (srchbrcntlr.text.isEmpty) {
                        //   filterPropertyDetailsList = propertyDetailsList;
                          
                        // }
                        ref.read(searchQueryProvider.notifier).state = value;
                        // searchProperties(value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: AppColors.black),
                          onPressed: () {
                            // ref
                            //     .read(propertyRepoProvider)
                            //     .searchPropertiesStream(srchbrcntlr.text);
                            
                          },
                        ),

                        hintText: '    Search',
                        hintStyle: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 1.w),
                if (userRole != "Agent")
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
                          builder: (context) => FilterSortPage(initialIndex: 0),
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
                          builder: (context) => FilterSortPage(initialIndex: 1),
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
                          builder: (context) => FilterSortPage(initialIndex: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Propert Containers
            SizedBox(height: 15.h),
            // 🔥 PROPERTY LIST (Search > Filter > All)
            srchbrcntlr.text.isNotEmpty
                ? _buildList(search, context)
                : _buildList(properties, context),
            // filterPropertyDetailsList.isEmpty
            //     ? SizedBox(
            //         height: MediaQuery.of(context).size.height / 2,
            //         child: Center(
            //           child: Text(
            //             "No properties",
            //             style: TextStyle(
            //               fontSize: 30,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       )
            //     : properties.when(
            //         data: (list) => ListView.builder(
            //           shrinkWrap: true,
            //           physics: NeverScrollableScrollPhysics(),
            //           itemCount: filterPropertyDetailsList.length,
            //           itemBuilder: (context, index) {
            //             var item = filterPropertyDetailsList[index];

            //             return item.isBooked
            //                 ? PropertyContainer(
            //                     text: 'Booked',
            //                     textColor: AppColors.white,
            //                     color: AppColors.booked,
            //                     onTap: () async {
            //                       await getPropertyBookingData(item.bookingid);
            //                       Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                           builder: (context) =>
            //                               BookedPropertyScreen(
            //                                 property: item,
            //                                 bookedData: bookingData,
            //                               ),
            //                         ),
            //                       );
            //                     },
            //                     property: item,
            //                   )
            //                 : PropertyContainer(
            //                     text: "Booking Now",
            //                     property: item,
            //                   );
            //           },
            //         ),
            //         error: (e, _) => Text("Error: $e"),
            //         loading: () => Center(child: CircularProgressIndicator()),
            //       ),
          ],
        ),
      ),
    );
  }

  /// 🔥 UI builder for property list
  Widget _buildList(
    AsyncValue<List<PropertyModel>?> asyncData,
    BuildContext context,
  ) {
    return asyncData.when(
      data: (list) {
        if (list == null || list.isEmpty) {
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
                      // await getPropertyBookingData(item.bookingid);
                      await 
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
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, _) => Text("Error: $e"),
    );
  }

  // Future<void> getFilteredPropertyList(
  //   List<String> propertytype,
  //   RangeValues? price,
  //   RangeValues? sqft,
  // ) async {
  //   filterPropertyDetailsList.clear();
  //   log("entered filter function  propertytype $propertytype");

  //   try {
  //     Query baseQuery = fdb.collection("PROPERTIES");

  //     // Filter 1: Property Type
  //     if (propertytype.isNotEmpty) {
  //       baseQuery = baseQuery.where("PROPERTY TYPE", whereIn: propertytype);
  //     }

  //     log("reached here....");

  //     // Firestore limitation: only one field can have range filters
  //     // So we’ll apply PRICE range in query and handle SQFT in memory after

  //     if (price != null) {
  //       log("price ${price.start}  end ${price.end}");
  //       baseQuery = baseQuery
  //           .where("PROPERTY PRICE", isGreaterThanOrEqualTo: price.start)
  //           .where("PROPERTY PRICE", isLessThanOrEqualTo: price.end);
  //     }

  //     QuerySnapshot querySnapshot = await baseQuery
  //         .orderBy("ADDED_DATE", descending: true)
  //         .get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       log("data is not empty");

  //       for (var doc in querySnapshot.docs) {
  //         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //         PropertyModel property = PropertyModel.fromMap(data, doc.id);

  //         // Filter 2: Apply SQFT range in memory (optional)
  //         if (sqft != null) {
  //           log(
  //             "sqft ${sqft.start}  end ${sqft.end} sqft  ${data['PROPERTY SQFT']}",
  //           );
  //           double propertySqft =
  //               double.tryParse(data[" PROPERTY SQFT"].toString()) ?? 0;
  //           if (propertySqft < sqft.start || propertySqft > sqft.end) {
  //             continue; // skip if not within range
  //           }
  //         }

  //         filterPropertyDetailsList.add(property);
  //       }
  //     }

  //     log("Filtered count: ${filterPropertyDetailsList.length}");
  //   } catch (e, st) {
  //     log("error in filtering... $e");
  //     log("stacktrace: $st");
  //   }
  // }

  // void searchProperties(String query) async {
  //   if (query.isEmpty) {
  //     // getAllPropertyDetailsList();
  //     return;
  //   }

  //   final lowerQuery = query.toLowerCase();

  //   final allDocs = await fdb.collection('PROPERTIES').get();
  //   filterPropertyDetailsList = allDocs.docs
  //       .map((doc) {
  //         return PropertyModel.fromMap(doc.data(), doc.id);
  //       })
  //       .where((property) {
  //         return property.name.toLowerCase().contains(lowerQuery) ||
  //             property.location.toLowerCase().contains(lowerQuery);
  //       })
  //       .toList();
  // }
}

/////////////////////////////////////////////////////////////////////////////////////

// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:property_managment/core/constant/app_colors.dart';
// import 'package:property_managment/core/constant/asset_resource.dart';
// import 'package:property_managment/core/utils/appbar_widget.dart';
// import 'package:property_managment/features/property/controllers/property_cntlr.dart';
// import 'package:property_managment/features/property/screens/searching_page/filter.dart';
// import 'package:property_managment/features/property/screens/propertydetails/property_details/booked.dart';
// import 'package:property_managment/features/property/screens/searching_page/add_property.dart';
// import 'package:property_managment/features/property/screens/searching_page/widget/filtering.dart';
// import 'package:property_managment/features/property/screens/searching_page/widget/property_container.dart';
// import 'package:property_managment/modelClass/property_model.dart';
// import 'package:property_managment/modelClass/bookingmodel.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Searchingpage extends ConsumerStatefulWidget {
//   final List<String> propertytype;
//   final RangeValues? price;
//   final RangeValues? sqft;

//   const Searchingpage({
//     super.key,
//     required this.propertytype,
//     required this.price,
//     required this.sqft,
//   });

//   @override
//   ConsumerState<Searchingpage> createState() => _SearchingpageState();
// }

// class _SearchingpageState extends ConsumerState<Searchingpage> {
//   String userRole = "";
//   TextEditingController srchbrcntlr = TextEditingController();
//   BookingModel? bookingData;

//   FirebaseFirestore fdb = FirebaseFirestore.instance;

//   @override
//   void initState() {
//     super.initState();
//     getUserRole();
//   }

//   Future<void> getUserRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     userRole = prefs.getString('role') ?? "";
//     setState(() {});
//   }

//   Future<void> getPropertyBookingData(String bookingId) async {
//     final value =
//         await fdb.collection("BOOKING DETAILS").doc(bookingId).get();

//     if (value.exists) {
//       bookingData = BookingModel.fromMap(value.id, value.data()!);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     /// 🔥 SEARCH STREAM
//     final search = ref.watch(searchPropertyProvider(srchbrcntlr.text));

//     /// 🔥 FILTER STREAM
//     final filter = ref.watch(
//       filteredPropertyProvider(
//         FilterParams(
//           types: widget.propertytype,
//           price: widget.price,
//           sqft: widget.sqft,
//         ),
//       ),
//     );

//     return Scaffold(
//       backgroundColor: AppColors.propertyContainer,
//       appBar: AppbarWidget(
//         child: Row(
//           children: [
//             const SizedBox(width: 15),
//             Text(
//               'Properties',
//               style: TextStyle(
//                 color: AppColors.white,
//                 fontSize: 21.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),

//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 🔍 SEARCH BAR
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 46.h,
//                     decoration: BoxDecoration(
//                       color: AppColors.propertyContainer,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         width: 1,
//                         color: AppColors.opacityGrey,
//                       ),
//                     ),
//                     child: TextField(
//                       controller: srchbrcntlr,
//                       onChanged: (_) => setState(() {}),
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         suffixIcon: Icon(Icons.search),
//                         hintText: '    Search',
//                         hintStyle: TextStyle(fontSize: 14.sp),
//                       ),
//                     ),
//                   ),
//                 ),

//                 SizedBox(width: 10),

//                 if (userRole != "Agent")
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               AddProperty(from: "new", property: null),
//                         ),
//                       );
//                     },
//                     child: Icon(
//                       Icons.add_box,
//                       size: 40,
//                       color: AppColors.greenColor,
//                     ),
//                   ),
//               ],
//             ),

//             SizedBox(height: 10),

//             // 🔥 FILTER BUTTONS
//             SizedBox(
//               height: 40.h,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   FilteringContainer(
//                     text: 'Filter',
//                     width: 90,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => FilterSortPage(initialIndex: 0),
//                         ),
//                       );
//                     },
//                   ),
//                   FilteringContainer(
//                     text: 'Property Type',
//                     width: 121,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => FilterSortPage(initialIndex: 0),
//                         ),
//                       );
//                     },
//                   ),
//                   FilteringContainer(
//                     text: 'Price',
//                     width: 71,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => FilterSortPage(initialIndex: 1),
//                         ),
//                       );
//                     },
//                   ),
//                   FilteringContainer(
//                     text: 'Area sqf',
//                     width: 96,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => FilterSortPage(initialIndex: 2),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 20),

//             // 🔥 PROPERTY LIST (Search > Filter > All)
//             srchbrcntlr.text.isNotEmpty
//                 ? _buildList(search)
//                 : _buildList(filter),
//           ],
//         ),
//       ),
//     );
//   }

  // /// 🔥 UI builder for property list
  // Widget _buildList(AsyncValue<List<PropertyModel>> asyncData) {
  //   return asyncData.when(
  //     data: (list) {
  //       if (list.isEmpty) {
  //         return SizedBox(
  //           height: 300,
  //           child: Center(
  //             child: Text(
  //               "No properties",
  //               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //         );
  //       }
  //       return ListView.builder(
  //         shrinkWrap: true,
  //         physics: NeverScrollableScrollPhysics(),
  //         itemCount: list.length,
  //         itemBuilder: (_, index) {
  //           final item = list[index];

  //           return item.isBooked
  //               ? PropertyContainer(
  //                   text: 'Booked',
  //                   textColor: AppColors.white,
  //                   color: AppColors.booked,
  //                   onTap: () async {
  //                     await getPropertyBookingData(item.bookingid);
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (_) => BookedPropertyScreen(
  //                           property: item,
  //                           bookedData: bookingData,
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                   property: item,
  //                 )
  //               : PropertyContainer(
  //                   text: 'Book Now',
  //                   property: item,
  //                 );
  //         },
  //       );
  //     },
  //     loading: () => Center(child: CircularProgressIndicator()),
  //     error: (e, _) => Text("Error: $e"),
  //   );
  // }
// }
