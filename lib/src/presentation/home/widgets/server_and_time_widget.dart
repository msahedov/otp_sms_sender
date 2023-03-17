import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/enum/box_types.dart';
import '../../../presentation/home/widgets/settings_change_widget.dart';
import '../../../service_locator.dart';

class ServerAndTimeWidget extends StatelessWidget {
  const ServerAndTimeWidget({Key? key, required this.valueNotifier})
      : super(key: key);

  final ValueNotifier<bool> valueNotifier;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: locator
          .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
          .listenable(
        keys: [serverNameKey, scheduleTimeKey],
      ),
      builder: (context, value, child) {
        var serverName = value.get(serverNameKey,
            defaultValue: 'https://parlak.com.tm/api/sms_otp_list');
        var scheduleTime = value.get(scheduleTimeKey, defaultValue: '10');
        return ValueListenableBuilder<bool>(
            valueListenable: valueNotifier,
            builder: (context, isPaused, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListTile(
                      enabled: isPaused,
                      onTap: () => showModalBottomSheet(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width >= 700
                              ? 700
                              : double.infinity,
                        ),
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        context: context,
                        builder: (_) => const SettingsChangeWidget(),
                      ),
                      title: const Text('Server'),
                      subtitle:
                          Text(serverName, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      enabled: isPaused,
                      onTap: () => showModalBottomSheet(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width >= 700
                              ? 700
                              : double.infinity,
                        ),
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        context: context,
                        builder: (_) =>
                            const SettingsChangeWidget(changeIsSchedule: true),
                      ),
                      title: const Text('Duration', textAlign: TextAlign.end),
                      subtitle: Text('$scheduleTime', textAlign: TextAlign.end),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}
