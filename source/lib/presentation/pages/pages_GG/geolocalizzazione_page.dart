import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:report_it/application/entity/entity_GG/place_entity.dart';
import 'package:report_it/application/repository/marker_controller.dart';

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
    const altezzaMappa = 0.76;

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
                                height: MediaQuery.of(context).size.height *
                                    altezzaMappa,
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
                        : Container(
                            height: MediaQuery.of(context).size.height *
                                altezzaMappa,
                            color: const Color.fromRGBO(241, 243, 244, 1),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  const Text(
                                      'Ricerca edifici ospedalieri e forze dell\'ordine . . .'),
                                ],
                              ),
                            ),
                          );
                  },
                )
              : Container(
                  height: MediaQuery.of(context).size.height * altezzaMappa,
                  color: const Color.fromRGBO(241, 243, 244, 1),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        const Text('Ricerca posizione . . .'),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
