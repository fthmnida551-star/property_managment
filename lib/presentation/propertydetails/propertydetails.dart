import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/presentation/propertydetails/widget/detailstable.dart';
import 'package:property_managment/presentation/propertydetails/widget/row.dart';

class PropertydetailsScreen extends StatefulWidget {
  const PropertydetailsScreen({super.key});
  @override
  State<PropertydetailsScreen> createState() => _PropertydetailsScreenState();
}

class _PropertydetailsScreenState extends State<PropertydetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset(AssetResource.property, fit: BoxFit.cover),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.arrow_back, color: AppColors.whitecolor),
                      PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: AppColors.whitecolor,
                        ),

                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: AppColors.black),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: AppColors.black),
                                Text('Delete'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.person, color: AppColors.black),
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
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  
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
            Padding(
              padding: EdgeInsets.all(26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹ 79,00,000',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Modern Amenities\n2 BHK - 2 Bathroom - 1380 Sqft',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  // --- Location ---
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppColors.black),
                     SizedBox(width: 5),
                      Text(
                        'KARAVATTOM, MALAPPURAM',
                        style: TextStyle(fontSize: 15, color: AppColors.black),
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
                      tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                  'Property Overview\nModern Apartment\nKARAVATTOM, MALAPPURAM',
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [                                
                                  RowWidget(text:'Flats/Apartments', icons: Icons.apartment),
                                  Divider(thickness: 1),
                                  RowWidget(text:'Ready to move', icons: Icons.check_circle_outline),
                                  Divider(thickness: 1),
                                  RowWidget(text:'Owner', icons: Icons.account_circle),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Property Details',
                              style: TextStyle(fontSize: 20, color: AppColors.black ,fontWeight: FontWeight.w500,),
                            ),
                            SizedBox(height: 8),
                            // Property Details Box
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [                            
                                  DetailsTable(text: 'BHK', details: '2', icons:Icons.bed),
                                  Divider(thickness: 1),
                                    DetailsTable(text: 'Carpet Area', details: '1380 Sqft', icons:Icons.check_box_outline_blank),
                                  Divider(thickness: 1),
                                  DetailsTable(text: 'Bathrooms', details: '2', icons:Icons.bathtub),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Amenities",
                              style: TextStyle(fontSize: 16),
                            ),
                        SizedBox(height: 8),
                            RowWidget(text:'Car Parking' , icons:Icons.directions_car),
                            RowWidget(text:'Maintenance (Monthly) 2000' , icons:Icons.currency_bitcoin),                 

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
                                'Location : Karyavattom, Trivandrum \n(Near Technopark Greenfield stadium)\n'
                                'Project : Impact Milestone-Premium residential Apartment\n'
                                'Flat Type: 2 BHK Spacious Living & Dining\n'
                                'Area : [insert Sq.Ft - Eg. 1050 Sq.Ft]\n'
                                'car parking: Yes\n'
                                'Amenities : Swimming Pool, Gym,\n 24*7 Security Power Backup\n'
                                'Status : Ready To Move',
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
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
    );
  }
}
