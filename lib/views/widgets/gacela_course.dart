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
