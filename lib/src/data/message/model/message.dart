import 'package:hive/hive.dart';

import '../../../core/enum/message_status.dart';

part 'message.g.dart';

@HiveType(typeId: 1)
class Message extends HiveObject {
  @HiveField(0)
  String recipient;

  @HiveField(1)
  String sender;

  @HiveField(2)
  String body;

  @HiveField(3)
  DateTime timestamp;

  @HiveField(4, defaultValue: MessageStatus.pending)
  MessageStatus? messageStatus;

  @HiveField(5)
  int? superId;

  Message({
    required this.recipient,
    required this.sender,
    required this.body,
    required this.messageStatus,
    required this.timestamp,
    this.superId,
  });

  Map<String, dynamic> toJson() => {
        'recipient': recipient,
        'sender': sender,
        'timestamp': timestamp.toIso8601String(),
        'messageStatus': messageStatus,
        'body': body,
        'superId': superId,
      };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        recipient: json['recipient'],
        sender: json['sender'],
        timestamp: DateTime.parse(json['timestamp']),
        messageStatus: json['messageStatus'],
        body: json['body'],
      )..superId = json['superId'];
}
