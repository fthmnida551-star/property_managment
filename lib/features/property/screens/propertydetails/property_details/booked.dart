import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
import 'package:property_managment/features/booking/controller/booking_controllers.dart';
import 'package:property_managment/features/property/controllers/property_cntlr.dart';
import 'package:property_managment/core/utils/location/convert_class.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/booking/screens/button.dart';
import 'package:property_managment/features/booking/screens/booking_details.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/detailstable.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/dlt_alert.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/row.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/popup_mssg_cntnr.dart';
import 'package:property_managment/features/property/screens/searching_page/add_property.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookedPropertyScreen extends ConsumerWidget {
  PropertyModel property;
  BookingModel? bookedData;
  BookedPropertyScreen({
    super.key,
    required this.property,
    required this.bookedData,
  });
  List<PropertyModel> propertyDetails = [];

  FirebaseFirestore fdb = FirebaseFirestore.instance;

  String userRole ="";

  void getUserRole()async{
    final prefs =await SharedPreferences.getInstance();
    userRole =prefs.getString("role")??'';
    
  } 

  // @override

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final repo=ref.read(bookingRepoProvider);
    final loginanme=ref.watch(userNameProvider);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: PageView(
                      children: [
                        if (property.image.isNotEmpty)
                          Image.network(
                            property.image[0],
                            fit: BoxFit.cover,
                            height: 209,
                            width: 356,
                          ),
                        if (property.image.length > 1)
                          Image.network(
                            property.image[1],
                            fit: BoxFit.cover,
                            height: 209,
                            width: 356,
                          ),
                        if (property.image.length > 2)
                          Image.network(
                            property.image[2],
                            fit: BoxFit.cover,
                            height: 209,
                            width: 356,
                          ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.whitecolor,
                          ),
                        ),
                        PopupMenuButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: AppColors.whitecolor,
                          ),
                          itemBuilder: (BuildContext context) => [
                            if (userRole != "Agent")
                              PopupMenuItem(
                                child: InkWell(
                                  onTap: () {
                                    // use rootNavigator so it works even after popup closes
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).push(
                                      MaterialPageRoute(
                                        builder: (context) => AddProperty(
                                          from: 'Edit',
                                          property: property,
                                        ),
                                      ),
                                    );
                                  },

                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: AppColors.black),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),
                              ),
                            PopupMenuItem(
                              child: GestureDetector(
                                onTap: () {
                                  // dltAlert(context, property);
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    dltAlert(context,property, ref);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: AppColors.black),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                            ),

                            PopupMenuItem(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  showLandlordPopup(context, property);
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.person, color: AppColors.black),
                                    SizedBox(width: 8),
                                    Text('Landlord'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whitecolor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // --- Property Content Section ---
              if (property.propertyType == 'APARTMENT' ||
                  property.propertyType == "VILLA")
                Padding(
                  padding: EdgeInsets.all(26.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${property.price}',
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        property.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'BHK :${property.bathrooms}\n SQFT :${property.sqft}',
                        style: TextStyle(fontSize: 14, color: AppColors.black),
                      ),
                      SizedBox(height: 15),
                      // --- Location ---
                      // Row(
                      //   children: [
                      //     Icon(Icons.location_on, color: AppColors.black),
                      //     SizedBox(width: 5),
                      //     Text(
                      //       widget.property.location,
                      //       // 'KARAVATTOM, MALAPPURAM',
                      //       style: TextStyle(
                      //         fontSize: 15,
                      //         color: AppColors.black,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      if (property.latitude != null &&
                          property.longitude != null)
                        Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.black),
                            
                            SizedBox(width: 5),
                            Expanded(
                              child: AddressWidget(
                                lat: property.latitude!,
                                lng: property.longitude!,
                              ),
                            ),
                          ],
                        ),
                        
                      SizedBox(height: 16),
                      // --- Styled ExpansionTiles Section ---
                      ExpansionTileTheme(
                        data: ExpansionTileThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.black12, width: 1),
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.black12, width: 1),
                          ),
                          backgroundColor: Colors.white,
                          collapsedBackgroundColor: Colors.white,
                          tilePadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          childrenPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          iconColor: Colors.black,
                          collapsedIconColor: Colors.black,
                        ),
                        child: Column(
                          children: [
                            // --- Details Dropdown ---
                            ExpansionTile(
                              title: Text(
                                'Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Property Overview\n${property.name},\n${property.location}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                                // Property Type Box
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RowWidget(
                                        text: property.propertyType,
                                        icons: Icons.apartment,
                                      ),
                                      Divider(thickness: 1),
                                      RowWidget(
                                        text: '${property.readyToMove}',
                                        icons: Icons.check_circle_outline,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 8),
                                Text(
                                  'Property Details',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),

                                // Property Details Box
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.black),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DetailsTable(
                                        text: 'Bedrooms',
                                        details: "${property.bathrooms}",
                                        icons: Icons.bed,
                                      ),
                                      Divider(thickness: 1),
                                      DetailsTable(
                                        text: 'Carpet Area',
                                        details: "${property.sqft}",
                                        icons: Icons.check_box_outline_blank,
                                      ),
                                      Divider(thickness: 1),
                                      DetailsTable(
                                        text: 'Bathrooms',
                                        details: "${property.bathrooms}",
                                        icons: Icons.bathtub,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Amenities",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                RowWidget(
                                  text: "${property.carParking}",
                                  icons: Icons.directions_car,
                                ),
                                RowWidget(
                                  text:
                                      "Maintenance (Monthly) ${property.price}",
                                  icons: Icons.currency_bitcoin,
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            // --- Description Dropdown ---
                            ExpansionTile(
                              title: Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    property.description,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          AssetResource.location,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: AppColors.black, width: 1),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                              child: Center(
                                child: Text(
                                  'Booked Details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(Icons.person, color: Colors.green),
                                SizedBox(width: 8),
                                Text(bookedData!.name),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.green),
                                SizedBox(width: 8),
                                Text(bookedData!.contact),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.mail, color: Colors.green),
                                SizedBox(width: 8),
                                Text(bookedData!.email),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.mail, color: Colors.green),
                                SizedBox(width: 8),
                                Text("${bookedData!.date}"),
                              ],
                            ),
                            if (userRole != "Agent")
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Button(
                                      width: 150,
                                      height: 40,
                                      text: 'Delete',
                                      onTap: () async {
                                        // await deleteUser(
                                        //   property.bookingid,
                                        //   property.id,
                                        // );
                                        repo.deleteBooking(property.bookingid,property.id,loginanme.value!);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavigationWidget(
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
                                    SizedBox(width: 10),
                                    Button(
                                      width: 150,
                                      height: 40,
                                      text: 'Edit',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BookingDetails(
                                                  propertyId:
                                                      property.id,
                                                  bookedData: bookedData,
                                                ),
                                          ),
                                        );
                                      },
                                      icon: Icons.edit_outlined,
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              if (property.propertyType == 'LAND')
                Padding(
                  padding: EdgeInsets.all(26.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${property.price}',
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 10),

                      // --- Location ---
                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.black),
                          SizedBox(width: 5),
                          Text(
                            property.location,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),
                      // --- Styled ExpansionTiles Section ---
                      ExpansionTileTheme(
                        data: ExpansionTileThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.black12, width: 1),
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.black12, width: 1),
                          ),
                          backgroundColor: Colors.white,
                          collapsedBackgroundColor: Colors.white,
                          tilePadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          childrenPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          iconColor: Colors.black,
                          collapsedIconColor: Colors.black,
                        ),
                        child: Column(
                          children: [
                            // --- Details Dropdown ---
                            ExpansionTile(
                              title: Text(
                                'Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Property Overview',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 8),

                                // Property Details Box
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.black),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DetailsTable(
                                        text: 'Location',
                                        detailsWidget: AddressWidget(
                                          lat: property.latitude!,
                                          lng: property.longitude!,
                                          style: TextStyle(
                                            color: AppColors.black,
                                          ),
                                        ),
                                        icons: Icons.location_on,
                                      ),
                                      Divider(thickness: 1),
                                      DetailsTable(
                                        text: 'Property Type',
                                        details: property.propertyType,
                                        icons: Icons.landslide_outlined,
                                      ),
                                      Divider(thickness: 1),

                                      DetailsTable(
                                        text: 'Sqft',
                                        details: "${property.sqft}",
                                        icons: Icons.check_box_outline_blank,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Amenities",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                RowWidget(
                                  text: property.aminities,
                                  icons: Icons.business_outlined,
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            // --- Description Dropdown ---
                            ExpansionTile(
                              title: Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    property.description,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          AssetResource.location,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
//                      Padding(
//   padding: EdgeInsets.only(bottom: 8.0),
//   child: Image.network(
//     "https://maps.googleapis.com/maps/api/staticmap?"
//     "center=${widget.property.latitude},${widget.property.longitude}"
//     "&zoom=16&size=600x300&markers=color:red%7C${widget.property.latitude},${widget.property.longitude}"
//     "&key=YOUR_GOOGLE_MAPS_API_KEY",
//     fit: BoxFit.cover,
//   ),
// ),

                      SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: AppColors.black, width: 1),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                              // decoration: BoxDecoration(
                              //   border: Border.all(width: 1, color: Colors.black),
                              // ),
                              child: Center(
                                child: Text(
                                  'Booked Details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(Icons.person, color: Colors.green),
                                SizedBox(width: 8),
                                Text("${bookedData!.name}"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.green),
                                SizedBox(width: 8),
                                Text("${bookedData!.contact}"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.mail, color: Colors.green),
                                SizedBox(width: 8),
                                Text(bookedData!.email),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_rounded,
                                  color: Colors.green,
                                ),

                                SizedBox(width: 8),
                                Text("${bookedData!.date}"),
                                // Text('Date\n2-3-2025'),
                              ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (userRole != "Agent")
                                    Button(
                                      width: 150,
                                      height: 40,
                                      text: 'Delete',
                                      onTap: () async {
                                        // await deleteB(
                                        //   widget.property.bookingid,
                                        //   widget.property.id,
                                        // );
                                       repo.deleteBooking(property.bookingid,property.id,loginanme.value!);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavigationWidget(
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
                                  SizedBox(width: 10),
                                  Button(
                                    width: 150,
                                    height: 40,
                                    text: 'Edit',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookingDetails(
                                            propertyId: property.id,
                                            bookedData: bookedData,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icons.edit_outlined,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
