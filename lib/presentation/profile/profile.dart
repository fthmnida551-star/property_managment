import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/presentation/profile/widget/list_tile_container.dart';
import 'package:property_managment/widget/appbar_widget.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Custom AppBar
      appBar: AppbarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),
           
           Padding(
             padding: const EdgeInsets.only(left: 300.0),
             child: GestureDetector(
              onTap: () {
                print('edit clicked');
              },
              child: Icon(Icons.edit)),
             
           )
          ],
        ),
      ),

      // appBar: AppbarWidget(image:SvgPicture.asset(AssetResources.edit,color:AppColors.blackColor ,) ,child:const Text('profile',style: TextStyle(color: AppColors.whiteColor,fontSize: 21),),),


      body: Column(
        children: [
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42.5),
              ),
              child: Image.asset(AssetResource.profilepic,height: 50.h,width: 50.w,),
            ),
            title: Text(
              'Nidha C',
              style: TextStyle(fontSize: 23.sp, color: AppColors.blackColor),
            ),
            subtitle: Text(
              'Staff1@company.com',
              style: TextStyle(fontSize: 17.sp),
            ),
          ),
          const Divider(),
          ListTileContainer(text: 'My Profile'),
            ListTileContainer(text: 'Users'),
          ListTileContainer(text: 'Settings'),
          ListTileContainer(text: 'Notification'),
        
         
         
        ],
      ),

     
    );
  }
}
