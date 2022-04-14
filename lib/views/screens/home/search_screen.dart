import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import 'package:gacela_locataire/config/theme/theme.dart';
import 'package:gacela_locataire/views/screens/home/select_car_screen.dart';
import 'package:gacela_locataire/views/widgets/gacela_widgets.dart';

class SearchScreen extends StatefulWidget {
  static const route = "/search";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final greyCircle = Container(
    height: 8,
    width: 8,
    margin: const EdgeInsets.all(3),
    decoration: const BoxDecoration(
        shape: BoxShape.circle, color: GacelaColors.gacelaGrey),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Choisissez votre trajet",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, SelectCarScreen.route),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
        backgroundColor: GacelaColors.gacelaGreen,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(GacelaTheme.hPadding),
            child: Form(
                child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Icon(
                      Icons.circle_outlined,
                      color: GacelaColors.gacelaBlue,
                      size: 20,
                    ),
                    greyCircle,
                    greyCircle,
                    greyCircle,
                    greyCircle,
                    const Icon(
                      Icons.location_on_outlined,
                      color: GacelaColors.gacelaRed,
                      size: 30,
                    ),
                  ],
                ),
                const SizedBox(width: GacelaTheme.hPadding),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      gacelaTextFormField(
                        hintText: "Votre location",
                      ),
                      const SizedBox(height: GacelaTheme.vDivider),
                      gacelaTextFormField(
                        hintText: "Où partir ?",
                      ),
                    ],
                  ),
                )
              ],
            )),
          ),
          const Divider(height: 1),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.location_searching_outlined),
              label: const Text(
                "Use my current location",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
