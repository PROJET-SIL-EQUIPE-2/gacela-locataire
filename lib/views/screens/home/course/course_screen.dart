import 'package:flutter/material.dart';

import 'package:gacela_locataire/views/widgets/gacela_course.dart';
import '../../../widgets.dart';
import '../../../../config/theme/colors.dart';
import '../../../../config/theme/theme.dart';
import '../../../widgets/gacela_course.dart';

class CourseScreen extends StatelessWidget {
  static const route = "/course";
  const CourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Courses",
          style: Theme.of(context).textTheme.headline2,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: GacelaTheme.vDivider + 10,
                    top: GacelaTheme.hPadding - 2),
              ),
              gacelaDetails(
                  title: "HyundayAccent",
                  img: Image.asset("assets/images/hyunday.png"),
                  type: "confortable",
                  text1: "0234567895542",
                  text2: "120 DA/h"),
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
                      children: const [
                        Text(
                          "Estimation vers",
                          style: TextStyle(
                              color: GacelaColors.gacelaDeepBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'popins'),
                        ),
                        Text(
                          "Oued smar",
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "100 DA",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  gacelaCard(
                    color: GacelaColors.gacelaBlueGray,
                    width: screenSize.width * 0.4,
                    height: screenSize.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: GacelaTheme.vDivider + 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: gacelaButton1(
                  onPressed: () => _paimentPressed(context),
                  text: "Méthode paiment..........5842",
                  img: Image.asset(
                    "assets/images/edahabia.png",
                    height: 20,
                    width: 60,
                  ),
                  color: GacelaColors.gacelaGrey,
                ),
              ),
              const SizedBox(height: GacelaTheme.vDivider + 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: gacelaButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Expanded(
                          child: Text(
                        'Voulez-vous prendre d\'autres courses?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      )),
                      actions: <Widget>[
                        TextButton(
                            child: Text("Non".toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.only(left: 15, right: 15)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        GacelaColors.gacelaBlueGray),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: const BorderSide(
                                            color: GacelaColors.gacelaBlueGray)))),
                            // ignore: avoid_returning_null_for_void
                            onPressed: () => null),
                        TextButton(
                            child: Text("Oui".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.only(left: 15, right: 15)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        GacelaColors.gacelaDeepBlue),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: const BorderSide(
                                            color: GacelaColors.gacelaDeepBlue)))),
                            // ignore: avoid_returning_null_for_void
                            onPressed: () => null),
                      ],
                    ),
                  ),
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
      ),
    );
  }

  void _paimentPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xFF737373),
            height: 260,
            child: Container(
              child: _buildColumn(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          );
        });
  }

  Column _buildColumn() {
    return Column(
      children: <Widget>[
        // ignore: avoid_unnecessary_containers
        Container(
          margin: const EdgeInsets.only(top: GacelaTheme.vDivider / 2),
          child: const Text(
            "Méthode de paiment",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Container(
          // ignore: unnecessary_new
          decoration: new BoxDecoration(
            color: GacelaColors.gacelaGreyClair,
            borderRadius: BorderRadius.circular(18),
          ),

          child: ListTile(
            leading: Image.asset(
              "assets/images/edahabia.png",
              height: 20,
              width: 60,
            ),
            title: const Text("............5841 2587"),
            onTap: () {},
          ),
        ),

        Container(
          // ignore: unnecessary_new
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: GacelaColors.gacelaGreyClair,
            borderRadius: BorderRadius.circular(18),
          ),

          child: ListTile(
            leading: Image.asset(
              "assets/images/mob.png",
              height: 40,
              width: 80,
            ),
            title: const Text("  Baridi mob"),
            onTap: () {},
          ),
        ),
        Container(
          // ignore: unnecessary_new
          decoration: new BoxDecoration(
            color: GacelaColors.gacelaGreyClair,
            borderRadius: BorderRadius.circular(18),
          ),

          child: ListTile(
            leading: Image.asset(
              "assets/images/visa.png",
              height: 20,
              width: 60,
            ),
            title: const Text("............5841 2587"),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
