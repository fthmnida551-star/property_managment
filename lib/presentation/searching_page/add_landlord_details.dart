import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';
import 'package:property_managment/widget/checkbox.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';

class AddLandlordDetails extends StatefulWidget {
  const AddLandlordDetails({super.key});

  @override
  State<AddLandlordDetails> createState() => _AddLandlordDetailsState();
}

class _AddLandlordDetailsState extends State<AddLandlordDetails> {
  Widget divider = SizedBox(height: 10);
  bool isOwnProperty = false;
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
                'Add Landlord',
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
            CheckboxWithListenable(
              text: 'Own Property',
              value: isOwnProperty,
              onChanged: (newValue) {
                setState(() {
                  isOwnProperty = newValue ?? false;
                });
              },
            ),

            if (!isOwnProperty) ...[
              SizedBox(height: 20),
              TextFieldContainer(text: 'Name', controllerName: nameCtrl,),
              divider,
              TextFieldContainer(text: 'Contact', controllerName: contactCtrl,),
              divider,
              TextFieldContainer(text: 'Email', controllerName: emailCtrl,),
              divider,
              TextFieldContainer(text: 'Date', controllerName: dateCtrl,),
            ],
            Spacer(),
            GreenButton(
              text: 'Submit',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (contex) => BottomNavigationWidget()),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
