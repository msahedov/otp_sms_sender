import 'package:sender_app/src/domain/message/repository/message_repository.dart';

class ClearAllMessageUseCase {
  ClearAllMessageUseCase({required this.messageRepository});

  final MessageRepository messageRepository;

  Future<void> call() async => messageRepository.clearAllMessage();
}
