import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'message_status.g.dart';

@HiveType(typeId: 2)
enum MessageStatus {
  @HiveField(0)
  complete,
  @HiveField(1)
  failed,
  @HiveField(2)
  pending,
}

extension MessagetatusMapping on MessageStatus {
  String name(BuildContext context) {
    switch (this) {
      case MessageStatus.complete:
        return 'Ugradyldy';
      case MessageStatus.failed:
        return 'Şowsuz';
      case MessageStatus.pending:
        return 'Ugradylýar';
    }
  }

  String hintName(BuildContext context) {
    switch (this) {
      case MessageStatus.complete:
        return 'Ugradyldy';
      case MessageStatus.failed:
        return 'Şowsuz';
      case MessageStatus.pending:
        return 'Ugradylýar';
    }
  }

  String get nameString {
    switch (this) {
      case MessageStatus.complete:
        return 'Ugradyldy';
      case MessageStatus.failed:
        return 'Şowsuz';
      case MessageStatus.pending:
        return 'Ugradylýar';
    }
  }
}

extension TransactionMap on String {
  MessageStatus get type {
    switch (this) {
      case 'Ugradyldy':
        return MessageStatus.complete;
      case 'Şowsuz':
        return MessageStatus.failed;
      case 'Ugradylýar':
        return MessageStatus.pending;
    }
    return MessageStatus.complete;
  }
}
