import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gacela_locataire/models/errors/failure.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import 'package:gacela_locataire/providers/car_data_collector.dart';
import 'package:gacela_locataire/providers/course_provider.dart';
import 'package:gacela_locataire/views/screens/auth/thanks_screen.dart';
import 'package:gacela_locataire/views/screens/home/course/thanks_screen.dart';
import 'package:gacela_locataire/views/screens/home/course/track_car_screen.dart';
import 'package:gacela_locataire/views/screens/home/home_screen.dart';
import 'package:gacela_locataire/views/screens/home/support/support_screen.dart';
import 'package:gacela_locataire/views/screens/navigators.dart';
import 'package:gacela_locataire/views/widgets/gacela_course.dart';
import 'package:provider/provider.dart';
import '../../../../providers/payment_provider.dart';
import '../../../widgets.dart';
import '../../../../config/theme/colors.dart';
import '../../../../config/theme/theme.dart';

class CourseScreen extends StatefulWidget {
  static const route = "/course";
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  String? code;
  bool isLoading = false;

  void reservationFinished() async {
    CourseProvider courseProvider = Provider.of<CourseProvider>(context);
    if (Provider.of<CarsDataCollector>(context).finished) {
      courseProvider.closestVehicule = null;
      courseProvider.currentReservation = null;
      courseProvider.isUnlocked = false;
      courseProvider.isPayed = false;

      await Navigator.pushReplacementNamed(context, ThanksCourseScreen.route);
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CarsDataCollector>(context, listen: false).connect(
        Provider.of<AuthProvider>(context, listen: false).user?.id,
        Provider.of<CourseProvider>(context, listen: false)
            .currentReservation
            ?.vehiculeId);
  }

  _unlockDialog() async {
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
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
                    "Write the code to unlock",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                const SizedBox(height: GacelaTheme.vDivider * 2),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: GacelaTheme.hPadding),
                  child: Column(
                    children: [
                      gacelaTextField(
                        hintText: "Code",
                        onChanged: (value) => code = value,
                      ),
                      const SizedBox(height: GacelaTheme.vDivider * 2),
                      gacelaButton(
                        onPressed: _unlockCar,
                        text: "Unlock",
                      ),
                      const SizedBox(height: GacelaTheme.vDivider * 2),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  _unlockCar() async {
    Navigator.pop(context);
    setState(() => isLoading = true);
    try {
      await Provider.of<CourseProvider>(context, listen: false).unlockCar(
          Provider.of<AuthProvider>(context, listen: false).token,
          Provider.of<CourseProvider>(context, listen: false)
              .currentReservation
              ?.reservationId,
          code);
      // await Future.delayed(const Duration(seconds: 2));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "car unlocked",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: GacelaColors.gacelaGreen,
      ));
    } on Failure catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: GacelaColors.gacelaRed,
      ));
    }
    setState(() => isLoading = false);
  }

  Future<void> _showQuitCourseDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to quit the course ?'),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(color: GacelaColors.gacelaRed),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();
                await HomeNavigator.homeNavigatorKey.currentState!
                    .pushReplacementNamed(HomeScreen.route);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _systemBackButtonPressed() async {
    if (HomeNavigator.homeNavigatorKey.currentState!.canPop()) {
      await _showQuitCourseDialog();
    } else {
      await _showQuitCourseDialog();
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Course",
            style: Theme.of(context).textTheme.headline2,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () async => await _showQuitCourseDialog(),
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(
                Icons.support_agent_outlined,
                color: Colors.black,
              ),
              label:
                  const Text("Support", style: TextStyle(color: Colors.black)),
              onPressed: () async =>
                  await Navigator.of(context).pushNamed(SupportScreen.route),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: GacelaTheme.hPadding),
                child: Consumer<CourseProvider>(
                  builder: (context, provider, _) {
                    reservationFinished();
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: GacelaTheme.vDivider + 10,
                              top: GacelaTheme.hPadding - 2),
                        ),
                        gacelaDetails(
                            title: "Gacela Car",
                            img: Image.asset("assets/images/hyunday.png"),
                            type: "${provider.currentReservation?.etat}",
                            text1: "${provider.closestVehicule?.matricule}",
                            text2:
                                "Identifiant: #${provider.currentReservation?.reservationId}"),
                        const SizedBox(height: GacelaTheme.vDivider + 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            gacelaCard(
                              color: GacelaColors.gacelaBlueGray,
                              width: screenSize.width * 0.4,
                              height: screenSize.width * 0.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Estimation vers",
                                    style: TextStyle(
                                        color: GacelaColors.gacelaDeepBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: 'popins'),
                                  ),
                                  Text(
                                    "${provider.destinationPlace?.name}",
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "${provider.closestVehicule?.estimatedPrice?.toStringAsFixed(2)} DA",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async => await Navigator.pushNamed(
                                  context, TrackCarScreen.route),
                              child: gacelaCard(
                                color: GacelaColors.gacelaDeepPink,
                                width: screenSize.width * 0.4,
                                height: screenSize.width * 0.4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 35,
                                    ),
                                    SizedBox(height: GacelaTheme.vDivider - 4),
                                    Text(
                                      "suivre votre voiture",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: GacelaTheme.vDivider + 10),
                        Consumer<CourseProvider>(
                            builder: (context, provider, _) {
                          if (!provider.isPayed) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: gacelaButton1(
                                onPressed: provider.makePayment,
                                text: "Payment",
                                img: Image.asset(
                                  "assets/images/edahabia.png",
                                  height: 20,
                                  width: 60,
                                ),
                                color: GacelaColors.gacelaGrey,
                              ),
                            );
                          } else {
                            return Column(
                              children: const [
                                Text(
                                  "Your reservation is payed",
                                  style: TextStyle(
                                    color: GacelaColors.gacelaGreen,
                                  ),
                                ),
                                Text(
                                    "Our car is in way to you, remember to unlock the car")
                              ],
                            );
                          }
                        }),
                        const SizedBox(height: GacelaTheme.vDivider + 10),
                        Consumer<CourseProvider>(
                          builder: (_, course, __) => course.isUnlocked
                              ? Column(
                                  children: [
                                    const Center(
                                        child: Icon(
                                      Icons.lock_open,
                                      size: 40,
                                    )),
                                    const SizedBox(
                                        height: GacelaTheme.vDivider),
                                    Text(
                                      "La voiture est ouverte vous pouvez monter",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                            color: GacelaColors.gacelaGreen,
                                          ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    const Center(
                                        child: Icon(
                                      Icons.lock,
                                      size: 40,
                                    )),
                                    const SizedBox(
                                        height: GacelaTheme.vDivider),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: gacelaButton(
                                        onPressed: _unlockDialog,
                                        text: "Débloquer",
                                        icon: const Icon(
                                          Icons.lock_open_outlined,
                                        ),
                                        // IconData(0xe3b0, fontFamily: 'MaterialIcons'),
                                        color: GacelaColors.gacelaDeepBlue,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              if (isLoading)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.2),
                    alignment: Alignment.center,
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25)),
                        child: const CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
