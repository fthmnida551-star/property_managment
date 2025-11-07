// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:property_managment/core/theme/app_colors.dart';
// // import 'dart:developer';

// // import 'package:property_managment/widget/bottom_navigation_bar.dart';

// // class FilterSortPage extends StatefulWidget {
// //   const FilterSortPage({super.key});

// //   @override
// //   State<FilterSortPage> createState() => _FilterSortPageState();

// // }

// // class _FilterSortPageState extends State<FilterSortPage> {
// //   FirebaseFirestore firestore = FirebaseFirestore.instance;
// //   // Future<void> readproperties()async{
// //   //   try {} finally{
// //   //     QuerySnapshot snapshot = await firestore.collection("PROPERTIES").get();
// //   //     for(var doc in snapshot.docs){
// //   //       log("property name: ${doc["name"]}");
// //   //       log("type:${doc["price"]}");
// //   //       log("Price: ${doc['price']}");
// //   //       log("Area (sqft): ${doc['sqft']}");
// //   //       log("------------------");

// //   //     }
// //   //   }
// //   // }
// //   // Future<void> readproperties() async {
// //   //   try {
// //   //     QuerySnapshot snapshot = await firestore.collection("PROPERTIES").get();

// //   //     for (var doc in snapshot.docs) {
// //   //       log(
// //   //         "Property Description: ${doc['PROPERTY DESCRIPTION'] ?? 'No description'}",
// //   //         name: "Firestore",
// //   //       );
// //   //       log(
// //   //         "Property Location: ${doc['PROPERTY LOCATION'] ?? 'No location'}",
// //   //         name: "Firestore",
// //   //       );
// //   //       log(
// //   //         "Property Sqft: ${doc['DETAILS PROPERTY SQFT'] ?? 'No sqft'}",
// //   //         name: "Firestore",
// //   //       );
// //   //       log(
// //   //         "Is Own Property: ${doc['IS_OWN_PROPERTY'] ?? 'Not specified'}",
// //   //         name: "Firestore",
// //   //       );
// //   //       log("Owner Name: ${doc['OWNER_NAME'] ?? 'No name'}", name: "Firestore");
// //   //       log("--------------------------------", name: "Firestore");
// //   //     }
// //   //   } catch (e, stackTrace) {
// //   //     log(
// //   //       "Error fetching properties: $e",
// //   //       name: "FirestoreError",
// //   //       error: e,
// //   //       stackTrace: stackTrace,
// //   //     );
// //   //   }
// //   // }

// //   int selectedIndex = 0;
// //   RangeValues priceRange = const RangeValues(1000, 10000);
// //   RangeValues sqftRange = const RangeValues(500, 5000);

// //  List<String>selectedproperty=[];

// //  Map<String, bool> propertyTypes = {
// //     'Apartment': false,
// //     'Villa': true,
// //     'Land': false,
// //   };

// //   @override
// //   void initState() {
// //   super.initState();

// //   // propertyTypes.forEach((key, value) {
// //   //   print('Key: $key, Value: $value');
// //   //   if(value== true){
// //   //     selectedproperty.add(key.toUpperCase());
// //   //   }
// //   // }

// // //  );
// // }
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           "Filters & Sort",
// //           style: TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //         backgroundColor: AppColors.white,
// //         elevation: 1,
// //         foregroundColor: AppColors.black,
// //       ),
// //       body: SafeArea(
// //         // ✅ Prevents bottom overflow
// //         child: Row(
// //           children: [
// //             // Left Side Menu
// //             Container(
// //               width: 130,
// //               color: AppColors.greyColor,
// //               child: ListView(
// //                 children: [
// //                   buildMenuItem("Property Type", 0),
// //                   buildMenuItem("Price", 1),
// //                   buildMenuItem("Price per Sqft", 2),
// //                   buildMenuItem("Area Sqft", 3),
// //                 ],
// //               ),
// //             ),

// //             // Right Side Content
// //             Expanded(
// //               child: Column(
// //                 children: [
// //                   Expanded(
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(16),
// //                       child: getFilterContent(),
// //                     ),
// //                   ),

// //                   // Buttons Section
// //                   Padding(
// //                     padding: const EdgeInsets.only(
// //                       left: 16,
// //                       right: 16,
// //                       bottom: 20,
// //                       top: 10,
// //                     ), // ✅ Space above nav bar
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         Expanded(
// //                           child: ElevatedButton(
// //                             onPressed: () {
// //                               setState(() {
// //                                 propertyTypes.updateAll((key, value) => false);
// //                                 priceRange = const RangeValues(1000, 100000);
// //                                 sqftRange = const RangeValues(500, 50000);
// //                               });
// //                             },
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.grey.shade300,
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(12),
// //                               ),
// //                               minimumSize: const Size(double.infinity, 48),
// //                             ),
// //                             child: const Text(
// //                               "Clear",
// //                               style: TextStyle(color: Colors.black),
// //                             ),
// //                           ),
// //                         ),
// //                         const SizedBox(width: 12),
// //                         Expanded(
// //                           child: ElevatedButton(
// //                             // onPressed: ()  {

// //                             //    propertyTypes.forEach((key, value) {
// //                             //    print('Key: $key, Value: $value');
// //                             //    if(value== true){
// //                             //    selectedproperty.add(key.toUpperCase());
// //                             //   }
// //                             //  }

// //                             //  );

// //                             //  Future.delayed(Duration(seconds: 1),(){
// //                             //   if (selectedproperty.isEmpty) {
// //                             //  ScaffoldMessenger.of(context).showSnackBar(
// //                             //  const SnackBar(content: Text('Please select at least one property type!')),
// //                             //    );
// //                             //    return;
// //                             //    }

// //                             //   Navigator.push(
// //                             //     context,
// //                             //     MaterialPageRoute(
// //                             //       builder:(context)=>
// //                             //       BottomNavigationWidget(currentIndex: 1, propertytype:selectedproperty , price: priceRange, sqft: sqftRange)
// //                             //        )

// //                             //   );
// //                             //  });

// //                             // },
// //                             onPressed: () {
// //   selectedproperty.clear(); // clear old selections

// //   propertyTypes.forEach((key, value) {
// //     if (value == true) {
// //       selectedproperty.add(key.toUpperCase());
// //     }
// //   });

// //   if (selectedproperty.isEmpty) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(
// //         content: Text('Please select at least one property type!'),
// //         duration: Duration(seconds: 2),
// //       ),
// //     );
// //     return; // stop here
// //   }

// //   Navigator.push(
// //     context,
// //     MaterialPageRoute(
// //       builder: (context) => BottomNavigationWidget(
// //         currentIndex: 1,
// //         propertytype: selectedproperty,
// //         price: priceRange,
// //         sqft: sqftRange,
// //       ),
// //     ),
// //   );
// // },

// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: AppColors.greenColor,
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(12),
// //                               ),
// //                               minimumSize: const Size(double.infinity, 48),
// //                             ),
// //                             child: const Text(
// //                               "Apply",
// //                               style: TextStyle(color: AppColors.white),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget buildMenuItem(String title, int index) {
// //     bool selected = selectedIndex == index;
// //     return InkWell(
// //       onTap: () => setState(() => selectedIndex = index),
// //       child: Container(
// //         color: selected ? Colors.green.shade700 : Colors.transparent,
// //         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
// //         child: Text(
// //           title,
// //           style: TextStyle(
// //             color: selected ? AppColors.white : AppColors.black,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget getFilterContent() {
// //     switch (selectedIndex) {
// //       case 0:
// //         return ListView(
// //           children: propertyTypes.keys.map((type) {
// //             return CheckboxListTile(
// //               title: Text(
// //                 type,
// //                 style: const TextStyle(
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //               value: propertyTypes[type],
// //               onChanged: (value) {
// //                 setState(() {
// //                   propertyTypes[type] = value!;
// //                 });
// //               },
// //             );
// //           }).toList(),
// //         );

// //       case 1:
// //         return Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               "Select Price Range (₹)",
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //             ),
// //             RangeSlider(
// //               values: priceRange,
// //               min: 1000,
// //               max: 10000,
// //               divisions: 10,
// //               labels: RangeLabels(
// //                 "₹${priceRange.start.toInt()}",
// //                 "₹${priceRange.end.toInt()}+",
// //               ),
// //               onChanged: (values) {
// //                 setState(() {
// //                   priceRange = values;
// //                 });
// //               },
// //             ),
// //           ],
// //         );

// //       case 2:
// //         return const Center(
// //           child: Text(
// //             "Price per Sqft filter coming soon...",
// //             style: TextStyle(fontSize: 16),
// //           ),
// //         );

// //       case 3:
// //         return Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text(
// //               "Choose a range below (sq ft)",
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //             ),
// //             RangeSlider(
// //               values: sqftRange,
// //               min: 500,
// //               max: 10000,
// //               divisions: 10,
// //               labels: RangeLabels(
// //                 sqftRange.start.toInt().toString(),
// //                 "${sqftRange.end.toInt()}+",
// //               ),
// //               onChanged: (values) {
// //                 setState(() {
// //                   sqftRange = values;
// //                 });
// //               },
// //             ),
// //           ],
// //         );

// //       default:
// //         return const SizedBox();
// //     }
// //   }
// // }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'dart:developer';

import 'package:property_managment/widget/bottom_navigation_bar.dart';

class FilterSortPage extends StatefulWidget {
  int initialIndex;
  FilterSortPage({super.key, required this.initialIndex});

  @override
  State<FilterSortPage> createState() => _FilterSortPageState();
}

class _FilterSortPageState extends State<FilterSortPage> {
  FirebaseFirestore fdb = FirebaseFirestore.instance;

  // late int selectedIndex;
  RangeValues priceRange = const RangeValues(1000, 1000000);
  RangeValues sqftRange = const RangeValues(100, 50000);

  // 🔹 Keep all property types initially false
  Map<String, bool> propertyTypes = {
    'Apartment': false,
    'Villa': false,
    'Land': false,
  };

  // 🔹 List to store selected property types
  List<String> selectedproperty = [];

  @override
  void initState() {
    super.initState();
    // selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Filters & Sort",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 1,
        foregroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationWidget(
                  currentIndex: 1,
                  price: null,
                  propertytype: [],
                  sqft: null,
                  // loginUser: null,
                ),
              ),
            );
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            // Left Menu
            Container(
              width: 130,
              color: AppColors.white,
              child: ListView(
                children: [
                  buildMenuItem("Property Type", 0),
                  buildMenuItem("Price", 1),

                  buildMenuItem("Area Sqft", 2),
                ],
              ),
            ),

            // Right Content
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: getFilterContent(),
                    ),
                  ),

                  // Buttons
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 20,
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 🔹 CLEAR BUTTON
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                // Reset all filters
                                propertyTypes.updateAll((key, value) => false);
                                priceRange = const RangeValues(1000, 100000);
                                sqftRange = const RangeValues(100, 50000);
                                selectedproperty.clear(); // clear list too
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Filters cleared successfully!',
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // 🔹 APPLY BUTTON
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              log("hhhhhhhhhhhhhhhhh");
                              selectedproperty.clear();

                              propertyTypes.forEach((key, value) {
                                if (value == true) {
                                  selectedproperty.add(key.toUpperCase());
                                }
                              });

                              log(
                                "Selected Properties: $selectedproperty",
                              ); // ✅ Debug check

                              if (selectedproperty.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please select at least one property type!',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavigationWidget(
                                    currentIndex: 1,
                                    propertytype: selectedproperty,
                                    price: priceRange,
                                    sqft: sqftRange,
                                  ),
                                ),
                              );
                            },

                            // onPressed: () {
                            //   selectedproperty.clear(); // reset selections

                            //   propertyTypes.forEach((key, value) {
                            //     if (value == true) {
                            //       selectedproperty.add(key.toUpperCase());
                            //     }
                            //   });

                            //   //🔸 Show Snackbar if nothing selected
                            //   if (selectedproperty.isEmpty) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text(
                            //             'Please select at least one property type!'),
                            //         duration: Duration(seconds: 2),
                            //       ),
                            //     );
                            //     return;
                            //   }

                            // 🔸 Navigate if valid
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => BottomNavigationWidget(
                            //         currentIndex: 1,
                            //         propertytype: selectedproperty,
                            //         price: priceRange,
                            //         sqft: sqftRange,
                            //       ),
                            //     ),
                            //   );
                            // },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.greenColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: const Text(
                              "Apply",
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Left-side Menu Builder
  Widget buildMenuItem(String title, int index) {
    bool selected = widget.initialIndex == index;
    return InkWell(
      onTap: () => setState(() => widget.initialIndex = index),
      child: Container(
        color: selected ? AppColors.greenColor : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? AppColors.white : AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // 🔹 Filter Options
  Widget getFilterContent() {
    log("getFilterContent  ${widget.initialIndex}");
    switch (widget.initialIndex) {
      case 0:
        return ListView(
          children: propertyTypes.keys.map((type) {
            return CheckboxListTile(
              title: Text(
                type,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: propertyTypes[type],
              onChanged: (value) {
                setState(() {
                  propertyTypes[type] = value!;
                });
              },
            );
          }).toList(),
        );

      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Price Range (₹)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RangeSlider(
              values: priceRange,
              min: 1000,
              max: 1000000,
              divisions: 10,
              labels: RangeLabels(
                "₹${priceRange.start.toInt()}",
                "₹${priceRange.end.toInt()}+",
              ),
              onChanged: (values) {
                setState(() {
                  priceRange = values;
                });
              },
            ),
          ],
        );

      // case 2:
      //   return const Center(
      //     child: Text(
      //       "Price per Sqft filter coming soon...",
      //       style: TextStyle(fontSize: 16),
      //     ),
      //   );

      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose a range below (sq ft)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RangeSlider(
              values: sqftRange,
              min: 100,
              max: 50000,
              divisions: 10,
              labels: RangeLabels(
                sqftRange.start.toInt().toString(),
                "${sqftRange.end.toInt()}+",
              ),
              onChanged: (values) {
                setState(() {
                  sqftRange = values;
                });
              },
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }
}
