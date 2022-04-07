import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

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

  Marker myLocationMarker = Marker(
    point: LatLng(29.64, 52.48),
    width: 100,
    height: 100,
    builder: (context) => Image.asset('assets/images/delivery_truck_24_24.png'),
  );

  List<Marker> _destinationsMarkers = [];

  void _zoomIn() {
    if (_zoom < _maxMapZoom) {
      _zoom += 1;
      _mapController.move(_mapCenter, _zoom);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('نقشه در بزرگترین حالت است.'),
        ),
      );
    }
  }

  void _zoomOut() {
    if (_zoom > _minMapZoom) {
      _zoom -= 1;
      _mapController.move(_mapCenter, _zoom);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('نقشه در کوچکترین حالت است.'),
        ),
      );
    }
  }

  void _gpsButtonEvent() {
    print('gps button clicked');
    double d = _mapController.rotation;
    _mapController.rotate(d);
  }

  void _northButtonEvent() {
    print('north button pressed');
  }

  @override
  void initState() {
    _destinationsMarkers = [LatLng(29.64, 52.492)]
        .map((point) => Marker(
              point: point,
              width: 100,
              height: 100,
              builder: (context) => const Icon(
                Icons.location_pin,
                size: 36,
                color: Colors.blueAccent,
              ),
            ))
        .toList();
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
                  // swPanBoundary: LatLng(13, 77.5),
                  // nePanBoundary: LatLng(13.07001, 77.58),
                  center: _mapCenter,
                  // bounds: LatLngBounds.fromPoints(_latLngList),
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
                  MarkerLayerOptions(
                    markers: [
                      myLocationMarker,
                      ..._destinationsMarkers,
                    ],
                  )
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
                          SizedBox.fromSize(
                            // set button size
                            size: const Size(44, 44),
                            child: ClipOval(
                              // make button shape circle
                              child: Material(
                                color: Theme.of(context).colorScheme.secondary,
                                child: InkWell(
                                  onTap: _northButtonEvent,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.navigation_outlined,
                                        size: 18,
                                        color: Colors.white,
                                      ), // icon
                                      Text(
                                        'N',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
      ],
    );
  }
}
