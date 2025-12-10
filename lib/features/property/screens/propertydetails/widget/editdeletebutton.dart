import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/provider/sharepreference.dart';
import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
import 'package:property_managment/features/booking/controller/booking_controllers.dart';
import 'package:property_managment/features/booking/screens/booking_details.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';

class BookedDetailsCard extends ConsumerWidget {
  final BookingModel bookedData;
  final PropertyModel property;
  // final String userRole;
  

  const BookedDetailsCard({
    super.key,
    required this.bookedData,
    required this.property,
    // required this.userRole,
    
    
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final loginanme = ref.watch(userNameProvider);
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30,
              
                child: Text(
                  'Booked Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              PopupMenuButton(
                onSelected: (value) {
                  print("Selected: $value");
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: 'edit',
                   onTap: () async {
                            final updatedBooking = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingDetails(
                                  propertyId: property.id,
                                  bookedData: bookedData, // updated booking
                                ),
                              ),
                            );
                            if (updatedBooking != null) {
                              ref
                                  .read(bookingRepoProvider)
                                  .updateBooking(bookedData.id, bookedData.toMap());
                            }
                          },
                   child: Text('Edit')),
                  PopupMenuItem(value: 'delete',
                    onTap: () async {
                            ref
                                .read(bookingRepoProvider)
                                .deleteBooking(property.bookingid, property.id,loginanme.value!);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigationWidget(
                                  currentIndex: 1,
                                  propertytype: [],
                                  price: null,
                                  sqft: null,
                                ),
                              ),
                            );
                          },
                   child: Text('Delete')),
                ],
               ),
              
            ],
          ),
          const SizedBox(height: 15),
          _detailRow(Icons.person, bookedData.name),
          _detailRow(Icons.phone, bookedData.contact),
          _detailRow(Icons.mail, bookedData.email),
          _detailRow(Icons.calendar_month_rounded, bookedData.date),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
  // Reusable row widget
  Widget _detailRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}

