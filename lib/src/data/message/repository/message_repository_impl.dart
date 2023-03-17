import '../../../core/enum/message_status.dart';
import '../../../data/message/data_sources/message_manager_local_data_source.dart';
import '../../../data/message/model/message.dart';
import '../../../domain/message/repository/message_repository.dart';

class MessageRepositoryImpl extends MessageRepository {
  MessageRepositoryImpl({
    required this.dataSource,
  });

  final LocalMessageManagerDataSource dataSource;

  @override
  Future<void> clearMessage(int messageId) async {
    await dataSource.clearMessage(messageId);
  }

  @override
  Future<void> clearAllMessage() async {
    await dataSource.clearMessages();
  }

  @override
  Future<Message?> fetchMessageFromId(int messageId) =>
      dataSource.fetchMessageFromId(messageId);

  @override
  Future<void> addMessage(String recipient, String sender, DateTime timestamp,
      MessageStatus messageStatus, String body) async {
    final message = Message(
        body: body,
        recipient: recipient,
        sender: sender,
        messageStatus: messageStatus,
        timestamp: timestamp);
    await dataSource.addMessage(message);
  }
}
