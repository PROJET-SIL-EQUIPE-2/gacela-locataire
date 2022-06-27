import 'package:flutter/material.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import 'package:gacela_locataire/providers/car_data_collector.dart';
import 'package:gacela_locataire/providers/course_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../widgets/gacela_widgets.dart';

class TrackCarScreen extends StatefulWidget {
  static const route = "/course/tracking";
  const TrackCarScreen({Key? key}) : super(key: key);

  @override
  State<TrackCarScreen> createState() => _TrackCarScreenState();
}

class _TrackCarScreenState extends State<TrackCarScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CarsDataCollector>(
        builder: (context, carsDataCollector, _) {
      Polyline polyline =
          Polyline(polylineId: const PolylineId('polyline'), points: [
        LatLng(Provider.of<CourseProvider>(context).currentLocation!.latitude,
            Provider.of<CourseProvider>(context).currentLocation!.longitude),
        LatLng(carsDataCollector.lat!, carsDataCollector.long!)
      ]);
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                onMapCreated: (controller) =>
                    carsDataCollector.controller = controller,
                markers: {
                  if (carsDataCollector.lat != null &&
                      carsDataCollector.long != null)
                    Marker(
                        markerId: const MarkerId("car"),
                        visible: true,
                        position: LatLng(
                            carsDataCollector.lat!, carsDataCollector.long!)),
                  if (Provider.of<CourseProvider>(context)
                              .currentLocation
                              ?.latitude !=
                          null &&
                      Provider.of<CourseProvider>(context)
                              .currentLocation
                              ?.longitude !=
                          null)
                    Marker(
                        markerId: const MarkerId("user"),
                        visible: true,
                        position: LatLng(
                            Provider.of<CourseProvider>(context)
                                .currentLocation!
                                .latitude,
                            Provider.of<CourseProvider>(context)
                                .currentLocation!
                                .longitude))
                },
                polylines: {polyline},
                initialCameraPosition: const CameraPosition(
                  target: LatLng(36.35, 6.6),
                  zoom: 14,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GacelaIconButton(
                child: const Center(
                    child: Icon(
                  Icons.arrow_back_ios,
                )),
                onTap: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      );
    });
  }
}
