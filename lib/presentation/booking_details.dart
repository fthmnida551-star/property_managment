import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  Widget divider = SizedBox(height: 10);
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController contactCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  print('move to back slide');
                },
                child: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
              Text(
                'Add Landlord details',
                style: TextStyle(color: AppColors.white, fontSize: 19.sp),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [          
            SizedBox(height: 20),
            TextFieldContainer(text: 'Name', controllerName: nameCtrl),
            divider,
            TextFieldContainer(text: 'Contact', controllerName: contactCtrl,),
            divider,
            TextFieldContainer(text: 'Email', controllerName: emailCtrl,),
            divider,
            TextFieldContainer(text: 'Date', controllerName: dateCtrl,),         
            Spacer(),
            GreenButton(
              text: 'Save',
              onTap: () {
                print('button clicked');
              },
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
