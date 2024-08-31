import 'dart:async';

import 'package:flutter/material.dart';

import 'package:my_new_app/MyApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: WelcomePage()));
}

String getDeviceType() {
  String device_type = "";
  Orientation currentOrientation =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).orientation;
  if (currentOrientation == Orientation.portrait) {
    var width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

    if (width > 510) {
      device_type = "tablet";
    } else {
      device_type = "phone";
    }
  } else {
    var height =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;

    if (height > 510) {
      device_type = "tablet";
    } else {
      device_type = "phone";
    }
  }
  print("jdfkgjgd;gdgj 4device  $device_type");
  return "device_type";
}
