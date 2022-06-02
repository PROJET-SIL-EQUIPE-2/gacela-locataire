import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import 'package:gacela_locataire/config/theme/theme.dart';
import 'package:gacela_locataire/models/place.dart';
import 'package:gacela_locataire/providers/course_provider.dart';
import 'package:gacela_locataire/views/screens/home/select_car_screen.dart';
import 'package:gacela_locataire/views/widgets/gacela_widgets.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const route = "/search";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode departFocus = FocusNode();
  FocusNode destinationFocus = FocusNode();

  TextEditingController departController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  final greyCircle = Container(
    height: 8,
    width: 8,
    margin: const EdgeInsets.all(3),
    decoration: const BoxDecoration(
        shape: BoxShape.circle, color: GacelaColors.gacelaGrey),
  );

  Future<void> _setPlace(Place place) async {}

  @override
  void dispose() {
    departFocus.dispose();
    destinationFocus.dispose();
    departController.dispose();
    destinationController.dispose();
    super.dispose();
  }

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
        onPressed: () async {
          final courseProivder =
              Provider.of<CourseProvider>(context, listen: false);
          if (courseProivder.departPlace != null &&
              courseProivder.destinationPlace != null) {
            await Navigator.pushNamed(context, SelectCarScreen.route);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Please choose your depart and destination",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: GacelaColors.gacelaRed,
            ));
          }
        },
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
                        controller: departController,
                        focusNode: departFocus,
                        hintText: "Votre location",
                        onChanged: (value) =>
                            Provider.of<CourseProvider>(context, listen: false)
                                .searchPlaces(value),
                      ),
                      const SizedBox(height: GacelaTheme.vDivider),
                      gacelaTextFormField(
                        controller: destinationController,
                        focusNode: destinationFocus,
                        hintText: "Où partir ?",
                        onChanged: (value) =>
                            Provider.of<CourseProvider>(context, listen: false)
                                .searchPlaces(value),
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
              onPressed: () async {
                bool isDepart;
                if (departFocus.hasFocus) {
                  isDepart = true;
                  Place place =
                      await Provider.of<CourseProvider>(context, listen: false)
                          .setCurrentLocationPlace(isDepart);

                  departController.text = place.name;
                } else if (destinationFocus.hasFocus) {
                  isDepart = false;
                  Place place =
                      await Provider.of<CourseProvider>(context, listen: false)
                          .setCurrentLocationPlace(isDepart);

                  destinationController.text = place.name;
                }
              },
              icon: const Icon(Icons.location_searching_outlined),
              label: const Text(
                "Use my current location",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Consumer<CourseProvider>(
              builder: (context, courseProvider, _) {
                return ListView.builder(
                  itemCount: courseProvider.searchResult.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                        courseProvider.searchResult[index].description ?? ""),
                    onTap: () async {
                      bool isDepart;
                      if (departFocus.hasFocus) {
                        isDepart = true;
                        Place place = await courseProvider.getPlaceDetails(
                            courseProvider.searchResult[index].placeId!,
                            isDepart);
                        departController.text = place.name;
                      } else if (destinationFocus.hasFocus) {
                        isDepart = false;
                        Place place = await courseProvider.getPlaceDetails(
                            courseProvider.searchResult[index].placeId!,
                            isDepart);
                        destinationController.text = place.name;
                      }
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
