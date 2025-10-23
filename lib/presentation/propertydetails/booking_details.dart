import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/presentation/propertydetails/animated_tick.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/date_picker.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  Widget divider = SizedBox(height: 10);
  TextEditingController namectlr = TextEditingController();
  TextEditingController contactCtlr = TextEditingController();
  TextEditingController emailCtlr = TextEditingController();
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
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
              Text(
                'Add Booking Dtails',
                style: TextStyle(color: AppColors.white, fontSize: 19.sp),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFieldContainer(text: 'Name', controllerName: namectlr),
              divider,
              TextFieldContainer(text: 'Contact', controllerName: contactCtlr),
              divider,
              TextFieldContainer(text: 'Email', controllerName: emailCtlr),
              divider,
              CalendarPickerContainer(hintText: 'Date'),
             
            ],
          ),
        ),
      ),
      bottomNavigationBar: GreenButton(
              text: 'Save',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GrowContainer()),
                );
              },
            ), 
    );
  }
}
