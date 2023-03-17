import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/enum/message_status.dart';
import '../../../data/inbox/model/inbox/recipient.dart';
import '../../../data/message/model/message.dart';
import '../../../domain/message/use_case/message_use_case.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc(
      {required this.messageUseCase,
      required this.addMessageUseCase,
      required this.deleteMessageUseCase,
      required this.clearAllMessageUseCase})
      : super(MessageInitial()) {
    on<MessageEvent>((event, emit) {});
    on<AddMessageEvent>(_addMessage);
    on<ClearMessageEvent>(_clearMessage);
    on<FetchMessageFromIdEvent>(_fetchMessageFromId);
    on<ClearAllMessageEvent>(_clearAllMessage);
  }

  final GetMessageUseCase messageUseCase;
  final AddMessageUseCase addMessageUseCase;
  final DeleteMessageUseCase deleteMessageUseCase;
  final ClearAllMessageUseCase clearAllMessageUseCase;

  Future<void> _clearAllMessage(
      ClearAllMessageEvent event, Emitter<MessageState> emit) async {
    await clearAllMessageUseCase();
  }

  Future<void> _fetchMessageFromId(
    FetchMessageFromIdEvent event,
    Emitter<MessageState> emit,
  ) async {
    final int? messageId = int.tryParse(event.messageId ?? '');
    if (messageId == null) return;

    final Message? message = await messageUseCase(messageId);
    if (message != null) {
      emit(MessageSuccessState(message));
    }
  }

  Future<void> _addMessage(
    AddMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    DateTime timestamp = DateTime.now();
    await addMessageUseCase(
      recipient: event.recipient.phoneNumber ?? '',
      sender: '',
      body: event.recipient.body ?? '',
      timestamp: timestamp,
      messageStatus: MessageStatus.complete,
    );
    emit(MessageAdded());
  }

  Future<void> _clearMessage(
    ClearMessageEvent event,
    Emitter<MessageState> emit,
  ) async {
    await deleteMessageUseCase(event.messageId);
    emit(MessageDeletedState());
  }
}
