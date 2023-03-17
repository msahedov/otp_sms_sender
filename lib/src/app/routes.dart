import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/enum/box_types.dart';
import '../presentation/message/pages/message_list_page.dart';
import '../presentation/splash/duration_time_page.dart';
import '../presentation/splash/server_url_page.dart';
import '../presentation/home/pages/home_page.dart';

const serverUrlPage = 'server-url';
const serverUrlPagePath = '/server-url';

const timeDurationPage = 'duration-time';
const timeDurationPagePath = '/duration-time';

const landingPath = '/landing';
const landingName = 'landing';

const messagesPath = 'messages';
const messagesName = 'messages';

const viewMessageName = 'view-message';
const viewMessagePath = 'view-message/:mid';

final settings = Hive.box(BoxType.settings.stringValue);

final GoRouter goRouter = GoRouter(
  initialLocation: landingPath,
  observers: [HeroController()],
  // refreshListenable: settings.listenable(),
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: serverUrlPage,
      path: serverUrlPagePath,
      builder: (context, state) => ServerUrlPage(),
    ),
    GoRoute(
      name: timeDurationPage,
      path: timeDurationPagePath,
      builder: (context, state) => TimeDurationPage(),
    ),
    GoRoute(
        name: landingName,
        path: landingPath,
        builder: (context, state) => const LandingPage(),
        routes: [
          GoRoute(
              name: messagesName,
              path: messagesPath,
              builder: (context, state) => const MessageListPage(),
              routes: [
                GoRoute(
                  name: messagesName,
                  path: messagesPath,
                  builder: (context, state) => const MessageListPage(),
                ),
              ]),
        ]),
  ],
  errorBuilder: (context, state) => Center(
    child: Text(state.error.toString()),
  ),
  // redirect: (state) {
  //   final bool isLogging = settings.get(authStateKey, defaultValue: false);
  //   if (isLogging) {
  //     return landingPath;
  //   } else {
  //     return null;
  //   }
  // },
);
