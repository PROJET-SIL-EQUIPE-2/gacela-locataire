import 'package:flutter/material.dart';

ElevatedButton gacelaButton({
  required void Function()? onPressed,
  required Widget? child,
}) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: child,
      onPressed: onPressed,
    );
