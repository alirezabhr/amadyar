import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapProvider with ChangeNotifier {
  final double _minMapZoom = 8;
  final double _maxMapZoom = 18;

  LatLng _mapCenter = LatLng(29.64, 52.48);
  double _zoom = 13;

  LatLng _myLocation = LatLng(0, 0);

  MapController _mapController = MapController();

  void creatingMapController () {
    _mapController = MapController();
  }

  void zoomIn() {
    _zoom = _mapController.zoom;
    if (_zoom + 1 <= _maxMapZoom) {
      _zoom += 1;
      _mapCenter = _mapController.center;
      _mapController.move(_mapCenter, _zoom);
    } else {
      throw ErrorHint('نقشه در بزرگترین حالت است.');
    }
  }

  void zoomOut() {
    _zoom = _mapController.zoom;
    if (_zoom - 1 >= _minMapZoom) {
      _zoom -= 1;
      _mapCenter = _mapController.center;
      _mapController.move(_mapCenter, _zoom);
    } else {
      throw ErrorHint('نقشه در کوچکترین حالت است.');
    }
  }

  void rotateToNorth() {
    _mapController.rotate(0);
  }

  Future<void> gpsButtonEvent() async {
    Position? position = await _getCurrentPosition();
    double _positionLat = position != null ? position.latitude : 0;
    double _positionLong = position != null ? position.longitude : 0;

    _mapCenter = _myLocation;
    _zoom = 13;
    _mapController.move(_mapCenter, _zoom);

    changeMyLocation(_positionLat, _positionLong);
  }

  Future<Position?> _getCurrentPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void changeMyLocation(double lat, double long) {
    _myLocation = LatLng(lat, long);
    notifyListeners();
  }

  LatLng get myLocation => _myLocation;

  double get minMapZoom => _minMapZoom;

  double get maxMapZoom => _maxMapZoom;

  MapController get mapController => _mapController;

  LatLng get mapCenter => _mapCenter;

  double get zoom => _zoom;
}
