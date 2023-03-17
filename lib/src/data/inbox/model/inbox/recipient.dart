import 'dart:convert';

import 'package:equatable/equatable.dart';

class Recipient extends Equatable {
  final String? phoneNumber;
  final String? body;

  const Recipient({this.phoneNumber, this.body});

  factory Recipient.fromMap(Map<String, dynamic> data) => Recipient(
        phoneNumber: data['phone_number'] as String?,
        body: data['body'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'phone_number': phoneNumber,
        'body': body,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Recipient].
  factory Recipient.fromJson(String data) {
    return Recipient.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Recipient] to a JSON string.
  String toJson() => json.encode(toMap());

  Recipient copyWith({
    String? phoneNumber,
    String? body,
  }) {
    return Recipient(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      body: body ?? this.body,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [phoneNumber, body];
}
