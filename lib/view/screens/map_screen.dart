import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../controllers/map_provider.dart';

import '../widgets/map_north_button.dart';
import '../widgets/next_order_timeline_and_detail.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final double _estimatedDistance = 18;

  void showDefaultSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
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

  List<LayerOptions> _mapLayers(MapProvider mapProvider) {
    print('mapLayers');
    List<LayerOptions> layers = [
      TileLayerOptions(
        minZoom: mapProvider.minMapZoom,
        maxZoom: mapProvider.maxMapZoom,
        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        subdomains: ['a', 'b', 'c'],
      ),
    ];
    print('before poly lines');
    if (mapProvider.nextOrderPath.isNotEmpty) {
      layers.add(PolylineLayerOptions(polylines: [
        Polyline(
          points: mapProvider.nextOrderPath,
          borderStrokeWidth: 2.5,
          strokeWidth: 2,
          color: Theme.of(context).colorScheme.secondary,
          borderColor: Theme.of(context).colorScheme.tertiary,
        ),
      ]));
    }
    print('after poly lines');

    final MarkerLayerOptions markerLayerOptions = MarkerLayerOptions(
      markers: [
        _truckMarker(mapProvider.myLocation),
      ],
    );

    if (mapProvider.nextOrderPath.isNotEmpty) {
      markerLayerOptions.markers.add(Marker(
        point: mapProvider.nextOrderPath.last,
        width: 100,
        height: 100,
        builder: (context) => Icon(
          Icons.location_pin,
          size: 36,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ));
    }

    layers.add(markerLayerOptions);

    return layers;
  }

  @override
  void deactivate() {
    print('deactivate');
    Provider.of<MapProvider>(context, listen: false).creatingMapController();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final MapProvider mapProvider = Provider.of<MapProvider>(context);
    print('building map screen');
    if (mapProvider.nextOrderPath.isNotEmpty) { ///important
      mapProvider.setMyFakeLocation();
    }

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              FlutterMap(
                mapController: mapProvider.mapController,
                options: MapOptions(
                  center: mapProvider.mapCenter,
                  zoom: mapProvider.zoom,
                  plugins: [
                    MarkerClusterPlugin(),
                  ],
                ),
                layers: _mapLayers(mapProvider),
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
                          MapNorthButton(
                            event: mapProvider.rotateToNorth,
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
                                onPressed: () {
                                  try {
                                    mapProvider.zoomIn();
                                  } catch (e) {
                                    showDefaultSnackBar(e.toString());
                                  }
                                },
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
                                onPressed: () {
                                  try {
                                    mapProvider.zoomOut();
                                  } catch (e) {
                                    showDefaultSnackBar(e.toString());
                                  }
                                },
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
                            onPressed: () async {
                              await mapProvider.gpsButtonEvent();
                            },
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
        Container(
          child: mapProvider.nextOrderPath.isEmpty ? null : const NextOrderTimelineAndDetail(
            destinationName: 'بقالی حسن آقا',
            orderTitle: 'دوغ آبعلی',
          ),
        ),
      ],
    );
  }
}
