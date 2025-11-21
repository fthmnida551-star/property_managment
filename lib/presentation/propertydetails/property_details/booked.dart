import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/booking/screens/button.dart';
import 'package:property_managment/features/property/screens/propertydetails/booking_details.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/detailstable.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/dlt_alert.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/row.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/popup_mssg_cntnr.dart';
import 'package:property_managment/features/property/screens/searching_page/add_property.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookedPropertyScreen extends StatefulWidget {
  final PropertyModel property;
  final BookingModel? bookedData;

  const BookedPropertyScreen({
    super.key,
    required this.property,
    required this.bookedData,
  });

  @override
  State<BookedPropertyScreen> createState() => _BookedPropertyScreenState();
}

class _BookedPropertyScreenState extends State<BookedPropertyScreen> {
  final FirebaseFirestore fdb = FirebaseFirestore.instance;
  String userRole = "";

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  Future<void> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString("role") ?? "";
    setState(() {});
    log("User Role: $userRole");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImagesSection(context),
              _buildPropertyContent(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- HEADER IMAGE + MENU -----------------

  Widget _buildImagesSection(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: PageView(
            children: widget.property.image.map((img) {
              return InkWell(
                onTap: () {},
                child: Image.network(img, fit: BoxFit.cover),
              );
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
                        builder: (_) => AddProperty(
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
                          Text("Edit"),
                        ],
                      ),
                    ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text("Delete"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'landlord',
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 8),
                        Text("Landlord"),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  // ---------------- PROPERTY DETAILS -----------------

  Widget _buildPropertyContent() {
    return Padding(
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.property.price.toString(),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            widget.property.name.toUpperCase(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          // LOCATION
          Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 6),
              Text(widget.property.location),
            ],
          ),

          const SizedBox(height: 18),
          _buildExpansionDetails(),
          const SizedBox(height: 18),
          Image.asset(AssetResource.location),
          const SizedBox(height: 18),
          _buildBookingInfo(),
        ],
      ),
    );
  }

  // ---------------- EXPANSION TILE -----------------

  Widget _buildExpansionDetails() {
    return ExpansionTile(
      title: const Text("Details"),
      children: [
        RowWidget(text: widget.property.propertyType, icons: Icons.home),
        DetailsTable(
          text: "Bedrooms",
          details: widget.property.bhk.toString(),
          icons: Icons.bed,
        ),
        DetailsTable(
          text: "Bathrooms",
          details: widget.property.bathrooms.toString(),
          icons: Icons.bathtub,
        ),
        DetailsTable(
          text: "Carpet Area",
          details: widget.property.sqft.toString(),
          icons: Icons.square_foot,
        ),
      ],
    );
  }

  // ---------------- BOOKING DETAILS -----------------

  Widget _buildBookingInfo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Booked Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          _infoRow(Icons.person, widget.bookedData!.name),
          _infoRow(Icons.phone, widget.bookedData!.contact),
          _infoRow(Icons.email, widget.bookedData!.email),
          _infoRow(Icons.calendar_month, widget.bookedData!.date.toString()),

          if (userRole != "Agent") ...[
            const SizedBox(height: 14),
            Row(
              children: [
                Button(
                  width: 140,
                  height: 40,
                  text: 'Delete',
                  icon: Icons.delete_outline_outlined,
                  onTap: () async {
                    await deleteUser(widget.property.bookingid, widget.property.id);
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
                const SizedBox(width: 10),
                Button(
                  width: 140,
                  height: 40,
                  text: 'Edit',
                  icon: Icons.edit_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingDetails(
                          propertyId: widget.property.id,
                          bookedData: widget.bookedData,
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          ]
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }

  // ---------------- DELETE BOOKING -----------------

  Future<void> deleteUser(String id, String propertyId) async {
    await fdb.collection("BOOKING DETAILS").doc(id).delete();
    await fdb.collection('PROPERTIES').doc(propertyId).update({
      'IS_BOOKED': 'NO',
    });
  }
}
