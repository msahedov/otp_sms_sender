// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageStatusAdapter extends TypeAdapter<MessageStatus> {
  @override
  final int typeId = 2;

  @override
  MessageStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MessageStatus.complete;
      case 1:
        return MessageStatus.failed;
      case 2:
        return MessageStatus.pending;
      default:
        return MessageStatus.complete;
    }
  }

  @override
  void write(BinaryWriter writer, MessageStatus obj) {
    switch (obj) {
      case MessageStatus.complete:
        writer.writeByte(0);
        break;
      case MessageStatus.failed:
        writer.writeByte(1);
        break;
      case MessageStatus.pending:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
