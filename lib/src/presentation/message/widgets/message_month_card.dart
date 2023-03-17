import 'package:flutter/material.dart';

import '../../../data/message/model/message.dart';
import 'message_list_widget.dart';

class MessageMonthCardWidget extends StatelessWidget {
  const MessageMonthCardWidget({
    Key? key,
    required this.title,
    required this.total,
    required this.messages,
  }) : super(key: key);

  final String title;
  final int total;
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Text('$total', style: Theme.of(context).textTheme.bodyText1)
            ],
          ),
        ),
        MessageListWidget(
          messages: messages,
        ),
      ],
    );
  }
}
