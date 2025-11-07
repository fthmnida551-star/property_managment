import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/presentation/dashboard/booked_details/widget/button.dart';
import 'package:property_managment/presentation/propertydetails/booking_details.dart';
import 'package:property_managment/presentation/propertydetails/property_details/booked.dart';
import 'package:property_managment/presentation/searching_page/widget/property_container.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookedDetails extends StatefulWidget {
  final String userName;
  final BookingModel bookedProperty;
  final PropertyModel property;

  BookedDetails({
    super.key,
    required this.userName,
    required this.bookedProperty,
    required this.property,
  });

  @override
  State<BookedDetails> createState() => _BookedDetailsState();
}

class _BookedDetailsState extends State<BookedDetails> {
  FirebaseFirestore fdb = FirebaseFirestore.instance;

  String userRole = "";

  Future<void>getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    
    userRole = prefs.getString("role") ?? "";
    log("saveuserrole$userRole");
    setState(() {
      
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserRole();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.keyboard_arrow_left,
              size: 50.sp,
              color: AppColors.white,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // PropertyContainer(text: 'abc', isShow: false, property:property,),
              PropertyContainer(
                text: 'Booked',
                textColor: AppColors.white,
                color: AppColors.booked,
                onTap: () async{
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookedPropertyScreen(property: widget.property, bookedData: widget.bookedProperty,),
                    ),
                  );
                },
                property: widget.property,
              ),

              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.person_rounded, color: Colors.green),

                  SizedBox(width: 8),
                  Text(widget.bookedProperty.name),
                  // Text('Name\nHrishilal'),
                ],
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.phone_rounded, color: Colors.green),

                  SizedBox(width: 8),
                  Text(widget.bookedProperty.contact),
                  // Text('Mobile No\n+91 960592260'),
                ],
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.mail_rounded, color: Colors.green),

                  SizedBox(width: 8),
                  Text("${widget.bookedProperty.email}"),
                  // Text('Email\nHrishilal@gmail.com'),
                ],
              ),

              SizedBox(height: 12),

              Row(
                children: [
                  Icon(Icons.calendar_month_rounded, color: Colors.green),

                  SizedBox(width: 8),
                  Text("${widget.bookedProperty.date}"),
                  // Text('Date\n2-3-2025'),
                ],
              ),

              SizedBox(height: 50),
              if (userRole =="Manager")
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    text: 'Delete',
                    onTap: () async {
                      deleteBookingProperty(
                        widget.property.bookingid,
                        widget.property.id,
                      ); // pass the booking document ID

                      Navigator.pushReplacement(
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
                    icon: Icons.delete_outline_outlined,
                  ),

                  // Button(
                  //   text: 'Delete',
                  //   onTap: () {
                  //     deleteBookingProperty()

                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) =>
                  //             BottomNavigationWidget(currentIndex: 1),
                  //       ),
                  //     );
                  //   },
                  //   icon: Icons.delete_outline_outlined,
                  // ),
                  // Button(
                  //   text: 'Edit',
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => BookingDetails(),
                  //       ),
                  //     );
                  //   },
                  //   icon: Icons.edit_outlined,
                  // ),
                  Button(
                    text: 'Edit',
                    onTap: () async {
                      final updatedBooking = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetails(
                            
                            propertyId: widget.property.id, bookedData: bookedProperty,
                            
                          ),
                        ),
                      );
                      if (updatedBooking != null) {
                        // updateBookingProperty(updatedBooking);
                      }
                    },
                    icon: Icons.edit_outlined,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<BookingModel?> getBooking(String bookingId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await fdb
          .collection('BOOKING')
          .doc(bookingId)
          .get();

      if (doc.exists && doc.data() != null) {
        // Merge Firestore ID with document data
        final data = doc.data()!;
        data['id'] = doc.id;
        return BookingModel.fromMap(data, doc.id);
      } else {
        print("No property found for ID: $bookingId");
        return null;
      }
    } catch (e) {
      print("Error fetching property: $e");
      return null;
    }
  }

  void updateBookingProperty(BookingModel Updatedetails) async {
    final DocumentReference<Map<String, dynamic>> documentRef = fdb
        .collection("BOOKING DETAILS")
        .doc(Updatedetails.id);
    await documentRef
        .update(Updatedetails.toJson())
        .then((value) {
          log("Updated successfully");
        })
        .onError((e, stack) {
          log("Error is $e");
        });
  }

  void deleteBookingProperty(String bookingId, String propertyId) async {
    await fdb.collection("BOOKING DETAILS").doc(bookingId).delete();
    await fdb.collection('PROPERTIES').doc(propertyId).update({
      'IS_BOOKED': 'NO',
    });
    await fdb.collection('PROPERTIES').doc(propertyId).set({
      "BOOKING_ID": FieldValue.delete(),
    }, SetOptions(merge: true));
  }
}
