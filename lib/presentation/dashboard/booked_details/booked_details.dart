// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:property_managment/core/constant/app_colors.dart';
// import 'package:property_managment/core/utils/appbar_widget.dart';
// import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
// import 'package:property_managment/features/property/screens/propertydetails/booking_details.dart';
// import 'package:property_managment/features/property/screens/propertydetails/property_details/booked.dart';
// import 'package:property_managment/features/property/screens/searching_page/widget/property_container.dart';
// import 'package:property_managment/modelClass/bookingmodel.dart';
// import 'package:property_managment/modelClass/property_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../features/booking/screens/button.dart';

// class BookedDetails extends StatefulWidget {
//   final String userName;
//   final BookingModel bookedProperty;
//   final PropertyModel property;

//   BookedDetails({
//     super.key,
//     required this.userName,
//     required this.bookedProperty,
//     required this.property,
//   });

//   @override
//   State<BookedDetails> createState() => _BookedDetailsState();
// }

// class _BookedDetailsState extends State<BookedDetails> {
//   FirebaseFirestore fdb = FirebaseFirestore.instance;

//   String userRole = "";

//   Future<void>getUserRole() async {
//     final prefs = await SharedPreferences.getInstance();
    
//     userRole = prefs.getString("role") ?? "";
//     log("saveuserrole$userRole");
//     setState(() {
      
//     });
//   }
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getUserRole();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppbarWidget(
//         child: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Icon(
//               Icons.keyboard_arrow_left,
//               size: 50.sp,
//               color: AppColors.white,
//             ),
//           ),
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,

//             children: [
//               // PropertyContainer(text: 'abc', isShow: false, property:property,),
//               PropertyContainer(
//                 text: 'Booked',
//                 textColor: AppColors.white,
//                 color: AppColors.booked,
//                 onTap: () async{
                  
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           BookedPropertyScreen(property: widget.property, bookedData: widget.bookedProperty,),
//                     ),
//                   );
//                 },
//                 property: widget.property,
//               ),

//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   Icon(Icons.person_rounded, color: Colors.green),

//                   SizedBox(width: 8),
//                   Text(widget.bookedProperty.name),
//                   // Text('Name\nHrishilal'),
//                 ],
//               ),

//               SizedBox(height: 12),

//               Row(
//                 children: [
//                   Icon(Icons.phone_rounded, color: Colors.green),

//                   SizedBox(width: 8),
//                   Text(widget.bookedProperty.contact),
//                   // Text('Mobile No\n+91 960592260'),
//                 ],
//               ),

//               SizedBox(height: 12),

//               Row(
//                 children: [
//                   Icon(Icons.mail_rounded, color: Colors.green),

//                   SizedBox(width: 8),
//                   Text("${widget.bookedProperty.email}"),
//                   // Text('Email\nHrishilal@gmail.com'),
//                 ],
//               ),

//               SizedBox(height: 12),

//               Row(
//                 children: [
//                   Icon(Icons.calendar_month_rounded, color: Colors.green),

//                   SizedBox(width: 8),
//                   Text("${widget.bookedProperty.date}"),
//                   // Text('Date\n2-3-2025'),
//                 ],
//               ),

//               SizedBox(height: 50),
//               if (userRole =="Manager")
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Button(
//                     text: 'Delete',
//                     onTap: () async {
//                       deleteBookingProperty(
//                         widget.property.bookingid,
//                         widget.property.id,
//                       ); // pass the booking document ID

//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BottomNavigationWidget(
//                             currentIndex: 1,
                           
//                             propertytype: [],
                           
//                             price: null,
                           
//                             sqft: null,
                          
//                           ),
//                         ),
//                       );
//                     },
//                     icon: Icons.delete_outline_outlined,
//                   ),

//                   // Button(
//                   //   text: 'Delete',
//                   //   onTap: () {
//                   //     deleteBookingProperty()

//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (context) =>
//                   //             BottomNavigationWidget(currentIndex: 1),
//                   //       ),
//                   //     );
//                   //   },
//                   //   icon: Icons.delete_outline_outlined,
//                   // ),
//                   // Button(
//                   //   text: 'Edit',
//                   //   onTap: () {
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (context) => BookingDetails(),
//                   //       ),
//                   //     );
//                   //   },
//                   //   icon: Icons.edit_outlined,
//                   // ),
//                   Button(
//                     text: 'Edit',
//                     onTap: () async {
//                       final updatedBooking = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BookingDetails(
                            
//                             propertyId: widget.property.id, bookedData: widget.bookedProperty,
                            
//                           ),
//                         ),
//                       );
//                       if (updatedBooking != null) {
//                         // updateBookingProperty(updatedBooking);
//                       }
//                     },
//                     icon: Icons.edit_outlined,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<BookingModel?> getBooking(String bookingId) async {
//     try {
//       DocumentSnapshot<Map<String, dynamic>> doc = await fdb
//           .collection('BOOKING')
//           .doc(bookingId)
//           .get();

//       if (doc.exists && doc.data() != null) {
//         // Merge Firestore ID with document data
//         final data = doc.data()!;
//         data['id'] = doc.id;
//         return BookingModel.fromMap( doc.id,data);
//       } else {
//         print("No property found for ID: $bookingId");
//         return null;
//       }
//     } catch (e) {
//       print("Error fetching property: $e");
//       return null;
//     }
//   }

//   void updateBookingProperty(BookingModel Updatedetails) async {
//     final DocumentReference<Map<String, dynamic>> documentRef = fdb
//         .collection("BOOKING DETAILS")
//         .doc(Updatedetails.id);
//     await documentRef
//         .update(Updatedetails.toMap())
//         .then((value) {
//           log("Updated successfully");
//         })
//         .onError((e, stack) {
//           log("Error is $e");
//         });
//   }

//   void deleteBookingProperty(String bookingId, String propertyId) async {
//     await fdb.collection("BOOKING DETAILS").doc(bookingId).delete();
//     await fdb.collection('PROPERTIES').doc(propertyId).update({
//       'IS_BOOKED': 'NO',
//     });
//     await fdb.collection('PROPERTIES').doc(propertyId).set({
//       "BOOKING_ID": FieldValue.delete(),
//     }, SetOptions(merge: true));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/features/property/controllers/property_cntlr.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/booking/screens/button.dart';
import 'package:property_managment/features/property/screens/propertydetails/booking_details.dart';
import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
import 'package:riverpod/src/framework.dart';

class BookedPropertyScreen extends ConsumerWidget {
  final PropertyModel property;
  final BookingModel? bookedData;

  const BookedPropertyScreen({
    super.key,
    required this.property,
    required this.bookedData,
  });

  ProviderListenable? get bookingRepositoryProvider => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRoleAsync = ref.watch(userRoleProvider);

    return userRoleAsync.when(
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text("Error: $e"))),
      data: (userRole) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                 
                  if (property.propertyType == 'APARTMENT' ||
                      property.propertyType == 'VILLA')
                    buildBookedSection(context, ref, userRole),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildBookedSection(BuildContext context, WidgetRef ref, String userRole) {
    final bookingRepo = ref.read(bookingRepositoryProvider!);

    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Column(
        children: [
          // Your UI text/date here...

          if (userRole != "Agent")
            Row(
              children: [
                Button(
                  width: 150,
                  height: 40,
                  text: 'Delete',
                  icon: Icons.delete,
                  onTap: () async {
                    await bookingRepo.deleteBooking(
                      bookingId: property.bookingid,
                      propertyId: property.id,
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BottomNavigationWidget(
                          currentIndex: 1,
                          propertytype: [],
                          price: null,
                          sqft: null,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 10),
                Button(
                  width: 150,
                  height: 40,
                  text: 'Edit',
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingDetails(
                          propertyId: property.id,
                          bookedData: bookedData,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
