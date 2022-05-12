import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import 'package:gacela_locataire/config/theme/theme.dart';
import 'package:gacela_locataire/models/errors/failure.dart';
import 'package:gacela_locataire/models/services/course_service.dart';
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

  @override
  Widget build(BuildContext context) {
    Future createReservation() async {
      try {
        await Provider.of<CourseProvider>(context, listen: false)
            .createReservation(
                Provider.of<AuthProvider>(context, listen: false).token,
                Provider.of<AuthProvider>(context, listen: false).user?.email,
                "20012001");
        await Navigator.pushNamedAndRemoveUntil(
            context, CourseScreen.route, ModalRoute.withName('/search'));
      } on Failure catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(36.35, 6.6),
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
                        "Véhicules proches de vous",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    const SizedBox(height: GacelaTheme.vDivider * 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GacelaTheme.hPadding),
                      child: Column(
                        children: [
                          GacelaCarCard(
                            carName: "Hyundai Accent",
                            imageUrl: "",
                            price: 200,
                            time: "à 1 min près",
                            type: "classic",
                            onTap: () async {
                              setState(() {
                                _showResults = false;
                                _requested = true;
                              });
                              // await _requestCar(appcontext);
                            },
                          ),
                        ],
                      ),
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
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(GacelaTheme.hPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hyundai accent",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        color: GacelaColors.gacelaDeepBlue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.camera_outlined),
                                    Text("0234 5678 8939 16"),
                                  ],
                                )
                              ],
                            ),
                            Image.asset("assets/images/hyunday.png"),
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
                            const SizedBox(height: GacelaTheme.vDivider),
                            Text(
                              "Attributs",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    color: GacelaColors.gacelaDeepBlue,
                                  ),
                            ),
                            const SizedBox(height: GacelaTheme.vDivider),
                            Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: GacelaColors.gacelaDeepBlue,
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
                                          color: GacelaColors.gacelaDeepBlue,
                                        ),
                                  ),
                                  Text(
                                    "5",
                                    style:
                                        Theme.of(context).textTheme.headline4,
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
                                    "120 DA",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                          color: GacelaColors.gacelaDeepBlue,
                                        ),
                                  ),
                                  gacelaButton(
                                    onPressed: createReservation,
                                    text: "Appeler",
                                    color: GacelaColors.gacelaDeepBlue,
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
        ],
      ),
    );
  }
}

class GacelaCarCard extends StatelessWidget {
  final String imageUrl;
  final String carName;
  final String time;
  final String type;
  final double price;
  final void Function()? onTap;

  const GacelaCarCard({
    Key? key,
    required this.imageUrl,
    required this.carName,
    required this.time,
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
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: GacelaColors.gacelaGrey,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          time,
                          style: const TextStyle(
                            color: GacelaColors.gacelaGrey,
                          ),
                        ),
                      ],
                    ),
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
                  text: "$price DA",
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
