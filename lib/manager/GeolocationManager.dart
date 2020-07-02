import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class GeolocationManager{

  static Future<void> askForPermission()
  async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied)
      _permissionGranted = await location.requestPermission();
  }

  static Future<bool> areAllPermissionGranted() async
  {
    bool result;
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    _permissionGranted = await location.hasPermission();
    if(_serviceEnabled == false) return false;
    switch(_permissionGranted){
      case PermissionStatus.granted:
        result = true;
        break;
      case PermissionStatus.denied:
        result = false;
        break;
      case PermissionStatus.deniedForever:
        result = false;
        break;
    }
    return result;
  }

  static int getDistanceInMeterBetweenHereAndAnotherPlace(LocationData currentLocation ,LatLng anotherPlace)
   {
    Distance distance = new Distance();
    LatLng currentLatLng = LatLng(currentLocation.latitude, currentLocation.longitude);
    return distance.distance(currentLatLng, anotherPlace);
  }
}