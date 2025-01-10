import 'dart:convert';

class DriverTracking {
  factory DriverTracking.fromRawJson(final String str) =>
      DriverTracking.fromJson(json.decode(str));

  DriverTracking({
    this.driverId,
    this.lat,
    this.lng,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory DriverTracking.fromJson(final Map<String, dynamic> json) =>
      DriverTracking(
        driverId: json["driver_id"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );
  final int? driverId;
  final double? lat;
  final double? lng;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  DriverTracking copyWith({
    final int? driverId,
    final double? lat,
    final double? lng,
    final DateTime? updatedAt,
    final DateTime? createdAt,
    final int? id,
  }) =>
      DriverTracking(
        driverId: driverId ?? this.driverId,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => <String, dynamic>{
        "driver_id": driverId,
        "lat": lat,
        "lng": lng,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
