import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class GeolocationManager{

  static Future<bool> areAllPermissionGranted()
  async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied)
      _permissionGranted = await location.requestPermission();

    if(_serviceEnabled == false && _permissionGranted == PermissionStatus.denied)
      return false;
    else return true;
  }

  static int getDistanceInMeterBetweenHereAndAnotherPlace(LocationData currentLocation ,LatLng anotherPlace)
   {
    Distance distance = new Distance();
    LatLng currentLatLng = LatLng(currentLocation.latitude, currentLocation.longitude);
    return distance.distance(currentLatLng, anotherPlace);
  }
}