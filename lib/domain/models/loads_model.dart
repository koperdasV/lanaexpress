// To parse this JSON data, do
//
//     final loadsModel = loadsModelFromJson(jsonString);

import 'dart:convert';

import 'package:lanaexpress/domain/models/driver_full_info.dart';
import 'package:lanaexpress/domain/models/stops_model.dart';

LoadsResponse loadsModelFromJson(final String str) => LoadsResponse.fromJson(json.decode(str));

String loadsModelToJson(final LoadsResponse data) => json.encode(data.toJson());

class LoadsResponse {

    factory LoadsResponse.fromJson(final Map<String, dynamic> json) => LoadsResponse(
        id: json["id"],
        name: json["name"],
        customerId: json["customer_id"],
        phone: json["phone"],
        emails: json["emails"],
        pkpAddress: json["pkp_address"],
        pkpCity: json["pkp_city"],
        pkpState: json["pkp_state"],
        pkpZip: json["pkp_zip"],
        pkpDate: json["pkp_date"] == null ? null : DateTime.parse(json["pkp_date"]),
        pkpTimeZone: json["pkp_time_zone"],
        delAddress: json["del_address"],
        delCity: json["del_city"],
        delState: json["del_state"],
        delZip: json["del_zip"],
        delDate: json["del_date"] == null ? null : DateTime.parse(json["del_date"]),
        delTimeZone: json["del_time_zone"],
        vehicleType: json["vehicle_type"],
        loadPrice: json["load_price"],
        isIndividual: json["is_individual"],
        isSpecial: json["is_special"],
        specialTsa: json["special_tsa"],
        specialHazmat: json["special_hazmat"],
        specialBonded: json["special_bonded"],
        specialCtpat: json["special_ctpat"],
        specialScac: json["special_scac"],
        status: json["status"],
        companyId: json["company_id"],
        driverId: json["driver_id"],
        unitId: json["unit_id"],
        driverRate: json["driver_rate"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
        pkpCompanyName: json["pkp_company_name"],
        delCompanyName: json["del_company_name"],
        reminderType: json["reminder_type"],
        distance: json["distance"],
        pkpTimeType: json["pkp_time_type"],
        delTimeType: json["del_time_type"],
        distanceLeft: json["distance_left"],
        internalComment: json["internal_comment"],
        pkpLat: json["pkp_lat"],
        pkpLng: json["pkp_lng"],
        delLat: json["del_lat"],
        delLng: json["del_lng"],
        trackingLink: json["tracking_link"],
        trackingUpdateTime: json["tracking_update_time"] == null ? null : DateTime.parse(json["tracking_update_time"]),
        stopsList: json["stops_list"] == null ? <Stops>[] : List<Stops>.from(json["stops_list"]!.map((final dynamic x) => Stops.fromJson(x))),
        driverFullInfo: json["driver_full_info"] == null ? null : DriverFullInfo.fromMap(json["driver_full_info"]),
    );

    LoadsResponse({
        this.id,
        this.name,
        this.customerId,
        this.phone,
        this.emails,
        this.pkpAddress,
        this.pkpCity,
        this.pkpState,
        this.pkpZip,
        this.pkpDate,
        this.pkpTimeZone,
        this.delAddress,
        this.delCity,
        this.delState,
        this.delZip,
        this.delDate,
        this.delTimeZone,
        this.vehicleType,
        this.loadPrice,
        this.isIndividual,
        this.isSpecial,
        this.specialTsa,
        this.specialHazmat,
        this.specialBonded,
        this.specialCtpat,
        this.specialScac,
        this.status,
        this.companyId,
        this.driverId,
        this.unitId,
        this.driverRate,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.pkpCompanyName,
        this.delCompanyName,
        this.reminderType,
        this.distance,
        this.pkpTimeType,
        this.delTimeType,
        this.distanceLeft,
        this.internalComment,
        this.pkpLat,
        this.pkpLng,
        this.delLat,
        this.delLng,
        this.trackingLink,
        this.trackingUpdateTime,
        this.stopsList,
        this.driverFullInfo,
    });
    int? id;
    String? name;
    int? customerId;
    String? phone;
    String? emails;
    String? pkpAddress;
    String? pkpCity;
    String? pkpState;
    String? pkpZip;
    DateTime? pkpDate;
    String? pkpTimeZone;
    String? delAddress;
    String? delCity;
    String? delState;
    String? delZip;
    DateTime? delDate;
    String? delTimeZone;
    String? vehicleType;
    num? loadPrice;
    int? isIndividual;
    int? isSpecial;
    int? specialTsa;
    int? specialHazmat;
    int? specialBonded;
    int? specialCtpat;
    int? specialScac;
    int? status;
    int? companyId;
    int? driverId;
    int? unitId;
    int? driverRate;
    String? createdAt;
    DateTime? updatedAt;
    int? userId;
    String? pkpCompanyName;
    String? delCompanyName;
    int? reminderType;
    num? distance;
    String? pkpTimeType;
    String? delTimeType;
    num? distanceLeft;
    String? internalComment;
    String? pkpLat;
    String? pkpLng;
    String? delLat;
    String? delLng;
    String? trackingLink;
    DateTime? trackingUpdateTime;
    List<Stops>? stopsList;
    DriverFullInfo? driverFullInfo;

    LoadsResponse copyWith({
        final int? id,
        final String? name,
        final int? customerId,
        final String? phone,
        final String? emails,
        final String? pkpAddress,
        final String? pkpCity,
        final String? pkpState,
        final String? pkpZip,
        final DateTime? pkpDate,
        final String? pkpTimeZone,
        final String? delAddress,
        final String? delCity,
        final String? delState,
        final String? delZip,
        final DateTime? delDate,
        final String? delTimeZone,
        final String? vehicleType,
        final num? loadPrice,
        final int? isIndividual,
        final int? isSpecial,
        final int? specialTsa,
        final int? specialHazmat,
        final int? specialBonded,
        final int? specialCtpat,
        final int? specialScac,
        final int? status,
        final int? companyId,
        final int? driverId,
        final int? unitId,
        final int? driverRate,
        final String? createdAt,
        final DateTime? updatedAt,
        final int? userId,
        final String? pkpCompanyName,
        final String? delCompanyName,
        final int? reminderType,
        final int? distance,
        final String? pkpTimeType,
        final String? delTimeType,
        final num? distanceLeft,
        final String? internalComment,
        final String? pkpLat,
        final String? pkpLng,
        final String? delLat,
        final String? delLng,
        final String? trackingLink,
        final DateTime? trackingUpdateTime,
        final List<Stops>? stopsList,
        final DriverFullInfo? driverFullInfo,

    }) => 
        LoadsResponse(
            id: id ?? this.id,
            name: name ?? this.name,
            customerId: customerId ?? this.customerId,
            phone: phone ?? this.phone,
            emails: emails ?? this.emails,
            pkpAddress: pkpAddress ?? this.pkpAddress,
            pkpCity: pkpCity ?? this.pkpCity,
            pkpState: pkpState ?? this.pkpState,
            pkpZip: pkpZip ?? this.pkpZip,
            pkpDate: pkpDate ?? this.pkpDate,
            pkpTimeZone: pkpTimeZone ?? this.pkpTimeZone,
            delAddress: delAddress ?? this.delAddress,
            delCity: delCity ?? this.delCity,
            delState: delState ?? this.delState,
            delZip: delZip ?? this.delZip,
            delDate: delDate ?? this.delDate,
            delTimeZone: delTimeZone ?? this.delTimeZone,
            vehicleType: vehicleType ?? this.vehicleType,
            loadPrice: loadPrice ?? this.loadPrice,
            isIndividual: isIndividual ?? this.isIndividual,
            isSpecial: isSpecial ?? this.isSpecial,
            specialTsa: specialTsa ?? this.specialTsa,
            specialHazmat: specialHazmat ?? this.specialHazmat,
            specialBonded: specialBonded ?? this.specialBonded,
            specialCtpat: specialCtpat ?? this.specialCtpat,
            specialScac: specialScac ?? this.specialScac,
            status: status ?? this.status,
            companyId: companyId ?? this.companyId,
            driverId: driverId ?? this.driverId,
            unitId: unitId ?? this.unitId,
            driverRate: driverRate ?? this.driverRate,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            userId: userId ?? this.userId,
            pkpCompanyName: pkpCompanyName ?? this.pkpCompanyName,
            delCompanyName: delCompanyName ?? this.delCompanyName,
            reminderType: reminderType ?? this.reminderType,
            distance: distance ?? this.distance,
            pkpTimeType: pkpTimeType ?? this.pkpTimeType,
            delTimeType: delTimeType ?? this.delTimeType,
            distanceLeft: distanceLeft ?? this.distanceLeft,
            internalComment: internalComment ?? this.internalComment,
            pkpLat: pkpLat ?? this.pkpLat,
            pkpLng: pkpLng ?? this.pkpLng,
            delLat: delLat ?? this.delLat,
            delLng: delLng ?? this.delLng,
            trackingLink: trackingLink ?? this.trackingLink,
            trackingUpdateTime: trackingUpdateTime ?? this.trackingUpdateTime,
            stopsList: stopsList ?? this.stopsList,
            driverFullInfo: driverFullInfo ?? this.driverFullInfo,
        );

    Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "name": name,
        "customer_id": customerId,
        "phone": phone,
        "emails": emails,
        "pkp_address": pkpAddress,
        "pkp_city": pkpCity,
        "pkp_state": pkpState,
        "pkp_zip": pkpZip,
        "pkp_date": pkpDate?.toIso8601String(),
        "pkp_time_zone": pkpTimeZone,
        "del_address": delAddress,
        "del_city": delCity,
        "del_state": delState,
        "del_zip": delZip,
        "del_date": delDate?.toIso8601String(),
        "del_time_zone": delTimeZone,
        "vehicle_type": vehicleType,
        "load_price": loadPrice,
        "is_individual": isIndividual,
        "is_special": isSpecial,
        "special_tsa": specialTsa,
        "special_hazmat": specialHazmat,
        "special_bonded": specialBonded,
        "special_ctpat": specialCtpat,
        "special_scac": specialScac,
        "status": status,
        "company_id": companyId,
        "driver_id": driverId,
        "unit_id": unitId,
        "driver_rate": driverRate,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
        "pkp_company_name": pkpCompanyName,
        "del_company_name": delCompanyName,
        "reminder_type": reminderType,
        "distance": distance,
        "pkp_time_type": pkpTimeType,
        "del_time_type": delTimeType,
        "distance_left": distanceLeft,
        "internal_comment": internalComment,
        "pkp_lat": pkpLat,
        "pkp_lng": pkpLng,
        "del_lat": delLat,
        "del_lng": delLng,
        "tracking_link": trackingLink,
        "tracking_update_time": trackingUpdateTime?.toIso8601String(),
        "stops_list": stopsList == null ? [] : List<dynamic>.from(stopsList!.map((x) => x.toJson())),
        "driver_full_info": driverFullInfo?.toMap(),
    };
}
