// To parse this JSON data, do
//
//     final driverFullInfo = driverFullInfoFromMap(jsonString);

import 'dart:convert';

DriverFullInfo driverFullInfoFromMap(final String str) => DriverFullInfo.fromMap(json.decode(str));

String driverFullInfoToMap(final DriverFullInfo data) => json.encode(data.toMap());

class DriverFullInfo {

    factory DriverFullInfo.fromMap(final Map<String, dynamic> json) => DriverFullInfo(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
        ssNumber: json["ss_number"],
        driverLicenseNumber: json["driver_license_number"],
        driverLicenseDate: json["driver_license_date"] == null ? null : DateTime.parse(json["driver_license_date"]),
        driverLicenseState: json["driver_license_state"],
        endorsements: json["endorsements"],
        legalStatus: json["legal_status"],
        unitId: json["unit_id"],
        status: json["status"],
        address: json["address"],
        stateId: json["state_id"],
        city: json["city"],
        zip: json["zip"],
        emergencyName: json["emergency_name"],
        emergencyPhone: json["emergency_phone"],
        emergencyRelation: json["emergency_relation"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        licenseFile: json["license_file"],
        recordFile: json["record_file"],
        passportFile: json["passport_file"],
        hazMatFile: json["haz_mat_file"],
        otherCertificateFile: json["other_certificate_file"],
        tsaCertificateFile: json["tsa_certificate_file"],
        socialSecurityFile: json["social_security_file"],
        companyId: json["company_id"],
        isMainDriver: json["is_main_driver"],
        ownerPhone: json["owner_phone"],
        lat: json["lat"],
        lng: json["lng"],
        currentLocation: json["current_location"],
        currentLocationTime: json["current_location_time"] == null ? null : DateTime.parse(json["current_location_time"]),
        secondPhone: json["second_phone"],
        secondAddress: json["second_address"],
        ownerName: json["owner_name"],
        currentZip: json["current_zip"],
        state: json["state"],
        greenOver: json["green_over"],
        reserveDate: json["reserve_date"] == null ? null : DateTime.parse(json["reserve_date"]),
        reserveUserId: json["reserve_user_id"],
        qbId: json["qb_id"],
        isLoadboarded: json["is_loadboarded"],
        tripState: json["trip_state"],
        notes: json["notes"],
        addNotes: json["add_notes"],
        ownerEmail: json["owner_email"],
        allowedVehiclesTypes: json["allowed_vehicles_types"],
        allowedForPartial: json["allowed_for_partial"],
    );

    DriverFullInfo({
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
        this.unitId,
        this.status,
        this.address,
        this.stateId,
        this.city,
        this.zip,
        this.emergencyName,
        this.emergencyPhone,
        this.emergencyRelation,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.licenseFile,
        this.recordFile,
        this.passportFile,
        this.hazMatFile,
        this.otherCertificateFile,
        this.tsaCertificateFile,
        this.socialSecurityFile,
        this.companyId,
        this.isMainDriver,
        this.ownerPhone,
        this.lat,
        this.lng,
        this.currentLocation,
        this.currentLocationTime,
        this.secondPhone,
        this.secondAddress,
        this.ownerName,
        this.currentZip,
        this.state,
        this.greenOver,
        this.reserveDate,
        this.reserveUserId,
        this.qbId,
        this.isLoadboarded,
        this.tripState,
        this.notes,
        this.addNotes,
        this.ownerEmail,
        this.allowedVehiclesTypes,
        this.allowedForPartial,
    });
    int? id;
    String? name;
    String? lastName;
    String? phone;
    String? email;
    DateTime? birthDate;
    dynamic ssNumber;
    String? driverLicenseNumber;
    DateTime? driverLicenseDate;
    String? driverLicenseState;
    dynamic endorsements;
    int? legalStatus;
    int? unitId;
    int? status;
    String? address;
    String? stateId;
    String? city;
    String? zip;
    dynamic emergencyName;
    dynamic emergencyPhone;
    dynamic emergencyRelation;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? licenseFile;
    dynamic recordFile;
    dynamic passportFile;
    dynamic hazMatFile;
    dynamic otherCertificateFile;
    dynamic tsaCertificateFile;
    dynamic socialSecurityFile;
    int? companyId;
    int? isMainDriver;
    dynamic ownerPhone;
    String? lat;
    String? lng;
    String? currentLocation;
    DateTime? currentLocationTime;
    dynamic secondPhone;
    dynamic secondAddress;
    dynamic ownerName;
    int? currentZip;
    dynamic state;
    dynamic greenOver;
    DateTime? reserveDate;
    int? reserveUserId;
    dynamic qbId;
    int? isLoadboarded;
    dynamic tripState;
    dynamic notes;
    dynamic addNotes;
    dynamic ownerEmail;
    dynamic allowedVehiclesTypes;
    int? allowedForPartial;

    DriverFullInfo copyWith({
        final int? id,
        final String? name,
        final String? lastName,
        final String? phone,
        final String? email,
        final DateTime? birthDate,
        final dynamic ssNumber,
        final String? driverLicenseNumber,
        final DateTime? driverLicenseDate,
        final String? driverLicenseState,
        final dynamic endorsements,
        final int? legalStatus,
        final int? unitId,
        final int? status,
        final String? address,
        final String? stateId,
        final String? city,
        final String? zip,
        final dynamic emergencyName,
        final dynamic emergencyPhone,
        final dynamic emergencyRelation,
        final dynamic deletedAt,
        final DateTime? createdAt,
        final DateTime? updatedAt,
        final String? licenseFile,
        final dynamic recordFile,
        final dynamic passportFile,
        final dynamic hazMatFile,
        final dynamic otherCertificateFile,
        final dynamic tsaCertificateFile,
        final dynamic socialSecurityFile,
        final int? companyId,
        final int? isMainDriver,
        final dynamic ownerPhone,
        final String? lat,
        final String? lng,
        final String? currentLocation,
        final DateTime? currentLocationTime,
        final dynamic secondPhone,
        final dynamic secondAddress,
        final dynamic ownerName,
        final int? currentZip,
        final dynamic state,
        final dynamic greenOver,
        final DateTime? reserveDate,
        final int? reserveUserId,
        final dynamic qbId,
        final int? isLoadboarded,
        final dynamic tripState,
        final dynamic notes,
        final dynamic addNotes,
        final dynamic ownerEmail,
        final dynamic allowedVehiclesTypes,
        final int? allowedForPartial,
    }) => 
        DriverFullInfo(
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
            unitId: unitId ?? this.unitId,
            status: status ?? this.status,
            address: address ?? this.address,
            stateId: stateId ?? this.stateId,
            city: city ?? this.city,
            zip: zip ?? this.zip,
            emergencyName: emergencyName ?? this.emergencyName,
            emergencyPhone: emergencyPhone ?? this.emergencyPhone,
            emergencyRelation: emergencyRelation ?? this.emergencyRelation,
            deletedAt: deletedAt ?? this.deletedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            licenseFile: licenseFile ?? this.licenseFile,
            recordFile: recordFile ?? this.recordFile,
            passportFile: passportFile ?? this.passportFile,
            hazMatFile: hazMatFile ?? this.hazMatFile,
            otherCertificateFile: otherCertificateFile ?? this.otherCertificateFile,
            tsaCertificateFile: tsaCertificateFile ?? this.tsaCertificateFile,
            socialSecurityFile: socialSecurityFile ?? this.socialSecurityFile,
            companyId: companyId ?? this.companyId,
            isMainDriver: isMainDriver ?? this.isMainDriver,
            ownerPhone: ownerPhone ?? this.ownerPhone,
            lat: lat ?? this.lat,
            lng: lng ?? this.lng,
            currentLocation: currentLocation ?? this.currentLocation,
            currentLocationTime: currentLocationTime ?? this.currentLocationTime,
            secondPhone: secondPhone ?? this.secondPhone,
            secondAddress: secondAddress ?? this.secondAddress,
            ownerName: ownerName ?? this.ownerName,
            currentZip: currentZip ?? this.currentZip,
            state: state ?? this.state,
            greenOver: greenOver ?? this.greenOver,
            reserveDate: reserveDate ?? this.reserveDate,
            reserveUserId: reserveUserId ?? this.reserveUserId,
            qbId: qbId ?? this.qbId,
            isLoadboarded: isLoadboarded ?? this.isLoadboarded,
            tripState: tripState ?? this.tripState,
            notes: notes ?? this.notes,
            addNotes: addNotes ?? this.addNotes,
            ownerEmail: ownerEmail ?? this.ownerEmail,
            allowedVehiclesTypes: allowedVehiclesTypes ?? this.allowedVehiclesTypes,
            allowedForPartial: allowedForPartial ?? this.allowedForPartial,
        );

    Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "name": name,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "birth_date": birthDate?.toIso8601String(),
        "ss_number": ssNumber,
        "driver_license_number": driverLicenseNumber,
        "driver_license_date": driverLicenseDate?.toIso8601String(),
        "driver_license_state": driverLicenseState,
        "endorsements": endorsements,
        "legal_status": legalStatus,
        "unit_id": unitId,
        "status": status,
        "address": address,
        "state_id": stateId,
        "city": city,
        "zip": zip,
        "emergency_name": emergencyName,
        "emergency_phone": emergencyPhone,
        "emergency_relation": emergencyRelation,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "license_file": licenseFile,
        "record_file": recordFile,
        "passport_file": passportFile,
        "haz_mat_file": hazMatFile,
        "other_certificate_file": otherCertificateFile,
        "tsa_certificate_file": tsaCertificateFile,
        "social_security_file": socialSecurityFile,
        "company_id": companyId,
        "is_main_driver": isMainDriver,
        "owner_phone": ownerPhone,
        "lat": lat,
        "lng": lng,
        "current_location": currentLocation,
        "current_location_time": currentLocationTime?.toIso8601String(),
        "second_phone": secondPhone,
        "second_address": secondAddress,
        "owner_name": ownerName,
        "current_zip": currentZip,
        "state": state,
        "green_over": greenOver,
        "reserve_date": reserveDate?.toIso8601String(),
        "reserve_user_id": reserveUserId,
        "qb_id": qbId,
        "is_loadboarded": isLoadboarded,
        "trip_state": tripState,
        "notes": notes,
        "add_notes": addNotes,
        "owner_email": ownerEmail,
        "allowed_vehicles_types": allowedVehiclesTypes,
        "allowed_for_partial": allowedForPartial,
    };
}
