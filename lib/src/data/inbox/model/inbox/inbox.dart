import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'recipient.dart';

class Inbox extends Equatable {
  final bool? succes;
  final List<Recipient>? data;

  const Inbox({this.succes, this.data});

  factory Inbox.fromMap(Map<String, dynamic> data) => Inbox(
        succes: data['succes'] as bool?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => Recipient.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'succes': succes,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Inbox].
  factory Inbox.fromJson(String data) {
    return Inbox.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Inbox] to a JSON string.
  String toJson() => json.encode(toMap());

  Inbox copyWith({
    bool? succes,
    List<Recipient>? data,
  }) {
    return Inbox(
      succes: succes ?? this.succes,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [succes, data];
}
