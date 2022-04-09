import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';

class GacelaCarListItemWidget extends StatelessWidget {
  final String carName;
  final double distance;
  final String type;
  final double price;
  const GacelaCarListItemWidget(
      {Key? key,
      required this.carName,
      required this.distance,
      required this.type,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double itemMargin = 10.0;
    double height = 100;
    double width = MediaQuery.of(context).size.width - itemMargin;
    double padding = 10.0;
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(itemMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: GacelaColors.gacelaLightOrange,
      ),
      child: Center(
        child: Row(
          children: [
            // Image
            Container(
              child: const Text("Image"),
              width: width / 4,
            ),

            // Description

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    carName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: GacelaColors.gacelaDeepBlue,
                    ),
                  ),
                ),

                Container(
                  width: width / 2,
                  child: Row(
                    children: [
                      // icon
                      const Icon(IconData(0xe662, fontFamily: 'MaterialIcons')),

                      // Text
                      Text("a $distance pres"),
                    ],
                  ),
                )
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    type,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: GacelaColors.gacelaBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "$price DA/h",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: GacelaColors.gacelaDeepBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
