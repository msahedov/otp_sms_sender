part of 'message_bloc.dart';

@immutable
abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class FetchMessageFromIdEvent extends MessageEvent {
  final String? messageId;

  const FetchMessageFromIdEvent(this.messageId);
}

class AddMessageEvent extends MessageEvent {
  final Recipient recipient;
  const AddMessageEvent({required this.recipient});
}

class ClearMessageEvent extends MessageEvent {
  final int messageId;

  const ClearMessageEvent(this.messageId);
}

class ClearAllMessageEvent extends MessageEvent {}
