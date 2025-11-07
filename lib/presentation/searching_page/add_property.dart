import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/firebase/save_button.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/presentation/searching_page/add_landlord_details.dart';
import 'package:property_managment/presentation/searching_page/widget/dropdown._form_field.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/checkbox.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';
import 'package:image_picker/image_picker.dart';

class AddProperty extends StatefulWidget {
  final String from;
  final PropertyModel? property;
  const AddProperty({super.key, required this.from, required this.property});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  String? _selectedValue;
  final List<String> _items = ['APARTMENT', 'VILLA', 'LAND'];
  final formKey = GlobalKey<FormState>();
  Widget divider = SizedBox(height: 10);
  bool readytoMove = false;
  bool carparking = false;
  TextEditingController propertyTypeCtlr = TextEditingController();
  TextEditingController priceCtlr = TextEditingController();
  TextEditingController buildingNamectlr = TextEditingController();
  TextEditingController bhkctlr = TextEditingController();
  TextEditingController bathroomctlr = TextEditingController();
  TextEditingController carpetAreactlr = TextEditingController();
  TextEditingController maintenancectlr = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController propertySqrftCtlr = TextEditingController();
  TextEditingController aminitiesctlr = TextEditingController();
  TextEditingController descriptionCtlr = TextEditingController();
  TextEditingController locationCtlr = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      // imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  SaveButtonMode _saveButtonMode = SaveButtonMode.save;

  clearController() {
    propertyTypeCtlr.clear();
    priceCtlr.clear();
    buildingNamectlr.clear();
    bhkctlr.clear();
    bathroomctlr.clear();
    // carpetAreactlr.clear();
    maintenancectlr.clear();
    aminitiesctlr.clear();
    propertySqrftCtlr.clear();
    descriptionCtlr.clear();
    locationCtlr.clear();
  }

  setControllersForUpdate() {
    log('reached here : ${widget.from}    property: ${widget.property}');
    if (widget.from == "Edit" && widget.property != null) {
      propertyTypeCtlr.text = widget.property!.propertyType;
      _selectedValue = widget.property!.propertyType;
      readytoMove = widget.property!.readyToMove;
      carparking = widget.property!.carParking;
      priceCtlr.text = widget.property!.price.toString();
      buildingNamectlr.text = widget.property!.name;
      bhkctlr.text = widget.property!.bhk.toString();
      bathroomctlr.text = widget.property!.bathrooms.toString();
      maintenancectlr.text = widget.property!.maintenance.toString();
      aminitiesctlr.text = widget.property!.aminities.toString();
      propertySqrftCtlr.text = widget.property!.sqft.toString();
      descriptionCtlr.text = widget.property!.description;
      locationCtlr.text = widget.property!.location;
      _saveButtonMode = SaveButtonMode.edit;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setControllersForUpdate();
  }

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
                'Add Property',
                style: TextStyle(color: AppColors.white, fontSize: 19.sp),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 368,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.searchbar,
                        borderRadius: BorderRadius.circular(8),
                        border: BoxBorder.all(
                          width: 1,
                          color: AppColors.opacitygreyColor,
                        ),
                        image: _selectedImage != null
                            ? DecorationImage(
                                image: FileImage(_selectedImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _selectedImage == null
                          ? Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(AssetResource.camera),
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedImage = null; // remove image
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.black54,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                DropdownFormField(
                  hintText: 'Property Type',
                  items: _items,
                  value: _selectedValue,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a property type';
                    }
                    return null;
                  },
                  onChanged: (newValue) {
                    setState(() {
                      _selectedValue = newValue;
                      propertyTypeCtlr.text = newValue!;
                    });
                  },
                ),

                divider,

                divider,
                TextFieldContainer(
                  text: 'Price',
                  controllerName: priceCtlr,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter  property price';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Only numbers allowed';
                    }
                    return null;
                  },
                ),
                divider,
                if (propertyTypeCtlr.text == _items[0] ||
                    propertyTypeCtlr.text == _items[1])
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Details", style: TextStyle(fontSize: 20)),
                        divider,
                        TextFieldContainer(
                          text: "Building name",
                          controllerName: buildingNamectlr,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your building name';
                            }
                            return null;
                          },
                        ),

                        divider,

                        CheckboxWithListenable(
                          text: 'Ready to move',
                          value: readytoMove,
                          onChanged: (newValue) {
                            setState(() {
                              readytoMove = newValue ?? false;
                            });
                          },
                        ),
                        divider,
                        TextFieldContainer(
                          text: "BHK",
                          controllerName: bhkctlr,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter about property';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Only numbers allowed';
                            }
                            return null;
                          },
                        ),
                        divider,
                        TextFieldContainer(
                          text: "Bathrooms",
                          controllerName: bathroomctlr,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the quantity';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Only numbers allowed';
                            }
                            return null;
                          },
                        ),
                        divider,
                        TextFieldContainer(
                          text: "Carpet Area(sqft)",
                          controllerName: propertySqrftCtlr,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter sqft';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Only numbers allowed';
                            }
                            return null;
                          },
                        ),

                        divider,
                        CheckboxWithListenable(
                          text: 'Car parking',
                          value: carparking,
                          onChanged: (newValue) {
                            setState(() {
                              carparking = newValue ?? false;
                            });
                          },
                        ),
                        TextFieldContainer(
                          text: "maintenance(Monthly)",
                          controllerName: maintenancectlr,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the amount of maintence';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Only numbers allowed';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                if (propertyTypeCtlr.text == _items[2])
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Details", style: TextStyle(fontSize: 20)),
                        divider,
                        TextFieldContainer(
                          text: 'Property sqft',
                          controllerName: propertySqrftCtlr,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter property sqft';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Only numbers allowed';
                            }
                            return null;
                          },
                        ),
                        divider,
                        TextFieldContainer(
                          text: "Aminities",
                          controllerName: aminitiesctlr,
                          // validator: (String? value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter Aminities ';
                          //   }
                          //   return null;
                          // },
                        ),
                      ],
                    ),
                  ),
                divider,
                TextFieldContainer(
                  text: 'Description/Extra Details',
                  controllerName: descriptionCtlr,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter property description';
                    }
                    return null;
                  },
                ),
                divider,
                TextFieldContainer(
                  text: 'Location',
                  controllerName: locationCtlr,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GreenButton(
          text: 'Next',
          onTap: () {
            if (formKey.currentState!.validate()) {
              Map<String, dynamic> propertyDetailsAll = {};

              propertyDetailsAll = {
                "PROPERTY TYPE": _selectedValue,
                "PROPERTY PRICE": int.tryParse(priceCtlr.text.trim()),
                "BUILDING NAME": buildingNamectlr.text.trim(),
                "READY_TO_MOVE": readytoMove ? "YES" : "NO",
                "BHK": int.tryParse(bhkctlr.text.trim()),
                "BATHROOMS": int.tryParse(bathroomctlr.text.trim()),
                "CARPET AREA": int.tryParse(propertySqrftCtlr.text.trim()),
                'CARPARKING': carparking ? "yes" : "no",
                "MAINTENANCE": int.tryParse(maintenancectlr.text.trim()),

                "PROPERTY SQFT": int.tryParse(propertySqrftCtlr.text.trim()),
                "AMINITIES": aminitiesctlr.text.trim(),
                "PROPERTY DESCRIPTION": descriptionCtlr.text.trim(),
                "PROPERTY LOCATION": locationCtlr.text.trim(),
                "ADDED_DATE": DateTime.now()
              };

              // clearController();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddLandlordDetails(
                    propertyMap: propertyDetailsAll,
                    from: widget.from,
                    property: widget.property,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

