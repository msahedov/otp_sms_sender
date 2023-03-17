import 'package:hive_flutter/hive_flutter.dart';

import '../data/message/model/message.dart';

extension MessageListMapping on Box<Message> {
  List<Message> get messages =>
      values.toList()..sort(((a, b) => b.timestamp.compareTo(a.timestamp)));
}
