import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/colors.dart';

Widget gacelaDetails({
  required String title,
  required Image img,
  required String type,
  required String text1,
  required String text2,
  double radius = 20,
}) =>
    Container(
        margin: const EdgeInsets.only(left: 3, right: 3, top: 10),
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          color: GacelaColors.gacelaPink,
          borderRadius: BorderRadius.circular(radius),
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            // ignore: prefer_const_constructors
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              color: GacelaColors.gacelaPink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: GacelaColors.gacelaPink,
                    child: img,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: avoid_unnecessary_containers
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        title,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: GacelaColors.gacelaDeepBlue,
                            fontFamily: 'popins'),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 10),
                      padding: const EdgeInsets.only(left: 20),
                      // ignore: prefer_const_constructors
                      decoration: BoxDecoration(
                        color: GacelaColors.gacelaDeepPink,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(36)),
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          // ignore: prefer_const_constructors
                          BoxShadow(
                            color: GacelaColors.gacelaPink,
                            blurRadius: 4,
                            // ignore: prefer_const_constructors
                            offset: Offset(4, 4), // Shadow position
                          ),
                        ],
                      ),
                      width: 100,

                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              type,
                              // ignore: prefer_const_constructors
                              style: TextStyle(

                                  //     fontSize: 17,
                                  color: Colors.white,
                                  fontFamily: 'popins'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.shutter_speed_outlined,
                            color: GacelaColors.gacelaDeepBlue,
                          ),
                          Text(
                            text1,
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                //        fontSize: 17,
                                color: GacelaColors.gacelaDeepBlue,
                                fontFamily: 'popins'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        text2,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            color: GacelaColors.gacelaDeepBlue,
                            fontFamily: 'popins'),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ));
Widget gacelaNotificationTile1({
  bool isNew = false,
  required String description,
  void Function()? onTap,
}) =>
    ListTile(
      onTap: onTap,
      tileColor: isNew ? GacelaColors.gacelaGrey : Colors.grey,
      isThreeLine: true,

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),

      // ignore: prefer_const_constructors
      leading: Icon(Icons.error_outline_rounded),
    );
Widget gacelaButton2({
  required void Function()? onPressed,
  required String text,
  Color color = GacelaColors.gacelaBlue,
  bool showShadow = true,
  Color textColor = Colors.white,
  double radius = 15,
  double hPadding = 16,
  double vPadding = 14,
  Image? img,
  double fontSize = 10,
}) =>
    GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.34),
                    offset: const Offset(1, 4),
                    blurRadius: 30.0,
                  )
                ]
              : null,
        ),
        child: Center(
          child: img == null
              ? Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    img,
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
