import 'package:flutter/material.dart';

import '../model/message.dart';

abstract class LocalMessageManagerDataSource {
  Future<void> addMessage(Message message);
  Future<List<Message>> filteredMessages(DateTimeRange dateTimeRange);
  Future<void> clearMessages();
  Future<void> clearMessage(int key);
  Future<Message?> fetchMessageFromId(int messageId);
  Future<Iterable<Message>> exportData();
}
