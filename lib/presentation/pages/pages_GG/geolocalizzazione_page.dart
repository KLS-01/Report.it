import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:report_it/domain/entity/entity_GG/place_entity.dart';
import 'package:report_it/domain/repository/marker_service.dart';

class GeolocalizzazionePage extends StatefulWidget {
  const GeolocalizzazionePage({Key? key}) : super(key: key);

  @override
  State<GeolocalizzazionePage> createState() => _GeolocalizzazionePageState();
}

class _GeolocalizzazionePageState extends State<GeolocalizzazionePage> {
  final _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var currentPositionProvider = context.watch<Position?>();
    final placesProvider = context.watch<Future<List<Place>?>?>();
    final markerService = MarkerService();

    return SafeArea(
      child: FutureProvider(
        create: (_) => placesProvider,
        initialData: null,
        child: Scaffold(
          body: (currentPositionProvider != null)
              ? Consumer<List<Place>?>(
                  builder: (_, places, __) {
                    var markers = (places != null)
                        ? markerService.getMarkers(places)
                        : <Marker>[];
                    return (places != null)
                        ? Column(
                            children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.78,
                                width: MediaQuery.of(context).size.width,
                                child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          currentPositionProvider.latitude,
                                          currentPositionProvider.longitude),
                                      zoom: 16.0),
                                  trafficEnabled: false,
                                  mapType: MapType.normal,
                                  buildingsEnabled: false,
                                  myLocationButtonEnabled: true,
                                  myLocationEnabled: true,
                                  zoomGesturesEnabled: true,
                                  zoomControlsEnabled: true,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _controller.complete(controller);
                                  },
                                  markers: Set<Marker>.of(markers),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Column(
                              children: const [
                                CircularProgressIndicator(),
                                Text('PLACES == null'),
                              ],
                            ),
                          );
                  },
                )
              : Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('CURRENT POSITION == null'),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
