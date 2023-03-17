part of 'message_bloc.dart';

@immutable
abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageAdded extends MessageState {}

class MessageDeletedState extends MessageState {}

class MessageErrorState extends MessageState {
  final String errorString;

  const MessageErrorState(this.errorString);

  @override
  List<Object> get props => [errorString];
}

class MessageSuccessState extends MessageState {
  final Message message;

  const MessageSuccessState(this.message);

  @override
  List<Object> get props => [message];
}
