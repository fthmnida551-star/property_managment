import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/booking/screens/booking_details.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/detailstable.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/dlt_alert.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/row.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/popup_mssg_cntnr.dart';
import 'package:property_managment/features/property/screens/searching_page/add_property.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotBookedPropertyScreen extends StatefulWidget {
  final String userName;
  final PropertyModel property;

  const NotBookedPropertyScreen({
    super.key,
    required this.userName,
    required this.property,
  });

  @override
  State<NotBookedPropertyScreen> createState() => _NotBookedPropertyScreenState();
}

class _NotBookedPropertyScreenState extends State<NotBookedPropertyScreen> {
  String userRole = "";
  FirebaseFirestore fdb = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  void getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString("role") ?? "";
    setState(() {});
    log("User Role: $userRole");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // ----------- Image Slider Section ----------
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 260,
                    child: PageView(
                      children: widget.property.image.map((img) {
                        return Image.network(img, fit: BoxFit.cover);
                      }).toList(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),

                        PopupMenuButton(
                          icon: const Icon(Icons.more_vert, color: Colors.white),
                          onSelected: (value) {
                            if (value == 'edit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddProperty(
                                    from: 'Edit',
                                    property: widget.property,
                                  ),
                                ),
                              );
                            } else if (value == 'delete') {
                              dltAlert(context, widget.property);
                            } else if (value == 'landlord') {
                              showLandlordPopup(context, widget.property);
                            }
                          },
                          itemBuilder: (context) => [
                            if (userRole != "Agent")
                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 8),
                                    Text('Edit')
                                  ],
                                ),
                              ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 8),
                                  Text('Delete')
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'landlord',
                              child: Row(
                                children: [
                                  Icon(Icons.person),
                                  SizedBox(width: 8),
                                  Text('Landlord')
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // ---------- Price / Name Section ----------
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.property.price}",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.property.name.toUpperCase(),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              // ---------- Location ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    SizedBox(width: 5),
                    Text(widget.property.location),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // ------------ Details  -------------
              Padding(
                padding: const EdgeInsets.all(20),
                child: ExpansionTile(
                  title: const Text("Details"),
                  children: [
                    DetailsTable(
                      text: "Bedrooms",
                      details: "${widget.property.bhk}",
                      icons: Icons.bed,
                    ),
                    Divider(),
                    DetailsTable(
                      text: "Bathrooms",
                      details: "${widget.property.bathrooms}",
                      icons: Icons.shower,
                    ),
                    Divider(),
                    DetailsTable(
                      text: "SQFT",
                      details: "${widget.property.sqft}",
                      icons: Icons.square_foot,
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: userRole == "Agent"
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.greenColor),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookingDetails(
                        propertyId: widget.property.id,
                        bookedData: null,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Book Now",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
    );
  }
}
