// To parse this JSON data, do
//
//     final driversInfo = driversInfoFromJson(jsonString);

import 'dart:convert';

DriversInfo driversInfoFromJson(final String str) => DriversInfo.fromJson(json.decode(str));

String driversInfoToJson(final DriversInfo data) => json.encode(data.toJson());

class DriversInfo {

    DriversInfo({
        this.driverId,
        this.name,
        this.lastName,
        this.unitId,
        this.phone,
        this.email,
        this.status,
        this.currentZip,
        this.currentLocation,
        this.currentState,
        this.currentLat,
        this.currentLng,
        this.timeOnPoint,
    });

    factory DriversInfo.fromJson(final Map<String, dynamic> json) => DriversInfo(
        driverId: json["driver_id"],
        name: json["name"],
        lastName: json["last_name"],
        unitId: json["unit_id"],
        phone: json["phone"],
        email: json["email"],
        status: json["status"],
        currentZip: json["current_zip"],
        currentLocation: json["current_location"],
        currentState: json["current_state"],
        currentLat: json["current_lat"],
        currentLng: json["current_lng"],
        timeOnPoint: json["time_on_point"] == null ? null : DateTime.parse(json["time_on_point"]),
    );
    int? driverId;
    String? name;
    String? lastName;
    String? unitId;
    String? phone;
    String? email;
    int? status;
    int? currentZip;
    String? currentLocation;
    String? currentState;
    String? currentLat;
    String? currentLng;
    DateTime? timeOnPoint;

    DriversInfo copyWith({
        final int? driverId,
        final String? name,
        final String? lastName,
        final String? unitId,
        final String? phone,
        final String? email,
        final int? status,
        final int? currentZip,
        final String? currentLocation,
        final String? currentState,
        final String? currentLat,
        final String? currentLng,
        final DateTime? timeOnPoint,
    }) => 
        DriversInfo(
            driverId: driverId ?? this.driverId,
            name: name ?? this.name,
            lastName: lastName ?? this.lastName,
            unitId: unitId ?? this.unitId,
            phone: phone ?? this.phone,
            email: email ?? this.email,
            status: status ?? this.status,
            currentZip: currentZip ?? this.currentZip,
            currentLocation: currentLocation ?? this.currentLocation,
            currentState: currentState ?? this.currentState,
            currentLat: currentLat ?? this.currentLat,
            currentLng: currentLng ?? this.currentLng,
            timeOnPoint: timeOnPoint ?? this.timeOnPoint,
        );

    Map<String, dynamic> toJson() => <String, dynamic>{
        "driver_id": driverId,
        "name": name,
        "last_name": lastName,
        "unit_id": unitId,
        "phone": phone,
        "email": email,
        "status": status,
        "current_zip": currentZip,
        "current_location": currentLocation,
        "current_state": currentState,
        "current_lat": currentLat,
        "current_lng": currentLng,
        "time_on_point": timeOnPoint?.toIso8601String(),
    };
}
