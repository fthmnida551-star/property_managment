// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:property_managment/core/theme/app_colors.dart';
// import 'package:property_managment/core/theme/asset_resource.dart';
// import 'package:property_managment/modelClass/property_model.dart';
// import 'package:property_managment/presentation/propertydetails/property_details/booked.dart';
// import 'package:property_managment/presentation/searching_page/filter.dart';
// import 'package:property_managment/presentation/searching_page/add_property.dart';
// import 'package:property_managment/presentation/searching_page/widget/filtering.dart';
// import 'package:property_managment/presentation/searching_page/widget/property_container.dart';
// import 'package:property_managment/widget/appbar_widget.dart';

// class Searchingpage extends StatefulWidget {
//  const Searchingpage({super.key ,required this.property,required this.userName});
//  final String userName;
//   final PropertyModel property;
//   @override
//   State<Searchingpage> createState() => _SearchingpageState();
// }

// class _SearchingpageState extends State<Searchingpage> {
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppbarWidget(
//         child: Row(
//           children: [
//             SizedBox(width: 15),
//             Text(
//               'Properties',
//               style: TextStyle(color: AppColors.white, fontSize: 21.sp,fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // searching section
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 46.h,
//                     decoration: BoxDecoration(
//                       color: AppColors.propertyContainer,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         prefixIcon: Icon(Icons.search, color: AppColors.black),
//                         hintText: 'Search',
//                         hintStyle: TextStyle(fontSize: 14.sp),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Container(
//                   height: 46.h,
//                   width: 46.w,
//                   decoration: BoxDecoration(
//                     color: AppColors.propertyContainer,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => AddProperty()),
//                       );
//                     },
//                     child: Icon(
//                       Icons.add_box_sharp,
//                       color: AppColors.greenColor,
//                       size: 35.sp,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             //↬ Filtering section
//             SizedBox(
//               height: 40.h,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => FilterSortPage(),
//                           ),
//                         );
//                       },
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(AssetResource.filteringImage),
//                           const SizedBox(width: 4),
//                           const Text(
//                             'Filter',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: AppColors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   //(FilteringContainer only takes text,it means constructor is const)
//                   FilteringContainer(
//                     text: 'Property Type',
//                     width: 121,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => FilterSortPage(),
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
//                           builder: (context) => FilterSortPage(),
//                         ),
//                       );
//                     },
//                   ),
//                   FilteringContainer(
//                     text: 'Price Per Sqf',
//                     width: 120,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => FilterSortPage(),
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
//                           builder: (context) => FilterSortPage(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             // Propert Containers
//             SizedBox(height: 15.h),
//             PropertyContainer(text: 'Booking Now'),
//             /PropertyContainer(
//               text: 'Booked',
//               textColor: AppColors.white,
//               color: AppColors.booked,
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BookedPropertyScreen(userName: widget.userName, property: widget.property,),
//                   ),
//                 );
//               }, 
//             ),
//             PropertyContainer(text: 'Booking Now'),
//             PropertyContainer(
//               text: 'Booked',
//               textColor: AppColors.white,
//               color: AppColors.booked,
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>BookedPropertyScreen(userName: widget.userName, property: widget.property,),
//                   ),
//                 );
//               }, 
//             ),

//             PropertyContainer(text: 'Booking Now'),
//           ],
//         ),
//       ),
//     );
//   }
// }
