// To parse this JSON data, do
//
//     final stops = stopsFromJson(jsonString);

import 'dart:convert';

List<Stops> stopsFromJson(final String str) => List<Stops>.from(json.decode(str).map((final dynamic x) => Stops.fromJson(x)));

String stopsToJson(final List<Stops> data) => json.encode(List<dynamic>.from(data.map((final dynamic x) => x.toJson())));

class Stops {

    Stops({
        this.id,
        this.loadId,
        this.address,
        this.city,
        this.state,
        this.zip,
        this.date,
        this.timeZone,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.secondAddress,
        this.companyName,
    });

    factory Stops.fromJson(final Map<String, dynamic> json) => Stops(
        id: json["id"],
        loadId: json["load_id"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timeZone: json["time_zone"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        secondAddress: json["second_address"],
        companyName: json["company_name"],
    );
    int? id;
    int? loadId;
    String? address;
    String? city;
    String? state;
    String? zip;
    DateTime? date;
    String? timeZone;
    DateTime? deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic secondAddress;
    String? companyName;

    Stops copyWith({
        final int? id,
        final int? loadId,
        final String? address,
        final String? city,
        final String? state,
        final String? zip,
        final DateTime? date,
        final String? timeZone,
        final dynamic deletedAt,
        final DateTime? createdAt,
        final DateTime? updatedAt,
        final dynamic secondAddress,
        final String? companyName,
    }) => 
        Stops(
            id: id ?? this.id,
            loadId: loadId ?? this.loadId,
            address: address ?? this.address,
            city: city ?? this.city,
            state: state ?? this.state,
            zip: zip ?? this.zip,
            date: date ?? this.date,
            timeZone: timeZone ?? this.timeZone,
            deletedAt: deletedAt ?? this.deletedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            secondAddress: secondAddress ?? this.secondAddress,
            companyName: companyName ?? this.companyName,
        );

    Map<String, dynamic> toJson() => <String,dynamic >{
        "id": id,
        "load_id": loadId,
        "address": address,
        "city": city,
        "state": state,
        "zip": zip,
        "date": date?.toIso8601String(),
        "time_zone": timeZone,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "second_address": secondAddress,
        "company_name": companyName,
    };
}
