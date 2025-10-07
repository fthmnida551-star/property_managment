import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/app_textstyl.dart';
import 'package:property_managment/widget/appbar_widget.dart';

class LandlordDetails extends StatefulWidget {
  const LandlordDetails({super.key});

  @override
  State<LandlordDetails> createState() => _LandlordDetailsState();
}

class _LandlordDetailsState extends State<LandlordDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: Icon(Icons.keyboard_arrow_left,size: 30.sp,),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30,left: 20,right: 20),
        child: Container(
          height: 350,
          width: 500,
          
                
          decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(30) ,
            color:Colors.white,
            border: BoxBorder.all(color: AppColors.black,width: 1),
            boxShadow: [BoxShadow(
              color: AppColors.opacitygreyColor,
              blurRadius: 1,
              spreadRadius: 1,
              offset:Offset.zero
            )
            ]
            
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                Text('NAME        : GIRIDHAR',style: AppTextstyle.propertyMediumTextstyle(context,fontColor: AppColors.black),),
                SizedBox(height: 5,),
                Text('MOB NO    : 98765432',style:AppTextstyle.propertyMediumTextstyle(context,fontColor: AppColors.black),),
                SizedBox(height: 5,),
                Text('E- MAIL     : giridhar@gmail.com',style:AppTextstyle.propertyMediumTextstyle(context,fontColor: AppColors.black),),
                SizedBox(height: 5,),
                Text('DATE          : 04/11/2025',style: AppTextstyle.propertyMediumTextstyle(context,fontColor: AppColors.black),),
              ],
            ),
          ),
        ),
      ),

    );
  }
}