import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gacela_locataire/views/widgets/gacela_course.dart';
import '../../../widgets.dart';
import '../../../../config/theme/colors.dart';
import '../../../../config/theme/theme.dart';
import '../../../../config/theme/theme.dart';

class CourseScreen extends StatelessWidget {
  static const route = "/course";
  const CourseScreen({Key? key}) : super(key: key);

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
                  onPressed: () {},
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
                  onPressed: () {},
                  text: "Débloquer",

                  icon: Icon(
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
}
