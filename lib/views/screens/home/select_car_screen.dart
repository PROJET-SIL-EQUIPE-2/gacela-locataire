import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import 'package:gacela_locataire/config/theme/theme.dart';
import 'package:gacela_locataire/models/errors/failure.dart';
import 'package:gacela_locataire/models/services/course_service.dart';
import 'package:gacela_locataire/models/vehicule_type.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import 'package:gacela_locataire/providers/course_provider.dart';
import 'package:gacela_locataire/views/screens/home/course/course_screen.dart';
import 'package:gacela_locataire/views/widgets.dart';
import 'package:gacela_locataire/views/widgets/gacela_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SelectCarScreen extends StatefulWidget {
  static const route = "/search/select";
  const SelectCarScreen({Key? key}) : super(key: key);

  @override
  State<SelectCarScreen> createState() => _SelectCarScreenState();
}

class _SelectCarScreenState extends State<SelectCarScreen> {
  bool isLoading = false;

  bool _requested = false;
  bool _showResults = true;

  String? errorMessage;

  bool reservationLoading = false;

  @override
  Widget build(BuildContext context) {
    Future createReservation() async {
      setState(() {
        reservationLoading = true;
      });
      try {
        await Provider.of<CourseProvider>(context, listen: false)
            .createReservation(
                Provider.of<AuthProvider>(context, listen: false).token,
                Provider.of<AuthProvider>(context, listen: false).user?.email,
                Provider.of<CourseProvider>(context, listen: false)
                    .closestVehicule
                    ?.matricule);
        await Navigator.pushNamedAndRemoveUntil(
            context, CourseScreen.route, ModalRoute.withName('/search'));
      } on Failure catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
      setState(() {
        reservationLoading = false;
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Consumer<CourseProvider>(
                builder: (context, provider, child) => GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          provider.departPlace!.geometry.location.lat,
                          provider.departPlace!.geometry.location.lng),
                      zoom: 9),
                  markers: {
                    if (provider.departPlace != null)
                      Marker(
                          markerId: const MarkerId('depart'),
                          position: LatLng(
                              provider.departPlace!.geometry.location.lat,
                              provider.departPlace!.geometry.location.lng)),
                    if (provider.destinationPlace != null)
                      Marker(
                          markerId: const MarkerId('dest'),
                          position: LatLng(
                              provider.destinationPlace!.geometry.location.lat,
                              provider
                                  .destinationPlace!.geometry.location.lng)),
                  },
                  polylines: {
                    Polyline(polylineId: const PolylineId('polyline'), points: [
                      LatLng(provider.departPlace!.geometry.location.lat,
                          provider.departPlace!.geometry.location.lng),
                      LatLng(provider.destinationPlace!.geometry.location.lat,
                          provider.destinationPlace!.geometry.location.lng)
                    ])
                  },
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
          if (_showResults)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                padding: const EdgeInsets.only(top: GacelaTheme.vPadding),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Wrap(
                  children: [
                    Center(
                      child: Text(
                        "Choose the type of the vehicule",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    const SizedBox(height: GacelaTheme.vDivider * 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GacelaTheme.hPadding),
                      child: FutureBuilder(
                          future: Provider.of<CourseProvider>(context,
                                  listen: false)
                              .getVehiculeTypes(),
                          builder: ((context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Text(
                                snapshot.error.toString(),
                                style: const TextStyle(
                                    color: GacelaColors.gacelaRed),
                              );
                            }
                            List<VehiculeType> types =
                                snapshot.data as List<VehiculeType>;
                            return Column(
                              children: types
                                  .map(
                                    (vehiculeType) => GacelaCarCard(
                                      carName: "Gacela Car",
                                      imageUrl: "",
                                      price: vehiculeType.pricePerHour!,
                                      type: vehiculeType.type!,
                                      onTap: () async {
                                        setState(() {
                                          _showResults = false;
                                          _requested = true;
                                          isLoading = true;
                                        });
                                        try {
                                          await Provider.of<CourseProvider>(
                                                  context,
                                                  listen: false)
                                              .searchClosestVehicule(
                                                  vehiculeType.type!);
                                        } on Failure catch (f) {
                                          errorMessage = f.toString();
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                            );
                          })),
                    )
                  ],
                ),
              ),
            ),
          if (_requested)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  padding: const EdgeInsets.only(top: GacelaTheme.vPadding),
                  decoration: const BoxDecoration(
                      color: GacelaColors.gacelaOrange,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: isLoading
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Searching for a car...",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                              const SizedBox(height: GacelaTheme.vDivider),
                              Text(
                                "Depart: ${Provider.of<CourseProvider>(context).departPlace?.name}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Destination: ${Provider.of<CourseProvider>(context).destinationPlace?.name}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: GacelaTheme.vDivider),
                              const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                            ],
                          ),
                        )
                      : errorMessage != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    )),
                                child: Text(
                                  errorMessage!,
                                  style: const TextStyle(
                                      color: GacelaColors.gacelaRed),
                                ),
                              ),
                            )
                          : Consumer<CourseProvider>(
                              builder: (context, provider, child) => Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        GacelaTheme.hPadding),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Hyundai accent",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3!
                                                  .copyWith(
                                                    color: GacelaColors
                                                        .gacelaDeepBlue,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.camera_outlined),
                                                Text(
                                                    " ${provider.closestVehicule?.matricule}"),
                                              ],
                                            )
                                          ],
                                        ),
                                        Image.asset(
                                            "assets/images/hyunday.png"),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                            height: GacelaTheme.vDivider),
                                        Text(
                                          "Attributs",
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3!
                                              .copyWith(
                                                color:
                                                    GacelaColors.gacelaDeepBlue,
                                              ),
                                        ),
                                        const SizedBox(
                                            height: GacelaTheme.vDivider),
                                        Container(
                                          padding: const EdgeInsets.all(18),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                color:
                                                    GacelaColors.gacelaDeepBlue,
                                                width: 1),
                                          ),
                                          child: Column(
                                            children: [
                                              const Icon(
                                                Icons.chair,
                                                size: 35,
                                              ),
                                              Text(
                                                "Places",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(
                                                      color: GacelaColors
                                                          .gacelaDeepBlue,
                                                    ),
                                              ),
                                              Text(
                                                "5",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: GacelaTheme.hPadding,
                                              vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${provider.closestVehicule?.estimatedPrice?.toStringAsFixed(2)} DA",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2!
                                                    .copyWith(
                                                      color: GacelaColors
                                                          .gacelaDeepBlue,
                                                    ),
                                              ),
                                              gacelaButton(
                                                onPressed: createReservation,
                                                text: "Appeler",
                                                color:
                                                    GacelaColors.gacelaDeepBlue,
                                                vPadding: 8,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
            ),
          if (reservationLoading)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black26,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 8),
                    Text(
                      "Loading...",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class GacelaCarCard extends StatelessWidget {
  final String imageUrl;
  final String carName;
  final String type;
  final int price;
  final void Function()? onTap;

  const GacelaCarCard({
    Key? key,
    required this.imageUrl,
    required this.carName,
    required this.type,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: GacelaColors.gacelaLightYellow,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset("assets/images/hyunday.png"),
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(carName),
                    const SizedBox(height: 8),
                    Text(
                      "self driving car",
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                gacelaButton(
                  onPressed: null,
                  text: type,
                  fontSize: 12,
                  hPadding: 6,
                  vPadding: 3,
                ),
                const SizedBox(height: 8),
                gacelaButton(
                  onPressed: null,
                  text: "$price DA/h",
                  fontSize: 12,
                  hPadding: 6,
                  vPadding: 3,
                  color: Colors.black,
                  textColor: Colors.white,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
