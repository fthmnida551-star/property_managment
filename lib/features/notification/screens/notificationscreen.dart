import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/features/notification/controllers/notification_controller.dart';
import 'package:property_managment/features/notification/screens/widget/notification_container.dart';

// ignore: must_be_immutable
class Notificationscreen extends ConsumerWidget {
  Notificationscreen({super.key});

  Widget divider = SizedBox(height: 12);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo=ref.watch(notificationDelete);
    final pro = ref.watch(noticationProvider);
    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notification',
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
                      // SizedBox(width: 150,) ,
                      
              PopupMenuButton(
               icon:Icon(Icons.more_vert_outlined,color: AppColors.whiteColor,),
                color:AppColors.white,
              onSelected: (value) async{
                if(value=="deleteAll"){  
                  await repo.deleteAllNotifications();}
              },
                itemBuilder: (context)=>[
                  PopupMenuItem(
                    value: "deleteAll",
                    child: Row(
                    
                    children: [
                      Icon(Icons.delete_forever),
                      SizedBox(width: 5,),
                      
                      Text("DeleteAll"),
                      
                    ],
                  ),)
                ])
            ],
          ),
          
        ),
        
      ),
      body: pro.when(
        data: (notifications) {
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final item = notifications[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: NotificationContainer(
                  title: item["title"],
                  text: item["message"],
                  color: item["type"].toString().toLowerCase() == "added"
                  ?AppColors.ntfctBlue
                  :item["type"].toString().toLowerCase() == "booked"
                      ? AppColors.greenColor
                      : AppColors.redcolor,
                ),
              );
            },
          );
        },

        loading: () => Center(child: CircularProgressIndicator()),

        error: (err, stack) => Center(
          child: Text("Error: $err", style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}
