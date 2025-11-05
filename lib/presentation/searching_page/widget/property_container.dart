import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/presentation/propertydetails/property_details/not_booked.dart';
import 'package:property_managment/presentation/propertydetails/propertydetails.dart';
import 'package:property_managment/presentation/searching_page/widget/icon_row.dart';

class PropertyContainer extends StatefulWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final bool isShow;
  final VoidCallback? onTap;
  final PropertyModel property;
  const PropertyContainer({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.isShow = true,
    this.onTap,
    required this.property
  });
  @override
  State<PropertyContainer> createState() => _PropertyContainerState();
}

class _PropertyContainerState extends State<PropertyContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap??  () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => PropertydetailsScreen(userName: '', property: ,)),//NotBookedPropertyScreen()),
        // );
      }, 
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => PropertydetailsScreen()),
      //   );
      // },
      child: Container(
        height: 400.h,
        color: AppColors.propertyContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                AssetResource.building,
                fit: BoxFit.cover,
                height: 209,
                width: 356,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              // 'Apartment',
              '${widget.property.propertyType}',
              style: TextStyle(fontSize: 21.sp, color: AppColors.black),
            ),
            Text(
              // '90,000',
              "${widget.property.price}",
              style: TextStyle(fontSize: 44.sp, color: AppColors.black),
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 20),
                Text(
                  // 'Azizi Aliyah,al jaddaf, Dubai',
                  '${widget.property.location}',
                  style: TextStyle(fontSize: 19.sp, color: AppColors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(widget.property.propertyType != "LAND")
                // IconRow(icon: Icons.bed_outlined, value: '${widget.property.bhk}', property: widget.property,),
                 Row(
                  children: [
                    Icon(Icons.bed_outlined,size: 20.sp,),
                    Center(child: Text('${widget.property.bhk}')),
                  ],
                ),
                if(widget.property.propertyType != "LAND")
                Row(
                  children: [
                    Icon(Icons.bathtub_outlined,size: 18.sp,),
                    Center(child: Text('${widget.property.bathrooms}')),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   
                    Text(' ${widget.property.sqft}'),
                    Text('sqf',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                  ],
                ),

                widget.isShow
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 99.75.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            color: widget.color ?? AppColors.propertyContainer,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.bookingNow),
                          ),
                          child: Center(
                            child: Text(
                              widget.text,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: widget.textColor ?? AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
