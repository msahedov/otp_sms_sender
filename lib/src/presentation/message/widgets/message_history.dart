import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/enum/message_filters.dart';
import '../../../core/list_util.dart';
import '../../../core/time_extensions.dart';
import '../../../data/message/model/message.dart';
import '../../../service_locator.dart';
import '../../../core/message_extensions.dart';
import 'message_month_card.dart';

class MessageHistory extends StatelessWidget {
  const MessageHistory({required this.valueNotifier, this.isHome = false});

  final ValueNotifier<FilterMessage> valueNotifier;

  final bool isHome;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Message>>(
      valueListenable: locator.get<Box<Message>>().listenable(),
      builder: (_, value, child) {
        final messages = value.messages;
        if (messages.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                children: const [
                  // Icon(
                  //   Icons.message_outlined,
                  //   size: 60,
                  // ),
                  // Text(
                  //   'No sent message found yet',
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ),
          );
        }
        return ValueListenableBuilder<FilterMessage>(
          valueListenable: valueNotifier,
          builder: (_, value, __) {
            final maps = groupBy(messages,
                (Message element) => element.timestamp.formatted(value));
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(5),
              physics: isHome
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemCount: maps.entries.length,
              itemBuilder: (_, mapIndex) => MessageMonthCardWidget(
                title: maps.keys.elementAt(mapIndex),
                total: maps.values.elementAt(mapIndex).length,
                messages: maps.values.elementAt(mapIndex),
              ),
            );
          },
        );
      },
    );
  }
}
