// To parse this JSON data, do
//
//     final blocedUnits = blocedUnitsFromJson(jsonString);

import 'dart:convert';

BlocedUnits blocedUnitsFromJson(final String str) =>
    BlocedUnits.fromJson(json.decode(str));

String blocedUnitsToJson(final BlocedUnits data) => json.encode(data.toJson());

class BlocedUnits {
  factory BlocedUnits.fromJson(final Map<String, dynamic> json) => BlocedUnits(
        holdMessage: json["hold_message"],
        holdTime: json["hold_time"],
        holdTimeMesssage: json["hold_time_messsage"],
      );

  BlocedUnits({
    this.holdMessage,
    this.holdTime,
    this.holdTimeMesssage,
  });
  String? holdMessage;
  String? holdTime;
  String? holdTimeMesssage;

  BlocedUnits copyWith({
    final String? holdMessage,
    final String? holdTime,
    final String? holdTimeMesssage,
  }) =>
      BlocedUnits(
        holdMessage: holdMessage ?? this.holdMessage,
        holdTime: holdTime ?? this.holdTime,
        holdTimeMesssage: holdTimeMesssage ?? this.holdTimeMesssage,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "hold_message": holdMessage,
        "hold_time": holdTime,
        "hold_time_messsage": holdTimeMesssage,
      };
}
