import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/presentation/notification_screen/widget/notification_container.dart';
import 'package:property_managment/widget/appbar_widget.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({super.key});

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  Widget divider=SizedBox(height: 12,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text('Notification',style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold,fontSize: 21),),
      ),),
      body:SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 18,),
             NotificationContainer(color: AppColors.greenColor,text: 'Today',),
             NotificationContainer(text: 'Yesterday', color: AppColors.redcolor),
             NotificationContainer(text: '1 day ago', color: AppColors.ntfctBlue),
             NotificationContainer(text: '12 sep 2025', color: AppColors.ntfctnYellow),
             NotificationContainer(color: AppColors.greenColor,text: '25 sep 2025',),
             NotificationContainer(text: '2 aug 2025', color: AppColors.redcolor),
             NotificationContainer(text: '25 july 2025', color: AppColors.ntfctBlue),
             NotificationContainer(text: '12 july 2025', color: AppColors.ntfctnYellow)
          ],
        ),
      ),
     
      
    );
  }
}