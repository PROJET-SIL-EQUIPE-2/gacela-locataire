import 'package:flutter/material.dart';
import '../../config/theme/colors.dart';

Widget gacelaButton({
  required void Function()? onPressed,
  required String text,
  Color color = GacelaColors.gacelaBlue,
  bool showShadow = true,
  Color textColor = Colors.white,
  double radius = 35,
  double hPadding = 16,
  double vPadding = 14,
  Icon? icon,
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
          child: icon == null
              ? Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    icon,
                  ],
                ),
        ),
      ),
    );

/// For forms only
Widget gacelaTextFormField({
  String? hintText,
  String? labelText,
  String? errorText,
  TextEditingController? controller,
  TextInputType? keyboardType,
  bool obscureText = false,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
  void Function(String?)? onChanged,
  double radius = 20,
  EdgeInsetsGeometry? padding,
  int? maxLength,
}) =>
    TextFormField(
      maxLength: maxLength,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: padding,
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: GacelaColors.gacelaGrey,
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );

// Use it outside forms
Widget gacelaTextField({
  String? hintText,
  String? labelText,
  String? errorText,
  TextEditingController? controller,
  TextInputType? keyboardType,
  bool obscureText = false,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
  void Function(String?)? onChanged,
  double radius = 20,
  EdgeInsetsGeometry? padding,
  int? maxLength,
}) =>
    TextFormField(
      maxLength: maxLength,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: padding,
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: GacelaColors.gacelaGrey,
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );

Widget gacelaLinkButton({
  required String text,
  Color? color = GacelaColors.gacelaBlue,
  required void Function()? onPressed,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w300,
        ),
      ),
    );

Widget gacelaCircleButton({
  required void Function()? onPressed,
  required Widget child,
  double radius = 60,
}) =>
    GestureDetector(
      onTap: onPressed,
      child: Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 45,
              color: Colors.black.withOpacity(0.31),
            ),
          ],
        ),
        child: Center(
          child: child,
        ),
      ),
    );

Widget gacelaTextButton({
  required String text,
  Color? color = GacelaColors.gacelaDeepBlue,
  required void Function()? onPressed,
  required Icon icon, // change it to an svg ?! IDK
}) =>
    TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          icon,
        ],
      ),
    );
