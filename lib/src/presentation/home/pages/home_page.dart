import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

import '../../../core/theme/app_theme.dart';
import '../../../service_locator.dart';
import '../../../presentation/widgets/future_resolve.dart';
import '../../../app/routes.dart';
import '../../../core/enum/message_filters.dart';
import '../../../data/inbox/model/inbox/recipient.dart';
import '../../../data/inbox/model/inbox/inbox.dart';
import '../../../presentation/home/widgets/server_and_time_widget.dart';
import '../../../presentation/home/widgets/power_button.dart';
import '../../../presentation/home/widgets/timer_widget.dart';
import '../../../presentation/message/bloc/message_bloc.dart';
import '../../../presentation/message/widgets/message_history.dart';
import '../../../presentation/widgets/app_card.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  ValueNotifier<bool> isPaused = ValueNotifier(true);
  ValueNotifier<int> timerNotifier = ValueNotifier(0);

  Stream? periodicStream;
  StreamSubscription? subscription;

  Telephony telephony = Telephony.instance;
  Timer? timer;

  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureResolve<MessageBloc>(
      future: locator.getAsync<MessageBloc>(),
      builder: (value) {
        final MessageBloc messageBloc = value;
        return BlocProvider(
            create: (context) => messageBloc,
            child: BlocBuilder(
              bloc: messageBloc,
              builder: (BuildContext context, state) {
                return Scaffold(
                  body: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      AppCard(
                        color: whitePrimaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PowerButton(
                                  valueNotifier: isPaused,
                                  onFunction: (interval, serverUrl) {
                                    timer = Timer.periodic(
                                        const Duration(seconds: 1), (timer) {
                                      timerNotifier.value = timer.tick;
                                    });
                                    isPaused.value = false;
                                    periodicStream = Stream.periodic(
                                        Duration(seconds: interval),
                                        (int count) {
                                      var res = fetch(serverUrl)
                                          .then((value) => value);
                                      return res;
                                    });

                                    subscription =
                                        periodicStream?.listen((event) {
                                      event.then((value) {
                                        sendMessage(context, value);
                                      });
                                    })
                                          ?..resume();
                                  },
                                  offFunction: () {
                                    isPaused.value = true;
                                    subscription?.cancel();
                                    timer?.cancel();
                                  }),
                              const SizedBox(height: 34),
                              TimerWidget(
                                  isPaused: isPaused,
                                  valueNotifier: timerNotifier),
                              const SizedBox(height: 14),
                              ServerAndTimeWidget(valueNotifier: isPaused)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListTile(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          contentPadding: const EdgeInsets.all(15),
                          title: Text(
                            'Messages',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          trailing: OutlinedButton.icon(
                              onPressed: () => context.goNamed(messagesName),
                              icon: const Text("All"),
                              label: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 20,
                              )),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height - 450,
                          width: MediaQuery.of(context).size.width,
                          child: MessageHistory(
                              isHome: true,
                              valueNotifier:
                                  ValueNotifier(FilterMessage.daily)))
                    ],
                  ),
                );
              },
            ));
      },
    );
  }

  Future<List<Recipient>> fetch(String serverUrl) async {
    try {
      final url = Uri.parse(serverUrl);
      final response = await http.get(url, headers: {
        "content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        var result = Inbox.fromJson(response.body);

        return result.data!;
      } else {
        return [];
      }
    } catch (ex) {
      rethrow;
    }
  }

  void sendMessage(BuildContext context, List<Recipient> recipients) async {
    if (recipients.isNotEmpty) {
      for (var recipient in recipients) {
        await telephony
            .sendSms(
          to: recipient.phoneNumber ?? '',
          message: recipient.body ?? '',
        )
            .whenComplete(() {
          context
              .read<MessageBloc>()
              .add(AddMessageEvent(recipient: recipient));
        });
      }
    }
  }

  void checkPermission() async {
    bool? permissionsGranted = await telephony.requestSmsPermissions;
    if (permissionsGranted == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'You need permission to send SMS!',
          style: TextStyle(fontFamily: 'Outfit'),
        ),
        action: SnackBarAction(
            label: 'Allow',
            onPressed: () async {
              await telephony.requestSmsPermissions;
            }),
      ));
    }
  }
}
