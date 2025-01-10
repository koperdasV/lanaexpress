// To parse this JSON data, do
//
//     final bidsResponse = bidsResponseFromJson(jsonString);

import 'dart:convert';

BidsResponse bidsResponseFromJson(String str) => BidsResponse.fromJson(json.decode(str));

String bidsResponseToJson(BidsResponse data) => json.encode(data.toJson());

class BidsResponse {
    int? id;
    int? driverId;
    int? price;
    int? companyId;
    int? loadId;
    DateTime? createdAt;
    DateTime? updatedAt;
    DateTime? deletedAt;

    BidsResponse({
        this.id,
        this.driverId,
        this.price,
        this.companyId,
        this.loadId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    BidsResponse copyWith({
        int? id,
        int? driverId,
        int? price,
        int? companyId,
        int? loadId,
        DateTime? createdAt,
        DateTime? updatedAt,
        DateTime? deletedAt,
    }) => 
        BidsResponse(
            id: id ?? this.id,
            driverId: driverId ?? this.driverId,
            price: price ?? this.price,
            companyId: companyId ?? this.companyId,
            loadId: loadId ?? this.loadId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            deletedAt: deletedAt ?? this.deletedAt,
        );

    factory BidsResponse.fromJson(Map<String, dynamic> json) => BidsResponse(
        id: json["id"],
        driverId: json["driver_id"],
        price: json["price"],
        companyId: json["company_id"],
        loadId: json["load_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "driver_id": driverId,
        "price": price,
        "company_id": companyId,
        "load_id": loadId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt?.toIso8601String(),
    };
}
