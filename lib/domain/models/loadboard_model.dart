// To parse this JSON data, do
//
//     final loadboard = loadboardFromJson(jsonString);

import 'dart:convert';

Loadboard loadboardFromJson(final String str) =>
    Loadboard.fromJson(json.decode(str));

String loadboardToJson(final Loadboard data) => json.encode(data.toJson());

class Loadboard {
  Loadboard({
    this.id,
    this.name,
    this.phone,
    this.emails,
    this.pkpAddress,
    this.pkpCity,
    this.pkpState,
    this.pkpZip,
    this.pkpDate,
    this.delAddress,
    this.delCity,
    this.delState,
    this.delZip,
    this.delDate,
    this.vehicleType,
    this.totalPieceCount,
    this.note,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.pkpDtt,
    this.delDtt,
    this.dimLength,
    this.dimWidth,
    this.dimHeight,
    this.dimStackable,
    this.totalWeight,
    this.loadPrice,
    this.distance,
    this.comment,
    this.lat,
    this.lng,
    this.letter,
    this.isView,
    this.userId,
    this.subject,
    this.delLat,
    this.delLng,
    this.companyName,
    this.companyPhone,
    this.companyAddress,
    this.companyState,
    this.companyCity,
    this.companyContactPerson,
    this.emailFrom,
    this.link,
    this.isClicked,
    this.isLink,
    this.messageId,
    this.mailId,
    this.driversList,
  });

  factory Loadboard.fromJson(final Map<String, dynamic> json) => Loadboard(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        emails: json["emails"],
        pkpAddress: json["pkp_address"],
        pkpCity: json["pkp_city"],
        pkpState: json["pkp_state"],
        pkpZip: json["pkp_zip"],
        pkpDate: json["pkp_date"],
        delAddress: json["del_address"],
        delCity: json["del_city"],
        delState: json["del_state"],
        delZip: json["del_zip"],
        delDate: json["del_Date"],
        vehicleType: json["vehicle_type"],
        totalPieceCount: json["total_piece_count"],
        note: json["note"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pkpDtt: json["pkp_dtt"],
        delDtt: json["del_dtt"],
        dimLength: json["dim_length"],
        dimWidth: json["dim_width"],
        dimHeight: json["dim_height"],
        dimStackable: json["dim_stackable"],
        totalWeight: json["total_weight"],
        loadPrice: json["load_price"],
        distance: json["distance"],
        comment: json["comment"],
        lat: json["lat"],
        lng: json["lng"],
        letter: json["letter"],
        isView: json["is_view"],
        userId: json["user_id"],
        subject: json["subject"],
        delLat: json["del_lat"],
        delLng: json["del_lng"],
        companyName: json["company_name"],
        companyPhone: json["company_phone"],
        companyAddress: json["company_address"],
        companyState: json["company_state"],
        companyCity: json["company_city"],
        companyContactPerson: json["company_contact_person"],
        emailFrom: json["email_from"],
        link: json["link"],
        isClicked: json["is_clicked"],
        isLink: json["is_link"],
        messageId: json["message_id"],
        mailId: json["mail_id"],
        driversList: json["drivers_list"] == null
            ? <DriversList>[]
            : List<DriversList>.from(
                json["drivers_list"]!
                    .map((final dynamic x) => DriversList.fromJson(x)),
              ),
      );
  int? id;
  String? name;
  String? phone;
  String? emails;
  String? pkpAddress;
  String? pkpCity;
  String? pkpState;
  String? pkpZip;
  String? pkpDate;
  String? delAddress;
  String? delCity;
  String? delState;
  String? delZip;
  dynamic delDate;
  String? vehicleType;
  int? totalPieceCount;
  String? note;
  String? status;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  dynamic pkpDtt;
  String? delDtt;
  String? dimLength;
  String? dimWidth;
  String? dimHeight;
  dynamic dimStackable;
  int? totalWeight;
  dynamic loadPrice;
  int? distance;
  String? comment;
  String? lat;
  String? lng;
  String? letter;
  int? isView;
  dynamic userId;
  String? subject;
  String? delLat;
  String? delLng;
  String? companyName;
  String? companyPhone;
  String? companyAddress;
  String? companyState;
  String? companyCity;
  String? companyContactPerson;
  String? emailFrom;
  dynamic link;
  int? isClicked;
  int? isLink;
  String? messageId;
  String? mailId;
  List<DriversList>? driversList;

  Loadboard copyWith({
    final int? id,
    final String? name,
    final String? phone,
    final String? emails,
    final String? pkpAddress,
    final String? pkpCity,
    final String? pkpState,
    final String? pkpZip,
    final String? pkpDate,
    final String? delAddress,
    final String? delCity,
    final String? delState,
    final String? delZip,
    final dynamic delDate,
    final String? vehicleType,
    final int? totalPieceCount,
    final String? note,
    final String? status,
    final dynamic deletedAt,
    final String? createdAt,
    final String? updatedAt,
    final dynamic pkpDtt,
    final String? delDtt,
    final String? dimLength,
    final String? dimWidth,
    final String? dimHeight,
    final dynamic dimStackable,
    final int? totalWeight,
    final dynamic loadPrice,
    final int? distance,
    final String? comment,
    final String? lat,
    final String? lng,
    final String? letter,
    final int? isView,
    final dynamic userId,
    final String? subject,
    final String? delLat,
    final String? delLng,
    final String? companyName,
    final String? companyPhone,
    final String? companyAddress,
    final String? companyState,
    final String? companyCity,
    final String? companyContactPerson,
    final String? emailFrom,
    final dynamic link,
    final int? isClicked,
    final int? isLink,
    final List<DriversList>? driversList,
  }) =>
      Loadboard(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        emails: emails ?? this.emails,
        pkpAddress: pkpAddress ?? this.pkpAddress,
        pkpCity: pkpCity ?? this.pkpCity,
        pkpState: pkpState ?? this.pkpState,
        pkpZip: pkpZip ?? this.pkpZip,
        pkpDate: pkpDate ?? this.pkpDate,
        delAddress: delAddress ?? this.delAddress,
        delCity: delCity ?? this.delCity,
        delState: delState ?? this.delState,
        delZip: delZip ?? this.delZip,
        delDate: delDate ?? this.delDate,
        vehicleType: vehicleType ?? this.vehicleType,
        totalPieceCount: totalPieceCount ?? this.totalPieceCount,
        note: note ?? this.note,
        status: status ?? this.status,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pkpDtt: pkpDtt ?? this.pkpDtt,
        delDtt: delDtt ?? this.delDtt,
        dimLength: dimLength ?? this.dimLength,
        dimWidth: dimWidth ?? this.dimWidth,
        dimHeight: dimHeight ?? this.dimHeight,
        dimStackable: dimStackable ?? this.dimStackable,
        totalWeight: totalWeight ?? this.totalWeight,
        loadPrice: loadPrice ?? this.loadPrice,
        distance: distance ?? this.distance,
        comment: comment ?? this.comment,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        letter: letter ?? this.letter,
        isView: isView ?? this.isView,
        userId: userId ?? this.userId,
        subject: subject ?? this.subject,
        delLat: delLat ?? this.delLat,
        delLng: delLng ?? this.delLng,
        companyName: companyName ?? this.companyName,
        companyPhone: companyPhone ?? this.companyPhone,
        companyAddress: companyAddress ?? this.companyAddress,
        companyState: companyState ?? this.companyState,
        companyCity: companyCity ?? this.companyCity,
        companyContactPerson: companyContactPerson ?? this.companyContactPerson,
        emailFrom: emailFrom ?? this.emailFrom,
        link: link ?? this.link,
        isClicked: isClicked ?? this.isClicked,
        isLink: isLink ?? this.isLink,
        messageId: messageId ?? messageId,
        mailId: mailId ?? mailId,
        driversList: driversList ?? this.driversList,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "name": name,
        "phone": phone,
        "emails": emails,
        "pkp_address": pkpAddress,
        "pkp_city": pkpCity,
        "pkp_state": pkpState,
        "pkp_zip": pkpZip,
        "pkp_date": pkpDate,
        "del_address": delAddress,
        "del_city": delCity,
        "del_state": delState,
        "del_zip": delZip,
        "del_Date": delDate,
        "vehicle_type": vehicleType,
        "total_piece_count": totalPieceCount,
        "note": note,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pkp_dtt": pkpDtt,
        "del_dtt": delDtt,
        "dim_length": dimLength,
        "dim_width": dimWidth,
        "dim_height": dimHeight,
        "dim_stackable": dimStackable,
        "total_weight": totalWeight,
        "load_price": loadPrice,
        "distance": distance,
        "comment": comment,
        "lat": lat,
        "lng": lng,
        "letter": letter,
        "is_view": isView,
        "user_id": userId,
        "subject": subject,
        "del_lat": delLat,
        "del_lng": delLng,
        "company_name": companyName,
        "company_phone": companyPhone,
        "company_address": companyAddress,
        "company_state": companyState,
        "company_city": companyCity,
        "company_contact_person": companyContactPerson,
        "email_from": emailFrom,
        "link": link,
        "is_clicked": isClicked,
        "is_link": isLink,
        "message_id": messageId,
        "mail_id": mailId,
        "drivers_list": driversList == null
            ? <dynamic>[]
            : List<dynamic>.from(
                driversList!.map((final DriversList x) => x.toJson()),
              ),
      };
}

class DriversList {
  DriversList({
    this.id,
    this.driverId,
    this.loadboardId,
    this.miles,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory DriversList.fromJson(final Map<String, dynamic> json) => DriversList(
        id: json["id"],
        driverId: json["driver_id"],
        loadboardId: json["loadboard_id"],
        miles: json["miles"]?.toDouble(),
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
  int? id;
  int? driverId;
  int? loadboardId;
  double? miles;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  DriversList copyWith({
    final int? id,
    final int? driverId,
    final int? loadboardId,
    final double? miles,
    final String? deletedAt,
    final String? createdAt,
    final String? updatedAt,
  }) =>
      DriversList(
        id: id ?? this.id,
        driverId: driverId ?? this.driverId,
        loadboardId: loadboardId ?? this.loadboardId,
        miles: miles ?? this.miles,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "driver_id": driverId,
        "loadboard_id": loadboardId,
        "miles": miles,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
