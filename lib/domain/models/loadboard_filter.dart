// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final loadboardFilter = loadboardFilterFromJson(jsonString);

import 'dart:convert';

LoadboardFilter loadboardFilterFromJson(final String str) =>
    LoadboardFilter.fromJson(json.decode(str));

String loadboardFilterToJson(final LoadboardFilter data) =>
    json.encode(data.toJson());

class LoadboardFilter {
  String? origin;
  String? destination;
  double? distance;
  List<int>? driverId;
  String? truckType;
  int? weight;

  LoadboardFilter({
    this.origin,
    this.destination,
    this.distance,
    this.driverId,
    this.truckType,
    this.weight,
  });

  factory LoadboardFilter.fromJson(final Map<String, dynamic> json) =>
      LoadboardFilter(
        origin: json["origin"] ?? '',
        destination: json["destination"] ?? '',
        distance: double.tryParse(json["distance"]) ?? 0,
        driverId: json["driver_id"] ?? 0,
        truckType: json["truck_type"] ?? '',
        weight: json["weight"] ?? 0,
      );

  Map<String, dynamic> toJson() => <String,dynamic >{
        "origin": origin,
        "destination": destination,
        "distance": distance,
        "driver_id": driverId,
        "truck_type": truckType,
        "weight": weight,
      };

  LoadboardFilter copyWith({
    final String? origin,
    final String? destination,
    final double? distance,
    final List<int>? driverId,
    final String? truckType,
    final int? weight,
  }) {
    return LoadboardFilter(
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      distance: distance ?? this.distance,
      driverId: driverId ?? this.driverId,
      truckType: truckType ?? this.truckType,
      weight: weight ?? this.weight,
    );
  }
}
