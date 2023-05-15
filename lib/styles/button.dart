import 'package:flutter/material.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize:  Size(350, 64),
  primary: Color.fromARGB(100, 81, 81, 81),
  elevation: 0,
  shape:  const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    )
  )
);