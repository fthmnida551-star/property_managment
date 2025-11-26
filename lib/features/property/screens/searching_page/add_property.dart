import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_managment/core/utils/cloudinary_img/dio.dart';
import 'package:property_managment/core/utils/cloudinary_img/picking_img.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/core/utils/checkbox.dart';
import 'package:property_managment/core/utils/green_button.dart';
import 'package:property_managment/core/utils/text_field.dart';
import 'package:property_managment/core/enum/save_button.dart';
import 'package:property_managment/features/property/controllers/property_cntlr.dart';
import 'package:property_managment/location/concert_section.dart';
import 'package:property_managment/location/pick_location.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/property/screens/searching_page/add_landlord_details.dart';
import 'package:property_managment/features/property/screens/searching_page/widget/dropdown._form_field.dart';

class AddProperty extends ConsumerStatefulWidget {
  final String from;
  final PropertyModel? property;
  AddProperty({super.key, required this.from, required this.property});

  @override
  ConsumerState<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends ConsumerState<AddProperty> {
  double? latitude;

  double? longitude;

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

  // File? file1;
  List<String> imageFile = [];

  // final ImagePicker _picker = ImagePicker();
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
      imageFile = widget.property!.image;
      _saveButtonMode = SaveButtonMode.edit;
    }
  }

  List<File> files = [];

  // pickImg() async {
  pickImg(WidgetRef ref) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
    );
    if (picked == null) return;

    ref.read(propertyImagesProvider.notifier).addImage(File(picked.path));
  }

  @override
void initState() {
    // TODO: implement initState
    super.initState();
    setControllersForUpdate();
  }
  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(propertyFormProvider);
    final pickedImages = ref.watch(propertyImagesProvider);
    final isLoading = ref.watch(loadingProvider);
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
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.searchbar,
                          // image: file1 != null
                          //     ? DecorationImage(
                          //         image: FileImage(file1!),
                          //         fit: BoxFit.cover,
                          //       )
                          //     : imageFile.length > 1
                          //     ? DecorationImage(
                          //         image: NetworkImage(imageFile[0]),
                          //         fit: BoxFit.cover,
                          //       )
                          //     : null,
                          image: pickedImages.length > 0
                              ? DecorationImage(
                                  image: FileImage(pickedImages[0]),
                                  fit: BoxFit.cover,
                                )
                              : (imageFile.length > 0
                                    ? DecorationImage(
                                        image: NetworkImage(imageFile[0]),
                                        fit: BoxFit.cover,
                                      )
                                    : null),

                          borderRadius: BorderRadius.circular(8),
                          border: BoxBorder.all(
                            width: 1,
                            color: AppColors.opacitygreyColor,
                          ),
                        ),
                        child: (pickedImages.isEmpty && imageFile.isEmpty)
                            ? Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AssetResource.camera,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ),
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.searchbar,
                         
                          image: pickedImages.length > 1
                              ? DecorationImage(
                                  image: FileImage(pickedImages[1]),
                                  fit: BoxFit.cover,
                                )
                              : (imageFile.length > 1
                                    ? DecorationImage(
                                        image: NetworkImage(imageFile[1]),
                                        fit: BoxFit.cover,
                                      )
                                    : null),

                          borderRadius: BorderRadius.circular(8),
                          border: BoxBorder.all(
                            width: 1,
                            color: AppColors.opacitygreyColor,
                          ),
                        ),
                        child: (pickedImages.isEmpty && imageFile.isEmpty)
                            ? Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AssetResource.camera,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ),
                      Container(
                        height: 150,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.searchbar,
                         
                          image: pickedImages.length > 2
                              ? DecorationImage(
                                  image: FileImage(pickedImages[2]),
                                  fit: BoxFit.cover,
                                )
                              : (imageFile.length > 2
                                    ? DecorationImage(
                                        image: NetworkImage(imageFile[2]),
                                        fit: BoxFit.cover,
                                      )
                                    : null),

                          borderRadius: BorderRadius.circular(8),
                          border: BoxBorder.all(
                            width: 1,
                            color: AppColors.opacitygreyColor,
                          ),
                        ),
                        child: (pickedImages.isEmpty && imageFile.isEmpty)
                            ? Center(
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AssetResource.camera,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      pickImg(ref);
                    },
                    child: Container(
                      height: 30,
                      width: 200,
                      decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          'Upload Images',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
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
                    _selectedValue = newValue;
                    propertyTypeCtlr.text = newValue!;
                    ref
                        .read(propertyFormProvider.notifier)
                        .updatePropertyType(newValue);
                  },
                ),

                divider,

                divider,
                TextFieldContainer(
                  text: 'Price',
                  controllerName: priceCtlr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter  property price';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Only numbers allowed';
                    }
                    ref
                        .read(propertyFormProvider.notifier)
                        .updatePrice(double.parse(value));
                    return null;
                  }, readOnly: false,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your building name';
                            }
                            ref
                                .read(propertyFormProvider.notifier)
                                .updateLocation(value);
                            return null;
                          }, readOnly: false,
                        ),

                        divider,

                        CheckboxWithListenable(
                          text: 'Ready to move',
                          value: readytoMove,
                          onChanged: (newValue) {
                            readytoMove = newValue ?? false;
                            ref
                                .read(propertyFormProvider.notifier)
                                .updateReadyToMove(readytoMove);
                          },
                        ),
                        divider,
                        TextFieldContainer(
                          text: "BHK",
                          controllerName: bhkctlr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter about property';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Only numbers allowed';
                            }
                            ref
                                .read(propertyFormProvider.notifier)
                                .updateBhk(int.parse(value));
                            return null;
                          }, readOnly: false,
                        ),
                        divider,
                        TextFieldContainer(
                          text: "Bathrooms",
                          controllerName: bathroomctlr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the quantity';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Only numbers allowed';
                            }
                            ref
                                .read(propertyFormProvider.notifier)
                                .updateBathrooms(int.parse(value));
                            return null;
                          }, readOnly: false,
                        ),
                        divider,
                        TextFieldContainer(
                          text: "Carpet Area(sqft)",
                          controllerName: propertySqrftCtlr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter sqft';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Only numbers allowed';
                            }
                            ref
                                .read(propertyFormProvider.notifier)
                                .updateSqft(double.parse(value));
                            return null;
                          }, readOnly: false,
                        ),

                        divider,
                        CheckboxWithListenable(
                          text: 'Car parking',
                          value: carparking,
                          onChanged: (newValue) {
                            carparking = newValue ?? false;
                            ref
                                .read(propertyFormProvider.notifier)
                                .updateCarParking(carparking);
                          },
                        ),
                        TextFieldContainer(
                          text: "maintenance(Monthly)",
                          controllerName: maintenancectlr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the amount of maintence';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Only numbers allowed';
                            }
                            ref
                                .read(propertyFormProvider.notifier)
                                .updateMaintenance(double.parse(value));
                            return null;
                          }, readOnly: false,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter property sqft';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Only numbers allowed';
                            }
                            ref
                                .read(propertyFormProvider.notifier)
                                .updateSqft(double.parse(value));
                            return null;
                          }, readOnly: false,
                        ),
                        divider,
                        TextFieldContainer(
                          text: "Aminities",
                          controllerName: aminitiesctlr,
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'Please enter Aminities ';
                            // }
                            ref
                                .read(propertyFormProvider.notifier)
                                .updateAminities(value!);
                          }, readOnly: false,
                        ),
                      ],
                    ),
                  ),
                divider,
                TextFieldContainer(
                  text: 'Description/Extra Details',
                  controllerName: descriptionCtlr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter property description';
                    }
                    ref
                        .read(propertyFormProvider.notifier)
                        .updateDescription(value);
                    return null;
                  }, readOnly: false,
                ),
                divider,
                TextFieldContainer(
                  
                  text: 'Location',
                  readOnly: true,
                  controllerName: locationCtlr,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    ref
                        .read(propertyFormProvider.notifier)
                        .updateLocation(value);
                    return null;
                  },
                ),
                SizedBox(height: 10),

                
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppColors.greenColor,
                      borderRadius: BorderRadius.circular(15)
                    ),
                  
                    child: InkWell(
                      
                      onTap: () async {
                        final pickedLocation = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PickLocationScreen(),
                          ),
                        );
                    
                        if (pickedLocation != null) {
                          latitude = pickedLocation.latitude;
                          longitude = pickedLocation.longitude;
                          String address = await convertLatLngToAddress(
                            latitude!,
                            longitude!,
                          );
                          locationCtlr.text = address;
                          ref
                              .read(propertyFormProvider.notifier)
                              .updateLocation(address);
                        }
                      },
                      child: Center(child: Text("Pick Location",style: TextStyle(color: AppColors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading 
        ?CircularProgressIndicator(
          color: AppColors.greenColor,
          padding: EdgeInsets.symmetric(horizontal: 140),)
        :GreenButton(
          text: 'Next',
          // onTap: () async {
          //   if (formKey.currentState!.validate()) {
          //     Map<String, dynamic> propertyDetailsAll = {};
          //     // if (files.isNotEmpty) {
          //     //   final imageUrls = await uploadMultipleUnsigned(
          //     //     files,
          //     //     cloudName: 'dcijrvaw3',
          //     //     uploadPreset: 'property_images',
          //     //   );

          //     final pickedFiles = ref.read(propertyImagesProvider);
          //     List<String> finalImageUrls = [];
          //     if (pickedFiles.isNotEmpty) {
          //       // Upload the new picked files
          //       final imageUrls = await uploadMultipleUnsigned(
          //         pickedFiles,
          //         cloudName: 'dcijrvaw3',
          //         uploadPreset: 'property_images',
          //       );
          //       finalImageUrls = imageUrls;
          //     } else {
          //       // no new picks: if editing reuse existing URLs (imageFile)
          //       finalImageUrls =
          //           imageFile; // may be empty if adding new property with no picks
          //     }

          //     if (finalImageUrls.isEmpty) {
          //       alertForImgAdd(context);
          //       return;
          //     }

          //     propertyDetailsAll = {
          //       "PROPERTY TYPE": _selectedValue,
          //       "PROPERTY PRICE": int.tryParse(priceCtlr.text.trim()),
          //       "BUILDING NAME": buildingNamectlr.text.trim(),
          //       "READY_TO_MOVE": readytoMove ? "YES" : "NO",
          //       "BHK": int.tryParse(bhkctlr.text.trim()),
          //       "BATHROOMS": int.tryParse(bathroomctlr.text.trim()),
          //       "CARPET AREA": int.tryParse(propertySqrftCtlr.text.trim()),
          //       'CARPARKING': carparking ? "yes" : "no",
          //       "MAINTENANCE": int.tryParse(maintenancectlr.text.trim()),
          //       "PROPERTY SQFT": int.tryParse(propertySqrftCtlr.text.trim()),
          //       "AMINITIES": aminitiesctlr.text.trim(),
          //       "PROPERTY DESCRIPTION": descriptionCtlr.text.trim(),
          //       "PROPERTY LOCATION": locationCtlr.text.trim(),
          //       "LATITUDE": latitude,
          //       "LONGITUDE": longitude,
          //       "ADDED_DATE": DateTime.now(),
          //       "IMAGE": finalImageUrls,
          //     };

          //     // clearController();

          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => AddLandlordDetails(
          //           propertyMap: propertyDetailsAll,
          //           from: from,
          //           property: property,
          //         ),
          //       ),
          //     );
          //     // } else {
          //     //   alertForImgAdd(context);
          //     // }
          //   }
          // },
          // onTap: isLoading ? () {} : () => _handleNext(context, ref),
          onTap: () {
  if (!isLoading) _handleNext(context, ref);
},


        ),
      ),
    );
  }

  Future<void> _handleNext(BuildContext context, WidgetRef ref) async {
  if (!formKey.currentState!.validate()) return;

  ref.read(loadingProvider.notifier).state = true; // show loader

  try {
   
    final pickedFiles = ref.read(propertyImagesProvider);
    List<String> finalImageUrls = [];

    if (pickedFiles.isNotEmpty) {
      final urls = await uploadMultipleUnsigned(
        pickedFiles,
        cloudName: 'dcijrvaw3',
        uploadPreset: 'property_images',
      );
      finalImageUrls = urls;
    } else {
      finalImageUrls = imageFile;
    }

    if (finalImageUrls.isEmpty) {
      alertForImgAdd(context);
      return;
    }

    final propertyDetailsAll = {
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
      "LATITUDE": latitude,
      "LONGITUDE": longitude,
      "ADDED_DATE": DateTime.now(),
      "IMAGE": finalImageUrls,
    };


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
  } catch (e) {
    debugPrint("Error uploading property: $e");
  } finally {
    ref.read(loadingProvider.notifier).state = false; 
  }
}
}

void alertForImgAdd(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Please add atleast one image',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
