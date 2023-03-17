import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/message.dart';
import 'message_manager_local_data_source.dart';

class LocalMessageManagerDataSourceImpl implements LocalMessageManagerDataSource {
  final Box<Message> messageBox;

  LocalMessageManagerDataSourceImpl(this.messageBox);

  Stream<BoxEvent> messages() {
    return messageBox.watch();
  }

  @override
  Future<List<Message>> filteredMessages(DateTimeRange dateTimeRange) async {
    final List<Message> messages = messageBox.values.toList();
    messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    final filteredMessages = messages.takeWhile((value) {
      return value.timestamp.isAfter(dateTimeRange.start) &&
          value.timestamp.isBefore(dateTimeRange.end);
    }).toList();
    return filteredMessages;
  }

  @override
  Future<Iterable<Message>> exportData() async => messageBox.values;

  @override
  Future<void> addMessage(Message message) async {
    final id = await messageBox.add(message);
    message.superId = id;
    message.save();
  }

  @override
  Future<void> clearMessage(int key) async {
    await messageBox.delete(key);
  }

  @override
  Future<void> clearMessages() async {
    await messageBox.clear();
  }

  @override
  Future<Message?> fetchMessageFromId(int messageId) async => messageBox.get(messageId);
}
