import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';

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
                  child: Image.asset(
                    AssetResource.property,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.arrow_back, color: AppColors.whitecolor),
                      Icon(Icons.more_vert, color: AppColors.whitecolor),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration:  BoxDecoration(
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
                                   Row(
                                    children: [                         
                                  Icon(Icons.apartment, color: AppColors.black),
                                  Text('  Flats/Apartments'),],),
                                  Divider(thickness: 2),
                                  Row(
                                    children: [
                                  Icon(Icons.check_circle_outline, color: AppColors.black),
                                  Text('  Ready to move'),],),
                                  Divider(thickness: 2),
                                  Row(
                                    children: [
                                  Icon(Icons.account_circle, color: AppColors.black),
                                  Text('  Owner'),],)
                                ],
                              ),
                            ),
                         SizedBox(height: 8),
                         Text(
                              'Property Details',
                              style: TextStyle(fontSize: 20, color: AppColors.black),
                            ),
                            SizedBox(height: 8),
                            // Property Details Box
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.bed, color: AppColors.black),
                                      Text(' BHK'),
                                      SizedBox(width: 250),                         
                                      Text('2'),
                                    ],
                                  ),
                                  Divider(thickness: 2),
                                  Row(
                                    children: [
                                      Icon(Icons.check_box_outline_blank, color: AppColors.black),
                                      Text(' Carpet Area'),
                                      SizedBox(width: 150),
                                      Text('1380 Sqft'),
                                    ],
                                  ),
                                  Divider(thickness: 1),
                                  Row(
                                    children: [
                                       Icon(Icons.bathtub, color: AppColors.black),
                                      Text(' Bathrooms'),
                                      SizedBox(width: 200),
                                      Text(' 2'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                     SizedBox(height: 8),
                         Text(
                              "Amenities",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                        SizedBox(height: 8),
                            // Amenities Rows
                            Row(
                              children: [                               
                                 Icon(Icons.directions_car, color: AppColors.black),
                               SizedBox(width: 5),
                                 Text(
                                  'Car Parking',
                                  style: TextStyle(fontSize: 15, color: AppColors.black),
                                ),
                              ],
                            ),
                             SizedBox(height: 6),
                            Row(
                              children: [                               
                                 Icon(Icons.currency_bitcoin, color: AppColors.black),
                               SizedBox(width: 5),
                             Text(
                                  'Maintenance (Monthly) 2000',
                                  style: TextStyle(fontSize: 15, color: AppColors.black),
                                ),
                              ],
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
                                'Location : Karyavattom, Trivandrum \n(Near Technopark Greenfield stadium)\n'
                               'Project : Impact Milestone-Premium residential Apartment\n'
                                'Flat Type: 2 BHK Spacious Living & Dining\n'
                                'Area : [insert Sq.Ft - Eg. 1050 Sq.Ft]\n'
                                'car parking: Yes\n'
                                'Amenities : Swimming Pool, Gym,\n 24*7 Security Power Backup\n'
                                'Status : Ready To Move',
                                style: TextStyle(fontSize: 15,),
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
      // --- Bottom Booking Button ---
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