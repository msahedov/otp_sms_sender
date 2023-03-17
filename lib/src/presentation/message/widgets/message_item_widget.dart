import 'package:flutter/material.dart';

import '../../../core/time_extensions.dart';
import '../../../data/message/model/message.dart';
import '../../../presentation/message/pages/message_page.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => showModalBottomSheet(
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width >= 700 ? 700 : double.infinity,
        ),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        context: context,
        builder: (_) => MessagePage(message: message),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(Colors.amber.shade100.value).withOpacity(0.25),
          child: Icon(
            Icons.password_outlined,
            color: Color(Colors.amber.shade100.value),
          ),
        ),
        title: Text(message.recipient),
        subtitle: Text(
          message.timestamp.shortDayString,
        ),
      ),
    );
  }
}
