import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:report_it/application/entity/entity_GG/place_entity.dart';
import 'package:report_it/application/repository/geolocator_controller.dart';
import 'package:report_it/application/repository/places_controller.dart';
import 'package:report_it/presentation/pages/pages_GG/geolocalizzazione_page.dart';

class GeolocalizationProvider extends StatefulWidget {
  const GeolocalizationProvider({super.key});

  @override
  State<GeolocalizationProvider> createState() =>
      _GeolocalizationProviderState();
}

class _GeolocalizationProviderState extends State<GeolocalizationProvider> {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<Position?>(
          initialData: null,
          create: (_) {
            return locatorService.getLocation();
          },
        ),
        FutureProvider<List<BitmapDescriptor?>?>(
          initialData: null,
          create: (_) async {
            print('Inizializza bitmap descriptor');
            ImageConfiguration configuration =
                createLocalImageConfiguration(context);
            var listBitmapDescriptor = <BitmapDescriptor>[];
            listBitmapDescriptor.add(await BitmapDescriptor.fromAssetImage(
                configuration, 'assets/images/hospital_marker.png'));
            listBitmapDescriptor.add(await BitmapDescriptor.fromAssetImage(
                configuration, 'assets/images/police_marker.png'));
            return listBitmapDescriptor;
          },
        ),
        ProxyProvider2<Position?, List<BitmapDescriptor?>?,
            Future<List<Place>?>?>(
          update: (_, position, iconList, places) async {
            if (position != null && iconList != null) {
              return placesService.getPlaces(
                  position.latitude, position.longitude, iconList);
            }
            return null;
          },
        ),
      ],
      child: GeolocalizzazionePage(),
    );
  }
}
