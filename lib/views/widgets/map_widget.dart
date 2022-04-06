import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/theme/colors.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: GacelaColors.gacelaOrange,
    );
  }
}
