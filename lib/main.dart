import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '/src/app.dart';
import '/src/service_locator.dart';
import 'src/core/http_overrides.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await Wakelock.enable();
  HttpOverrides.global = AppHttpOverrides();
  runApp(const OtpSenderApp());
}
