import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../core/constants.dart';
import '../../../core/enum/box_types.dart';
import '../../../service_locator.dart';

class SettingsChangeWidget extends StatefulWidget {
  final bool changeIsSchedule;
  const SettingsChangeWidget({Key? key, this.changeIsSchedule = false})
      : super(key: key);

  @override
  State<SettingsChangeWidget> createState() => _SettingsChangeWidgetState();
}

class _SettingsChangeWidgetState extends State<SettingsChangeWidget> {
  final settingsFieldController = TextEditingController();
  final settings =
      locator.get<Box<dynamic>>(instanceName: BoxType.settings.stringValue);

  void _updateDetails() {
    settings
        .put(widget.changeIsSchedule ? scheduleTimeKey : serverNameKey,
            settingsFieldController.text)
        .then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SafeArea(
        child: Material(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  widget.changeIsSchedule ? 'Duration' : 'Server',
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  widget.changeIsSchedule
                      ? 'Set repeat duration for request'
                      : 'Set the listening url',
                ),
                trailing: const CloseButton(),
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                        apptextFieldController: settingsFieldController,
                        changeIsSchedule: widget.changeIsSchedule),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: _updateDetails,
                  child: const Text(
                    'Save',
                  ),
                ),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController apptextFieldController;
  final bool changeIsSchedule;
  const AppTextField(
      {Key? key,
      required this.apptextFieldController,
      required this.changeIsSchedule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: locator
          .get<Box<dynamic>>(instanceName: BoxType.settings.stringValue)
          .listenable(keys: [serverNameKey, scheduleTimeKey]),
      builder: (context, value, _) {
        apptextFieldController.text = value.get(
            changeIsSchedule ? scheduleTimeKey : serverNameKey,
            defaultValue: changeIsSchedule
                ? '10'
                : 'https://parlak.com.tm/api/sms_otp_list');
        if (changeIsSchedule) {
          int? initialTimerDuration = int.tryParse(apptextFieldController.text);
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hms,
              initialTimerDuration:
                  Duration(seconds: initialTimerDuration ?? 0),
              onTimerDurationChanged: (Duration newDuration) {
                if (newDuration.inSeconds == 0) {
                  apptextFieldController.text = '1';
                } else {
                  apptextFieldController.text =
                      newDuration.inSeconds.toString();
                }
              },
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextFormField(
              autocorrect: true,
              controller: apptextFieldController,
              keyboardType:
                  changeIsSchedule ? TextInputType.number : TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                filled: true,
              ),
              validator: (value) {
                if (value!.length >= 3) {
                  return null;
                } else {
                  return 'Enter valid url';
                }
              },
            ),
          );
        }
      },
    );
  }
}
