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
    final pro = ref.watch(notificationProvider);
    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'Notification',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
        ),
      ),
      body: pro.when(
        data: (notifications) {
          print("NOTIFICATION COUNT: ${notifications.length}");
          print(notifications);
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
