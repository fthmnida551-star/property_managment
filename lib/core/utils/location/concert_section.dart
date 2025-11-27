
import 'package:geocoding/geocoding.dart';

Future<String> convertLatLngToAddress(double lat, double lng) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;

      return "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    } else {
      return "Unknown location";
    }
  } catch (e) {
    return "Error fetching address";
  }
}