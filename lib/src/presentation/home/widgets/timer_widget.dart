import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class TimerWidget extends StatelessWidget {
  TimerWidget({Key? key, required this.valueNotifier, required this.isPaused})
      : super(key: key);
  final ValueNotifier<bool> isPaused;
  final ValueNotifier<int> valueNotifier;
  int seconds = 0, minutes = 0, hours = 0;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: valueNotifier,
        builder: (context, value, child) {
          seconds = value % 60;
          minutes = value ~/ 60;
          hours = value ~/ 3600;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder<bool>(
                    valueListenable: isPaused,
                    builder: (context, value, child) {
                      return Text(value ? 'Disconnected' : 'Connected',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: darkOnSurface.withOpacity(0.85),
                                  ));
                    }),
                const SizedBox(height: 8),
                Text(
                  hours.toString().padLeft(2, '0') +
                      ":" +
                      minutes.toString().padLeft(2, '0') +
                      ":" +
                      seconds.toString().padLeft(2, '0'),
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: darkOnSurface,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          );
        });
  }
}
