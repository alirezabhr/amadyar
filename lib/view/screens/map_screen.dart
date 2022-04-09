import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../../dummy_data/dummy_routes.dart';
import '../widgets/map_north_button.dart';
import '../widgets/next_order_timeline_and_detail.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final double _estimatedDistance = 18;

  final double _minMapZoom = 8;
  final double _maxMapZoom = 18;
  final MapController _mapController = MapController();
  LatLng _mapCenter = LatLng(29.64, 52.48);
  double _zoom = 13;

  LatLng _myLocation = LatLng(0, 0);

  final List<LatLng> _destinations = [
    LatLng(dummyRoutes.last[1], dummyRoutes.last[0]),
  ];

  final List<LatLng> _routeLatLongs = dummyRoutes
      .map((latLongList) => LatLng(latLongList[1], latLongList[0]))
      .toList();

  void showDefaultSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _zoomIn() {
    _zoom = _mapController.zoom;
    if (_zoom + 1 <= _maxMapZoom) {
      _zoom += 1;
      _mapCenter = _mapController.center;
      _mapController.move(_mapCenter, _zoom);
    } else {
      showDefaultSnackBar('نقشه در بزرگترین حالت است.');
    }
  }

  void _zoomOut() {
    _zoom = _mapController.zoom;
    if (_zoom - 1 >= _minMapZoom) {
      _zoom -= 1;
      _mapCenter = _mapController.center;
      _mapController.move(_mapCenter, _zoom);
    } else {
      showDefaultSnackBar('نقشه در کوچکترین حالت است.');
    }
  }

  void _northButtonEvent() {
    print('north button pressed');
    double r = _mapController.rotation;
    _mapController.rotate(r);
  }

  Future<void> _gpsButtonEvent() async {
    Position? position = await _getCurrentPosition();
    double _positionLat = position != null ? position.latitude : 0;
    double _positionLong = position != null ? position.longitude : 0;

    setState(() {
      // _myLocation = LatLng(_positionLat, _positionLong);
      _mapCenter = _myLocation;
      _zoom = 13;
    });
    _mapController.move(_mapCenter, _zoom);
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

  Marker _truckMarker(LatLng location) {
    return Marker(
      point: location,
      width: 100,
      height: 100,
      builder: (context) =>
          Image.asset('assets/images/delivery_truck_24_24.png'),
    );
  }

  @override
  void initState() {
    _myLocation = LatLng(dummyRoutes.first[1], dummyRoutes.first[0]);
    _gpsButtonEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: _mapCenter,
                  zoom: _zoom,
                  plugins: [
                    MarkerClusterPlugin(),
                  ],
                ),
                layers: [
                  TileLayerOptions(
                    minZoom: _minMapZoom,
                    maxZoom: _maxMapZoom,
                    backgroundColor: Colors.black,
                    // errorImage: ,
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  PolylineLayerOptions(polylines: [
                    Polyline(
                      points: _routeLatLongs,
                      borderStrokeWidth: 2.5,
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.secondary,
                      borderColor: Theme.of(context).colorScheme.tertiary,
                    ),
                  ]),
                  MarkerLayerOptions(
                    markers: [
                      _truckMarker(_myLocation),
                      ..._destinations
                          .map((point) => Marker(
                                point: point,
                                width: 100,
                                height: 100,
                                builder: (context) => Icon(
                                  Icons.location_pin,
                                  size: _destinations.indexOf(point) == 0
                                      ? 36
                                      : 28,
                                  color: _destinations.indexOf(point) == 0
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.grey,
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MapNorthButton(event: _northButtonEvent),
                          Text(
                            '$_estimatedDistance  km',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14.0,
                      horizontal: 18.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                              margin: const EdgeInsets.only(bottom: 5),
                              height: 48,
                              width: 48,
                              child: IconButton(
                                onPressed: _zoomIn,
                                icon: const Icon(Icons.add),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle,
                              ),
                              height: 48,
                              width: 48,
                              child: IconButton(
                                onPressed: _zoomOut,
                                icon: const Icon(Icons.remove),
                                // iconSize: ,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          height: 48,
                          width: 48,
                          child: IconButton(
                            onPressed: _gpsButtonEvent,
                            icon: const Icon(Icons.gps_fixed),
                            color: Colors.white,
                            iconSize: 24,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const NextOrderTimelineAndDetail(
          destinationName: 'بقالی حسن آقا',
          orderTitle: 'دوغ آبعلی',
        ),
      ],
    );
  }
}
