// To parse this JSON data, do
//
//     final driverBid = driverBidFromJson(jsonString);

import 'dart:convert';

DriverBid driverBidFromJson(String str) => DriverBid.fromJson(json.decode(str));

String driverBidToJson(DriverBid data) => json.encode(data.toJson());

class DriverBid {
    int? driverId;
    int? price;
    int? companyId;
    int? loadId;

    DriverBid({
        this.driverId,
        this.price,
        this.companyId,
        this.loadId,
    });

    DriverBid copyWith({
        int? driverId,
        int? price,
        int? companyId,
        int? loadId,
    }) => 
        DriverBid(
            driverId: driverId ?? this.driverId,
            price: price ?? this.price,
            companyId: companyId ?? this.companyId,
            loadId: loadId ?? this.loadId,
        );

    factory DriverBid.fromJson(Map<String, dynamic> json) => DriverBid(
        driverId: json["driver_id"],
        price: json["price"],
        companyId: json["company_id"],
        loadId: json["load_id"],
    );

    Map<String, dynamic> toJson() => {
        "driver_id": driverId,
        "price": price,
        "company_id": companyId,
        "load_id": loadId,
    };
}
