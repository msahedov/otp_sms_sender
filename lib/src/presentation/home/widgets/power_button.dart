import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/enum/box_types.dart';

import '../../../service_locator.dart';

class PowerButton extends StatelessWidget {
  const PowerButton(
      {Key? key,
      required this.valueNotifier,
      required this.onFunction,
      required this.offFunction})
      : super(key: key);

  final ValueNotifier<bool> valueNotifier;
  final Function(int timerDuration, String serverUrl) onFunction;
  final Function offFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ValueListenableBuilder<bool>(
            valueListenable: valueNotifier,
            builder: (context, isPaused, child) {
              return ValueListenableBuilder<Box>(
                  valueListenable: locator
                      .get<Box<dynamic>>(
                          instanceName: BoxType.settings.stringValue)
                      .listenable(
                    keys: [serverNameKey, scheduleTimeKey],
                  ),
                  builder: (context, value, child) {
                    var serverName = value.get(serverNameKey,
                        defaultValue: 'https://parlak.com.tm/api/sms_otp_list');
                    int? scheduleTime = int.tryParse(
                        value.get(scheduleTimeKey, defaultValue: '10'));
                    return FloatingActionButton.large(
                        backgroundColor: isPaused ? Colors.green : Colors.red,
                        child: isPaused
                            ? const Icon(
                                Icons.power_settings_new,
                                size: 50,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.stop,
                                size: 50,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          if (isPaused) {
                            onFunction(scheduleTime ?? 10, serverName);
                          } else {
                            offFunction();
                          }
                        });
                  });
            }));
  }
}
