// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
    int? id;
    String? name;
    int? qbId;
    String? createdAt;
    String? updatedAt;
    String? website;
    String? contactName;
    String? contactLastName;
    String? email;
    String? phone;
    String? address;
    String? stateId;
    String? city;
    int? status;
    String? certeficateDate;
    String? lat;
    String? lng;
    List<Driver>? drivers;

    UserInfo({
        this.id,
        this.name,
        this.qbId,
        this.createdAt,
        this.updatedAt,
        this.website,
        this.contactName,
        this.contactLastName,
        this.email,
        this.phone,
        this.address,
        this.stateId,
        this.city,
        this.status,
        this.certeficateDate,
        this.lat,
        this.lng,
        this.drivers,
    });

    UserInfo copyWith({
        int? id,
        String? name,
        int? qbId,
        String? createdAt,
        String? updatedAt,
        String? website,
        String? contactName,
        String? contactLastName,
        String? email,
        String? phone,
        String? address,
        String? stateId,
        String? city,
        int? status,
        String? certeficateDate,
        String? lat,
        String? lng,
        List<Driver>? drivers,
    }) => 
        UserInfo(
            id: id ?? this.id,
            name: name ?? this.name,
            qbId: qbId ?? this.qbId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            website: website ?? this.website,
            contactName: contactName ?? this.contactName,
            contactLastName: contactLastName ?? this.contactLastName,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            address: address ?? this.address,
            stateId: stateId ?? this.stateId,
            city: city ?? this.city,
            status: status ?? this.status,
            certeficateDate: certeficateDate ?? this.certeficateDate,
            lat: lat ?? this.lat,
            lng: lng ?? this.lng,
            drivers: drivers ?? this.drivers,
        );

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        name: json["name"],
        qbId: json["qb_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        website: json["website"],
        contactName: json["contact_name"],
        contactLastName: json["contact_last_name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        stateId: json["state_id"],
        city: json["city"],
        status: json["status"],
        certeficateDate: json["certeficate_date"],
        lat: json["lat"],
        lng: json["lng"],
        drivers: json["drivers"] == null ? [] : List<Driver>.from(json["drivers"]!.map((x) => Driver.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "qb_id": qbId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "website": website,
        "contact_name": contactName,
        "contact_last_name": contactLastName,
        "email": email,
        "phone": phone,
        "address": address,
        "state_id": stateId,
        "city": city,
        "status": status,
        "certeficate_date": certeficateDate,
        "lat": lat,
        "lng": lng,
        "drivers": drivers == null ? [] : List<dynamic>.from(drivers?.map((x) => x.toJson()) ?? []),
    };
}

class Driver {
    int? id;
    String? name;
    String? lastName;
    String? phone;
    String? email;
    String? birthDate;
    String? ssNumber;
    String? driverLicenseNumber;
    String? driverLicenseDate;
    String? driverLicenseState;
    String? endorsements;
    int? legalStatus;
    int? status;
    String? address;
    String? stateId;
    String? city;
    String? zip;
    String? createdAt;
    String? updatedAt;
    dynamic licenseFile;
    int? companyId;
    int? isMainDriver;
    String? ownerPhone;
    String? secondPhone;
    dynamic secondAddress;
    String? ownerName;
    String? greenOver;
    int? isLoadboarded;
    String? notes;
    String? ownerEmail;
    String? allowedVehiclesTypes;
    int? allowedForPartial;

    Driver({
        this.id,
        this.name,
        this.lastName,
        this.phone,
        this.email,
        this.birthDate,
        this.ssNumber,
        this.driverLicenseNumber,
        this.driverLicenseDate,
        this.driverLicenseState,
        this.endorsements,
        this.legalStatus,
        this.status,
        this.address,
        this.stateId,
        this.city,
        this.zip,
        this.createdAt,
        this.updatedAt,
        this.licenseFile,
        this.companyId,
        this.isMainDriver,
        this.ownerPhone,
        this.secondPhone,
        this.secondAddress,
        this.ownerName,
        this.greenOver,
        this.isLoadboarded,
        this.notes,
        this.ownerEmail,
        this.allowedVehiclesTypes,
        this.allowedForPartial,
    });

    Driver copyWith({
        int? id,
        String? name,
        String? lastName,
        String? phone,
        String? email,
        String? birthDate,
        String? ssNumber,
        String? driverLicenseNumber,
        String? driverLicenseDate,
        String? driverLicenseState,
        String? endorsements,
        int? legalStatus,
        int? status,
        String? address,
        String? stateId,
        String? city,
        String? zip,
        String? createdAt,
        String? updatedAt,
        int? companyId,
        int? isMainDriver,
        String? ownerPhone,
        String? secondPhone,
        String? ownerName,
        String? greenOver,
        int? isLoadboarded,
        String? notes,
        String? ownerEmail,
        String? allowedVehiclesTypes,
        int? allowedForPartial,
    }) => 
        Driver(
            id: id ?? this.id,
            name: name ?? this.name,
            lastName: lastName ?? this.lastName,
            phone: phone ?? this.phone,
            email: email ?? this.email,
            birthDate: birthDate ?? this.birthDate,
            ssNumber: ssNumber ?? this.ssNumber,
            driverLicenseNumber: driverLicenseNumber ?? this.driverLicenseNumber,
            driverLicenseDate: driverLicenseDate ?? this.driverLicenseDate,
            driverLicenseState: driverLicenseState ?? this.driverLicenseState,
            endorsements: endorsements ?? this.endorsements,
            legalStatus: legalStatus ?? this.legalStatus,
            status: status ?? this.status,
            address: address ?? this.address,
            stateId: stateId ?? this.stateId,
            city: city ?? this.city,
            zip: zip ?? this.zip,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            licenseFile: licenseFile ?? licenseFile,
            companyId: companyId ?? this.companyId,
            isMainDriver: isMainDriver ?? this.isMainDriver,
            ownerPhone: ownerPhone ?? this.ownerPhone,
            secondPhone: secondPhone ?? this.secondPhone,
            secondAddress: secondAddress ?? secondAddress,
            ownerName: ownerName ?? this.ownerName,
            greenOver: greenOver ?? this.greenOver,
            isLoadboarded: isLoadboarded ?? this.isLoadboarded,
            notes: notes ?? this.notes,
            ownerEmail: ownerEmail ?? this.ownerEmail,
            allowedVehiclesTypes: allowedVehiclesTypes ?? this.allowedVehiclesTypes,
            allowedForPartial: allowedForPartial ?? this.allowedForPartial,
        );

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        birthDate: json["birth_date"],
        ssNumber: json["ss_number"],
        driverLicenseNumber: json["driver_license_number"],
        driverLicenseDate: json["driver_license_date"],
        driverLicenseState: json["driver_license_state"],
        endorsements: json["endorsements"],
        legalStatus: json["legal_status"],
        status: json["status"],
        address: json["address"],
        stateId: json["state_id"],
        city: json["city"],
        zip: json["zip"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        licenseFile: json["license_file"],
        companyId: json["company_id"],
        isMainDriver: json["is_main_driver"],
        ownerPhone: json["owner_phone"],
        secondPhone: json["second_phone"],
        secondAddress: json["second_address"],
        ownerName: json["owner_name"],
        greenOver: json["green_over"],
        isLoadboarded: json["is_loadboarded"],
        notes: json["notes"],
        ownerEmail: json["owner_email"],
        allowedVehiclesTypes: json["allowed_vehicles_types"],
        allowedForPartial: json["allowed_for_partial"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "birth_date": birthDate,
        "ss_number": ssNumber,
        "driver_license_number": driverLicenseNumber,
        "driver_license_date": driverLicenseDate,
        "driver_license_state": driverLicenseState,
        "endorsements": endorsements,
        "legal_status": legalStatus,
        "status": status,
        "address": address,
        "state_id": stateId,
        "city": city,
        "zip": zip,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "license_file": licenseFile,
        "company_id": companyId,
        "is_main_driver": isMainDriver,
        "owner_phone": ownerPhone,
        "second_phone": secondPhone,
        "second_address": secondAddress,
        "owner_name": ownerName,
        "green_over": greenOver,
        "is_loadboarded": isLoadboarded,
        "notes": notes,
        "owner_email": ownerEmail,
        "allowed_vehicles_types": allowedVehiclesTypes,
        "allowed_for_partial": allowedForPartial,
    };
}
