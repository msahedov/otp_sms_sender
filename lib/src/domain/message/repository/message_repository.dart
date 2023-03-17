import '../../../core/enum/message_status.dart';
import '../../../data/message/model/message.dart';

abstract class MessageRepository {
  Future<void> addMessage(
    String recipient,
    String sender,
    DateTime timestamp,
    MessageStatus messageStatus,
    String body,
  );
  Future<void> clearMessage(int messageId);

  Future<Message?> fetchMessageFromId(int messageId);
  Future<void> clearAllMessage();
}
