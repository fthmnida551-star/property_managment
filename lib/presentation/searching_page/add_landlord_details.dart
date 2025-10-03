import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';

class AddLandlordDetails extends StatefulWidget {
  const AddLandlordDetails({super.key});

  @override
  State<AddLandlordDetails> createState() => _AddLandlordDetailsState();
}

class _AddLandlordDetailsState extends State<AddLandlordDetails> {
  Widget divider = SizedBox(height: 10);
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
             SvgPicture.asset(AssetResource.roundeTick),
             SizedBox(width: 10,),
             Text('Own Property',style: TextStyle(fontSize: 18.sp),),
              ],
            ),
            SizedBox(height: 20),
            TextFieldContainer(text: 'Name'),
            divider,
            TextFieldContainer(text: 'Contact'),
            divider,
            TextFieldContainer(text: 'Email'),
            divider,
            TextFieldContainer(text: 'Date'),         
            Spacer(),
            GreenButton(
              text: 'Submit',
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
