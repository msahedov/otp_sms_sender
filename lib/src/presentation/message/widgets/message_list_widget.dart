import 'package:flutter/material.dart';

import '../../../data/message/model/message.dart';
import 'message_item_widget.dart';

class MessageListWidget extends StatelessWidget {
  const MessageListWidget({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemCount: messages.length,
      itemBuilder: (_, index) {
        final message = messages[index];
        return MessageItemWidget(
          message: message,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(indent: 60, endIndent: 20, height: 0),
    );
  }
}
