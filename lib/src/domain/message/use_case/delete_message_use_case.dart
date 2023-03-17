import '../../../domain/message/repository/message_repository.dart';

class DeleteMessageUseCase {
  DeleteMessageUseCase({required this.messageRepository});

  final MessageRepository messageRepository;

  Future<void> call(int messageId) async =>
      messageRepository.clearMessage(messageId);
}
