import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../config/theme/colors.dart';

Widget gacelaCard({
  Color color = GacelaColors.gacelaPurple,
  double borderRadius = 25,
  double? height,
  double? width,
  required Widget child,
  EdgeInsets padding = const EdgeInsets.all(10.0),
}) =>
    Container(
      padding: padding,
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
      ),
      child: child,
    );

Widget gacelaNotificationTile({
  bool isNew = false,
  required String title,
  required String description,
  void Function()? onTap,
}) =>
    ListTile(
      onTap: onTap,
      tileColor: isNew ? GacelaColors.gacelaLightYellow : Colors.grey[50],
      isThreeLine: true,
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: const TextStyle(fontSize: 12),
          ),
          const Text(
            "Voir details >",
            style: TextStyle(color: GacelaColors.gacelaBlue, fontSize: 12),
          )
        ],
      ),
      trailing: const Text(
        "à l'instant",
        style: TextStyle(color: GacelaColors.gacelaRed, fontSize: 12),
      ),
      leading: const Icon(Icons.error_outline_rounded),
    );
