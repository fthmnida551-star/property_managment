import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/firebase/save_button.dart';
import 'package:property_managment/presentation/searching_page/add_landlord_details.dart';
import 'package:property_managment/presentation/searching_page/widget/dropdown._form_field.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/checkbox.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';
import 'package:image_picker/image_picker.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({super.key});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  String? _selectedValue;
  final List<String> _items = ['APARTMENT', 'VILLA', 'LAND'];
  final formKey = GlobalKey<FormState>();
  Widget divider = SizedBox(height: 10);
  bool readytoMove = false;
  bool carparking=false;
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

  final SaveButtonMode _saveButtonMode = SaveButtonMode.save;

  clearController() {
    propertyTypeCtlr.clear();
    priceCtlr.clear();
    buildingNamectlr.clear();
    bhkctlr.clear();
    bathroomctlr.clear();
    carpetAreactlr.clear();
    maintenancectlr.clear();
    aminitiesctlr.clear();
    propertySqrftCtlr.clear();
    descriptionCtlr.clear();
    locationCtlr.clear();
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
                       
                        CheckboxWithListenable(text: 'Ready to move',
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
                        CheckboxWithListenable(text: 'Car parking', value: carparking,
                  onChanged: (newValue) {
                    setState(() {
                      carparking = newValue ?? false;
                    });
                  },),
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
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Aminities ';
                            }
                            return null;
                          },
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
              if (_saveButtonMode == SaveButtonMode.save) {
                propertyDetailsAll = {
                  "PROPERTY TYPE": _selectedValue,
                  "PROPERTY PRICE": int.tryParse(priceCtlr.text.trim()),
                  "BUILDING NAME": buildingNamectlr.text.trim(),
                   "READY_TO_MOVE": readytoMove ? "YES" : "NO",
                  " BHK": int.tryParse(bhkctlr.text.trim()),
                  " BATHROOMS": int.tryParse(bathroomctlr.text.trim()),
                  " CARPET AREA": int.tryParse(
                    propertySqrftCtlr.text.trim(),
                  ),
                  'CARPARKING':carparking? "yes": "no",
                  " MAINTENANCE": int.tryParse(
                    maintenancectlr.text.trim(),
                  ),
                 
                  " PROPERTY SQFT": int.tryParse(
                    propertySqrftCtlr.text.trim(),
                  ),
                  "  AMINITIES": int.tryParse(
                    aminitiesctlr.text.trim(),
                  ),
                  "PROPERTY DESCRIPTION": descriptionCtlr.text.trim(),
                  "PROPERTY LOCATION": locationCtlr.text.trim(),
                };

                clearController();
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddLandlordDetails(propertyMap: propertyDetailsAll),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}


// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:property_managment/core/theme/app_colors.dart';
// import 'package:property_managment/core/theme/asset_resource.dart';
// import 'package:property_managment/firebase/save_button.dart';
// import 'package:property_managment/presentation/searching_page/add_landlord_details.dart';
// import 'package:property_managment/presentation/searching_page/widget/dropdown._form_field.dart';
// import 'package:property_managment/widget/appbar_widget.dart';
// import 'package:property_managment/widget/checkbox.dart';
// import 'package:property_managment/widget/green_button.dart';
// import 'package:property_managment/widget/text_field.dart';

// // ✅ Location Picker Page
// class MapLocationPicker extends StatefulWidget {
//   const MapLocationPicker({super.key});

//   @override
//   State<MapLocationPicker> createState() => _MapLocationPickerState();
// }

// class _MapLocationPickerState extends State<MapLocationPicker> {
//   LatLng? _selectedPosition;
//   late GoogleMapController mapController;

//   final LatLng _initialPosition = const LatLng(12.9716, 77.5946); // Default

//   void _onTap(LatLng position) {
//     setState(() {
//       _selectedPosition = position;
//     });
//   }

//   Future<String> _getAddressFromLatLng(LatLng position) async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       position.latitude,
//       position.longitude,
//     );
//     final place = placemarks.first;
//     return "${place.street}, ${place.locality}, ${place.administrativeArea}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Pick Location")),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 12),
//         onMapCreated: (controller) => mapController = controller,
//         onTap: _onTap,
//         markers: _selectedPosition == null
//             ? {}
//             : {
//                 Marker(
//                   markerId: const MarkerId('selected'),
//                   position: _selectedPosition!,
//                 )
//               },
//       ),
//       floatingActionButton: _selectedPosition == null
//           ? null
//           : FloatingActionButton.extended(
//               onPressed: () async {
//                 String address = await _getAddressFromLatLng(_selectedPosition!);
//                 Navigator.pop(context, {
//                   'coords': _selectedPosition,
//                   'address': address,
//                 });
//               },
//               label: const Text('Confirm Location'),
//               icon: const Icon(Icons.check),
//             ),
//     );
//   }
// }

// // ✅ Main Add Property Page
// class AddProperty extends StatefulWidget {
//   const AddProperty({super.key});

//   @override
//   State<AddProperty> createState() => _AddPropertyState();
// }

// class _AddPropertyState extends State<AddProperty> {
//   String? _selectedValue;
//   final List<String> _items = ['APARTMENT', 'VILLA', 'LAND'];
//   final formKey = GlobalKey<FormState>();
//   Widget divider = const SizedBox(height: 10);
//   bool readytoMove = false;
//   bool carparking = false;

//   // Controllers
//   TextEditingController propertyTypeCtlr = TextEditingController();
//   TextEditingController priceCtlr = TextEditingController();
//   TextEditingController buildingNamectlr = TextEditingController();
//   TextEditingController bhkctlr = TextEditingController();
//   TextEditingController bathroomctlr = TextEditingController();
//   TextEditingController carpetAreactlr = TextEditingController();
//   TextEditingController maintenancectlr = TextEditingController();
//   TextEditingController propertySqrftCtlr = TextEditingController();
//   TextEditingController aminitiesctlr = TextEditingController();
//   TextEditingController descriptionCtlr = TextEditingController();
//   TextEditingController locationCtlr = TextEditingController();

//   File? _selectedImage;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   final SaveButtonMode _saveButtonMode = SaveButtonMode.save;

//   clearController() {
//     propertyTypeCtlr.clear();
//     priceCtlr.clear();
//     buildingNamectlr.clear();
//     bhkctlr.clear();
//     bathroomctlr.clear();
//     carpetAreactlr.clear();
//     maintenancectlr.clear();
//     aminitiesctlr.clear();
//     propertySqrftCtlr.clear();
//     descriptionCtlr.clear();
//     locationCtlr.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppbarWidget(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () => Navigator.pop(context),
//                 child: const Icon(
//                   Icons.keyboard_arrow_left_outlined,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//               ),
//               Text('Add Property',
//                   style: TextStyle(color: Colors.white, fontSize: 19.sp)),
//             ],
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 // 🖼 Image Picker
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GestureDetector(
//                     onTap: _pickImage,
//                     child: Container(
//                       width: 368,
//                       height: 200,
//                       decoration: BoxDecoration(
//                         color: AppColors.searchbar,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(
//                             width: 1, color: AppColors.opacitygreyColor),
//                         image: _selectedImage != null
//                             ? DecorationImage(
//                                 image: FileImage(_selectedImage!),
//                                 fit: BoxFit.cover,
//                               )
//                             : null,
//                       ),
//                       child: _selectedImage == null
//                           ? Center(
//                               child: Container(
//                                 height: 50,
//                                 width: 50,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.greenColor,
//                                   borderRadius: BorderRadius.circular(40),
//                                 ),
//                                 child: Center(
//                                   child: SvgPicture.asset(AssetResource.camera),
//                                 ),
//                               ),
//                             )
//                           : Align(
//                               alignment: Alignment.topRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       _selectedImage = null;
//                                     });
//                                   },
//                                   child: const CircleAvatar(
//                                     radius: 16,
//                                     backgroundColor: Colors.black54,
//                                     child: Icon(Icons.close,
//                                         color: Colors.white, size: 18),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Dropdown Property Type
//                 DropdownFormField(
//                   hintText: 'Property Type',
//                   items: _items,
//                   value: _selectedValue,
//                   validator: (value) =>
//                       value == null ? 'Please select a property type' : null,
//                   onChanged: (newValue) {
//                     setState(() {
//                       _selectedValue = newValue;
//                       propertyTypeCtlr.text = newValue!;
//                     });
//                   },
//                 ),
//                 divider,

//                 // Price Field
//                 TextFieldContainer(
//                   text: 'Price',
//                   controllerName: priceCtlr,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter property price';
//                     }
//                     if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
//                       return 'Only numbers allowed';
//                     }
//                     return null;
//                   },
//                 ),
//                 divider,

//                 // Type-specific sections
//                 if (propertyTypeCtlr.text == _items[0] ||
//                     propertyTypeCtlr.text == _items[1])
//                   _buildApartmentVillaDetails(),
//                 if (propertyTypeCtlr.text == _items[2])
//                   _buildLandDetails(),

//                 divider,
//                 TextFieldContainer(
//                   text: 'Description/Extra Details',
//                   controllerName: descriptionCtlr,
//                   validator: (value) =>
//                       value == null || value.isEmpty ? 'Enter description' : null,
//                 ),
//                 divider,

//                 // 🌍 Map Location Picker
//                 GestureDetector(
//                   onTap: () async {
//                     final result = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const MapLocationPicker(),
//                       ),
//                     );

//                     if (result != null) {
//                       setState(() {
//                         locationCtlr.text = result['address'];
//                       });
//                     }
//                   },
//                   child: AbsorbPointer(
//                     child: TextFieldContainer(
//                       text: 'Pick Location on Map',
//                       controllerName: locationCtlr,
//                       validator: (value) => value == null || value.isEmpty
//                           ? 'Please pick a location'
//                           : null,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: GreenButton(
//           text: 'Next',
//           onTap: () {
//             if (formKey.currentState!.validate()) {
//               Map<String, dynamic> propertyDetailsAll = {
//                 "PROPERTY TYPE": _selectedValue,
//                 "PROPERTY PRICE": int.tryParse(priceCtlr.text.trim()),
//                 "BUILDING NAME": buildingNamectlr.text.trim(),
//                 "READY_TO_MOVE": readytoMove ? "YES" : "NO",
//                 "BHK": int.tryParse(bhkctlr.text.trim()),
//                 "BATHROOMS": int.tryParse(bathroomctlr.text.trim()),
//                 "CARPET AREA": int.tryParse(propertySqrftCtlr.text.trim()),
//                 "CARPARKING": carparking ? "YES" : "NO",
//                 "MAINTENANCE": int.tryParse(maintenancectlr.text.trim()),
//                 "PROPERTY SQFT": int.tryParse(propertySqrftCtlr.text.trim()),
//                 "AMINITIES": aminitiesctlr.text.trim(),
//                 "DESCRIPTION": descriptionCtlr.text.trim(),
//                 "LOCATION": locationCtlr.text.trim(),
//               };

//               clearController();

//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       AddLandlordDetails(propertyMap: propertyDetailsAll),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   // 🏢 Apartment/Villa Details Widget
//   Widget _buildApartmentVillaDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Details", style: TextStyle(fontSize: 20)),
//         divider,
//         TextFieldContainer(
//           text: "Building name",
//           controllerName: buildingNamectlr,
//           validator: (value) =>
//               value == null || value.isEmpty ? 'Please enter building name' : null,
//         ),
//         divider,
//         CheckboxWithListenable(
//           text: 'Ready to move',
//           value: readytoMove,
//           onChanged: (newValue) {
//             setState(() {
//               readytoMove = newValue ?? false;
//             });
//           },
//         ),
//         divider,
//         TextFieldContainer(
//           text: "BHK",
//           controllerName: bhkctlr,
//           validator: (value) =>
//               value == null || value.isEmpty ? 'Enter BHK' : null,
//         ),
//         divider,
//         TextFieldContainer(
//           text: "Bathrooms",
//           controllerName: bathroomctlr,
//           validator: (value) =>
//               value == null || value.isEmpty ? 'Enter bathrooms' : null,
//         ),
//         divider,
//         TextFieldContainer(
//           text: "Carpet Area(sqft)",
//           controllerName: propertySqrftCtlr,
//           validator: (value) =>
//               value == null || value.isEmpty ? 'Enter sqft' : null,
//         ),
//         divider,
//         CheckboxWithListenable(
//           text: 'Car parking',
//           value: carparking,
//           onChanged: (newValue) {
//             setState(() {
//               carparking = newValue ?? false;
//             });
//           },
//         ),
//         divider,
//         TextFieldContainer(
//           text: "Maintenance (Monthly)",
//           controllerName: maintenancectlr,
//           validator: (value) =>
//               value == null || value.isEmpty ? 'Enter maintenance' : null,
//         ),
//       ],
//     );
//   }

//   // 🌳 Land Details Widget
//   Widget _buildLandDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Details", style: TextStyle(fontSize: 20)),
//         divider,
//         TextFieldContainer(
//           text: 'Property sqft',
//           controllerName: propertySqrftCtlr,
//           validator: (value) =>
//               value == null || value.isEmpty ? 'Enter property sqft' : null,
//         ),
//         divider,
//         TextFieldContainer(
//           text: "Amenities",
//           controllerName: aminitiesctlr,
//           validator: (value) =>
//               value == null || value.isEmpty ? 'Enter amenities' : null,
//         ),
//       ],
//     );
//   }
// }
