
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:property_managment/core/provider/firebse_provider.dart';
import 'package:property_managment/features/property/repository/property_repo.dart';
import 'package:property_managment/modelClass/property_model.dart';

class PropertyFormState {
  final String name;
  final String propertyType;
  final String location;
  final String description;
  final double price;
  final int bhk;
  final int bathrooms;
  final bool readyToMove;
  final bool carParking;
  final double maintenance;
  final double sqft;
  final String aminities;
  final bool isOwner;
  final String ownername;
  final String contact;
  final String email;
  final bool isBooked;
  final String bookingid;
  final List<String> image;
  final double? latitude;
  final double? longitude;

  const PropertyFormState({
    this.name = "",
    this.propertyType = '',
    this.location = '',
    this.description = '',
    this.price = 0,
    this.maintenance = 0,
    this.sqft = 0,
    this.bhk = 0,
    this.bathrooms = 0,
    this.readyToMove = false,
    this.carParking = false,
    this.aminities = '',
    this.isOwner = false,
    this.ownername = '',
    this.contact = '',
    this.email = '',
    this.isBooked = false,
    this.bookingid = '',
    this.image = const [],
    this.latitude,
    this.longitude,
  });
  PropertyFormState copyWith({
    String? name,
    String? propertyType,
    String? location,
    String? description,
    double? price,
    int? bhk,
    int? bathrooms,
    bool? readyToMove,
    bool? carParking,
    double? maintenance,
    double? sqft,
    String? aminities,
    bool? isOwner,
    String? ownername,
    String? contact,
    String? email,
    bool? isBooked,
    String? bookingid,
    List<String>? image,
    double? latitude,
    double? longitude,
  }) {
    return PropertyFormState(
      name: name ?? this.name,
      propertyType: propertyType ?? this.propertyType,
      location: location ?? this.location,
      description: description ?? this.description,
      price: price ?? this.price,
      bhk: bhk ?? this.bhk,
      bathrooms: bathrooms ?? this.bathrooms,
      readyToMove: readyToMove ?? this.readyToMove,
      carParking: carParking ?? this.carParking,
      maintenance: maintenance ?? this.maintenance,
      sqft: sqft ?? this.sqft,
      aminities: aminities ?? this.aminities,
      isOwner: isOwner ?? this.isOwner,
      ownername: ownername ?? this.ownername,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      isBooked: isBooked ?? this.isBooked,
      bookingid: bookingid ?? this.bookingid,
      image: image ?? this.image,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

class PropertyFormNotifier extends StateNotifier<PropertyFormState> {
  PropertyFormNotifier() : super(const PropertyFormState());

  void updateName(String v) => state = state.copyWith(name: v);
  void updatePropertyType(String v) => state = state.copyWith(propertyType: v);
  void updateLocation(String v) => state = state.copyWith(location: v);
  void updateDescription(String v) => state = state.copyWith(description: v);
  void updatePrice(double v) => state = state.copyWith(price: v);
  void updateMaintenance(double v) => state = state.copyWith(maintenance: v);
  void updateSqft(double v) => state = state.copyWith(sqft: v);
  void updateBhk(int v) => state = state.copyWith(bhk: v);
  void updateBathrooms(int v) => state = state.copyWith(bathrooms: v);
  void updateReadyToMove(bool v) => state = state.copyWith(readyToMove: v);
  void updateCarParking(bool v) => state = state.copyWith(carParking: v);
  void updateAminities(String v) => state = state.copyWith(aminities: v);
  void updateIsOwner(bool v) => state = state.copyWith(isOwner: v);
  void updateOwnerName(String v) => state = state.copyWith(ownername: v);
  void updateContact(String v) => state = state.copyWith(contact: v);
  void updateEmail(String v) => state = state.copyWith(email: v);
  void updateIsBooked(bool v) => state = state.copyWith(isBooked: v);
  void updateBookingId(String v) => state = state.copyWith(bookingid: v);

  void addImage(String imgUrl) =>
      state = state.copyWith(image: [...state.image, imgUrl]);

  void removeImage(String imgUrl) => state = state.copyWith(
    image: state.image.where((e) => e != imgUrl).toList(),
  );

  void updateLatLong(double? lat, double? long) =>
      state = state.copyWith(latitude: lat, longitude: long);

  void clear() => state = const PropertyFormState();
}

final propertyFormProvider =
    StateNotifierProvider<PropertyFormNotifier, PropertyFormState>((ref) {
      return PropertyFormNotifier();
    });

final propertyRepoProvider = Provider(
  (ref) => PropertyRepo(ref.watch(firebaseServiceProvider)),
);

final propertyListProvider = StreamProvider(
  (ref) => ref.watch(propertyRepoProvider).getAllPropertyDetailsList(),
);

final isOwnPropertyProvider = StateProvider<bool>((ref) => false);
final loadingProvider = StateProvider<bool>((ref) => false);


class FilterParams {
  final List<String> types;
  final RangeValues? price;
  final RangeValues? sqft;

  FilterParams({required this.types, required this.price, required this.sqft});
}

final filteredPropertyProvider = StreamProvider.family((
  ref,
  FilterParams params,
) {
  final repo = ref.read(propertyRepoProvider);
  return repo.getFilteredPropertyListStream(
    params.types,
    params.price,
    params.sqft,
  );
});

final searchQueryProvider = StateProvider<String>((ref) => "");

final searchPropertyProvider =
    StreamProvider.family<List<PropertyModel>, String>((ref, query) {
      final repo = ref.watch(propertyRepoProvider);
      
      return repo.searchPropertiesStream(query);
    }
);

final propertyImagesProvider = StateNotifierProvider<PropertyImagesNotifier, List<File>>(
  (ref) => PropertyImagesNotifier(),
);

class PropertyImagesNotifier extends StateNotifier<List<File>> {
  PropertyImagesNotifier() : super([]);

  void addImage(File file) {
    state = [...state, file];
  }

  void clear() {
    state = [];
  }
}



