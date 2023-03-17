import '../../../core/enum/message_status.dart';
import '../../../domain/message/repository/message_repository.dart';

class AddMessageUseCase {
  AddMessageUseCase({required this.messageRepository});

  final MessageRepository messageRepository;

  Future<void> call({
    required String recipient,
    required String sender,
    required DateTime timestamp,
    required String body,
    required MessageStatus messageStatus,
  }) =>
      messageRepository.addMessage(
          recipient, sender, timestamp, messageStatus, body);
}
