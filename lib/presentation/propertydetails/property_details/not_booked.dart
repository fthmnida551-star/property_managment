import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/presentation/propertydetails/booking_details.dart';
import 'package:property_managment/presentation/propertydetails/widget/detailstable.dart';
import 'package:property_managment/presentation/propertydetails/widget/dlt_alert.dart';
import 'package:property_managment/presentation/propertydetails/widget/row.dart';
import 'package:property_managment/presentation/propertydetails/widget/popup_mssg_cntnr.dart';
import 'package:property_managment/presentation/searching_page/add_property.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';

class NotBookedPropertyScreen extends StatefulWidget {
  final String userName;
 
  
  
  final PropertyModel property;
  NotBookedPropertyScreen({
    super.key,
    required this.userName,
    required this.property,
    
  });
   

  

  // const NotBookedPropertyScreen({super.key});
  @override
  State<NotBookedPropertyScreen> createState() =>
      _NotBookedPropertyScreenState();
      
}

class _NotBookedPropertyScreenState extends State<NotBookedPropertyScreen> {
   String userRole ="";
  void getUserRole()async{
    final prefs=await SharedPreferences.getInstance();
    userRole =prefs.getString("role")??"";
  setState(() {
    
  });
  log("yuio$userRole");
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserRole();
  }
  FirebaseFirestore fdb = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
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
                        Image.asset(AssetResource.building1, fit: BoxFit.cover),
                        Image.asset(AssetResource.property, fit: BoxFit.cover),
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
                            if(userRole!="Agent")
                            PopupMenuItem(
                              onTap: () {
                                 Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).push(
                                    MaterialPageRoute(
                                      builder: (context) => AddProperty(from: 'Edit', property: widget.property,),
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
                            PopupMenuItem(
                              onTap: (){

                                   dltAlert(context,widget.property);
                                  
                                 
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: AppColors.black),
                                  Text('Delete'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                  showLandlordPopup(context, widget.property);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.person, color: AppColors.black),
                                  SizedBox(width: 8),
                                  Text('Landlord'),
                                ],
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
              if (widget.property.propertyType == 'APARTMENT' ||
                  widget.property.propertyType == 'VILLA')
                Padding(
                  padding: EdgeInsets.all(26.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.property.price}',
                        style: TextStyle(
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.property.name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'BHK :${widget.property.bathrooms}\n SQFT :${widget.property.sqft}',
                        style: TextStyle(fontSize: 14, color: AppColors.black),
                      ),
                      SizedBox(height: 15),
                      // --- Location ---
                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.black),
                          SizedBox(width: 5),
                          Text(
                            widget.property.location,
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
                                      'Property Overview\n${widget.property.name}\n${widget.property.location}',
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
                                        text: widget.property.propertyType,
                                        icons: Icons.apartment,
                                      ),
                                      Divider(thickness: 1),
                                      RowWidget(
                                        text: '${widget.property.readyToMove}',
                                        icons: Icons.check_circle_outline,
                                      ),
                                      Divider(thickness: 1),
                                      // RowWidget(
                                      //   text: 'Owner',
                                      //   icons: Icons.account_circle,
                                      // ),
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
                                        details: '${widget.property.bhk}',
                                        icons: Icons.bed,
                                      ),
                                      Divider(thickness: 1),
                                      DetailsTable(
                                        text: 'Carpet Area',
                                        details: '${widget.property.sqft}',
                                        icons: Icons.check_box_outline_blank,
                                      ),
                                      Divider(thickness: 1),
                                      DetailsTable(
                                        text: 'Bathrooms',
                                        details: '${widget.property.bathrooms}',
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
                                  text: '${widget.property.carParking}',
                                  icons: Icons.directions_car,
                                ),
                                RowWidget(
                                  text:
                                      'Maintenance (Monthly) ${widget.property.price}',
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
                                    widget.property.description,
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
                    ],
                  ),
                ),

              if (widget.property.propertyType == 'LAND')
                Padding(
                  padding: EdgeInsets.all(26.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.property.price}',
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
                            widget.property.location,
                            // 'KARAVATTOM, MALAPPURAM',
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
                                    child: Text('Property Overview',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
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
                                        details: "${widget.property.location}",
                                        icons: Icons.location_on,
                                      ),
                                      Divider(thickness: 1),
                                      DetailsTable(
                                        text: 'Property Type',
                                        details: "${widget.property.propertyType}",
                                        icons: Icons.landslide_outlined,
                                      ),
                                      Divider(thickness: 1),
                                      
                                      DetailsTable(
                                        text: 'Sqft',
                                        details: "${widget.property.sqft}",
                                        icons: Icons.check_box_outline_blank,
                                      ),
                                      // Divider(thickness: 1),
                                     
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
                                  text: widget.property.aminities,
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
                                    // 'Location : Karyavattom, Trivandrum \n(Near Technopark Greenfield stadium)\n'
                                    // 'Project : Impact Milestone-Premium residential Apartment\n'
                                    // 'Flat Type: 2 BHK Spacious Living & Dining\n'
                                    // 'Area : [insert Sq.Ft - Eg. 1050 Sq.Ft]\n'
                                    // 'car parking: Yes\n'
                                    // 'Amenities : Swimming Pool, Gym,\n 24*7 Security Power Backup\n'
                                    // 'Status : Ready To Move',
                                    widget.property.description,
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
                     
                    ],
                    
                  ),
                  
                ),
            ],
          ),
        ),
     
        bottomNavigationBar: userRole == "Agent" ? null
         : Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 50,
            
            child: ElevatedButton(
              onPressed: () {
                log("property id is  ${widget.property.id}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BookingDetails(propertyId: widget.property.id, bookedData: null,),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
             
              child: Text(
                'Booking Now',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.whitecolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  


}
