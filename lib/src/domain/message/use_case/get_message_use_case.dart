import '../../../data/message/model/message.dart';
import '../../../domain/message/repository/message_repository.dart';

class GetMessageUseCase {
  GetMessageUseCase({required this.messageRepository});

  final MessageRepository messageRepository;

  Future<Message?> call(int messageId) async =>
      messageRepository.fetchMessageFromId(messageId);
}
