import 'dart:async';

import 'package:amadyar/controllers/server_data.dart';
import 'package:amadyar/models/order.dart';
import 'package:amadyar/models/order_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapProvider with ChangeNotifier {
  Timer? _timer;
  List<OrderLog> _orderLogs = [];

  late Order _nextOrder;
  late List<LatLng> _nextOrderPath;

  final double _minMapZoom = 8;
  final double _maxMapZoom = 18;

  LatLng _mapCenter = LatLng(29.64, 52.48);
  double _zoom = 13;

  LatLng _myLocation = LatLng(0, 0);

  MapController _mapController = MapController();

  void creatingMapController() {
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

  Future<void> _addLog(int orderId, LogAction action) async {
    Position? position = await _getCurrentPosition();
    double _lat = 0;
    double _long = 0;
    if (position != null) {
      _lat = position.latitude;
      _long = position.longitude;
    }
    _orderLogs.add(
      OrderLog(
        orderId: orderId,
        latitude: _lat,
        longitude: _long,
        action: action,
        dateTime: DateTime.now(),
      ),
    );
  }

  void runTracker(int orderId) async {
    _orderLogs = [];
    await _addLog(orderId, LogAction.STARTED);

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) async {
        await _addLog(orderId, LogAction.ON_THE_WAY);
      },
    );
  }

  void stopTracker(int orderId) async {
    _timer?.cancel();
    await _addLog(orderId, LogAction.ENDED);

    List<Map<String, dynamic>> _logsData = [];
    for (OrderLog log in _orderLogs) {
      _logsData.add(log.toMap());
    }

    await _submitOrderLogs(_logsData);
  }

  Future<void> _submitOrderLogs(List<Map> data) async {
    Dio dio = await ServerData().getDio();
    try {
      await dio.post('/haul/order/uncompleted/', data: data);
    } catch (e) {
      print('problem in submitting order logs');
    }
  }

  void changeMyLocation(double lat, double long) {
    _myLocation = LatLng(lat, long);
    notifyListeners();
  }

  Future<void> getDriverNextOrder() async {
    Dio dio = await ServerData().getDio();
    var response = await dio.get('haul/next_order/');
    Map<String, dynamic> data = response.data;
    _nextOrder = Order(
      id: data['id'],
      title: data['title'],
      statusText: data['status'],
      weight: data['weight'],
      startTw: data['start_tw'],
      endTw: data['end_tw'],
      estimationArrival: data['estimation_arrival'],
      estimationDepart: data['estimation_depart'],
    );

    _nextOrderPath = [];
    response.data['paths'].forEach((data) {
      _nextOrderPath.add(LatLng(data['latitude'], data['longitude']));
    });
    notifyListeners();
  }

  void setMyFakeLocation() {
    _myLocation = _nextOrderPath.first;
    // notifyListeners();
  }

  LatLng get myLocation => _myLocation;

  Order get nextOrder => _nextOrder;

  double get minMapZoom => _minMapZoom;

  double get maxMapZoom => _maxMapZoom;

  MapController get mapController => _mapController;

  LatLng get mapCenter => _mapCenter;

  double get zoom => _zoom;

  List<LatLng> get nextOrderPath => _nextOrderPath;
}
