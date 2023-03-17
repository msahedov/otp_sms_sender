import 'package:flutter/material.dart';

import 'app/routes.dart';
import '../../src/core/theme/app_theme.dart';

class OtpSenderApp extends StatelessWidget {
  const OtpSenderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Outfit', colorScheme: darkTheme),
    );
  }
}
