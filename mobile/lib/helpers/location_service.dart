import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {


  Future<void> getCurrentLocation() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(44.731048, 18.077646);
    
    final city = placemarks[0].locality;
    print(city);
  }


Future<bool> havePermissionForLocation() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return false;
  } 
  
  return true;
}

}