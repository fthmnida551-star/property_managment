import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertymanagementapp/core/asset_resources.dart';
import 'package:propertymanagementapp/core/theme/app_colors.dart';
import 'package:propertymanagementapp/core/theme/app_textstyle.dart';

class BookingConatainerWidget extends StatelessWidget {
  final Widget child;
  final Color? color;
  final String? imagepath1;
  final String? imagepath2;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  const BookingConatainerWidget({
    super.key,
    required this.child,
    this.color,
    this.imagepath1,
    this.imagepath2,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      padding: padding ?? EdgeInsets.all(12),

      decoration: BoxDecoration(
      border: BoxBorder.all(color: AppColors.opacitygreyColor),
        color: color ?? AppColors.whitecolor,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        boxShadow:[BoxShadow(
          color: AppColors.blackcolor,
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset.infinite
        ),] 
      ),
      child:Row(
        children: [
          ClipRRect(
      borderRadius: BorderRadius.circular(7), 
      child: Image.asset(
        AssetResources.building,
        height: 50, 
        width: 50, 
        fit: BoxFit.cover, 
      ),
    ),
          SizedBox(width: 15),
          Column(
            children: [

              Text('Sruthi Hassan',style: AppTextstyle.propertyMediumTextstyle(context,fontColor: AppColors.blackcolor),),
              
              Row(
                children: [
                SvgPicture.asset(AssetResources.contact,),
              SizedBox(width: 5,),
                  Text('+987654578'),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
