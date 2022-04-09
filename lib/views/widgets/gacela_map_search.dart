 import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
class GacelaMapReserch extends StatelessWidget {
 /*  final String carName;
  final double distance;
  final String type;
  final double price;
  const GacelaCarListItemWidget(
      {Key? key,
      required this.carName,
      required this.distance,
      required this.type,
      required this.price})
      : super(key: key); */

  @override
  Widget build(BuildContext context) {
    double itemMargin = 10.0;
    double height = 100;
    double width = MediaQuery.of(context).size.width - itemMargin;
    double padding = 10.0;
    return 
 Positioned(
                  top: 105.0,
                  right: 15.0,
                  left: 15.0,
                  child: Container(
                    height: 50.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 5.0),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ],
                    ),
                    child: TextField(
                      cursorColor: Colors.black,
/*                       controller: appState.destinationController,
 */                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) {
/*                         appState.sendRequest(value);
 */                      },
                      decoration: InputDecoration(
                        icon: Container(
                          margin: EdgeInsets.only(left: 20, top: 5),
                          width: 10,
                          height: 10,
                          child: Icon(
                            Icons.local_taxi,
                            color: Colors.black,
                          ),
                        ),
                        hintText: "destination?",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                      ),
                    ),
                  ),
                ) ;
  }
}
