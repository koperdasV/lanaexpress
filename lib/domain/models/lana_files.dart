// To parse this JSON data, do
//
//     final lanaFiles = lanaFilesFromJson(jsonString);

import 'dart:convert';

LanaFiles lanaFilesFromJson(String str) => LanaFiles.fromJson(json.decode(str));

String lanaFilesToJson(LanaFiles data) => json.encode(data.toJson());

class LanaFiles {
    int? id;
    int? loadId;
    String? filename;
    String? url;
    DateTime? deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    LanaFiles({
        this.id,
        this.loadId,
        this.filename,
        this.url,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    LanaFiles copyWith({
        int? id,
        int? loadId,
        String? filename,
        String? url,
        DateTime? deletedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        LanaFiles(
            id: id ?? this.id,
            loadId: loadId ?? this.loadId,
            filename: filename ?? this.filename,
            url: url ?? this.url,
            deletedAt: deletedAt ?? this.deletedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory LanaFiles.fromJson(Map<String, dynamic> json) => LanaFiles(
        id: json["id"],
        loadId: json["load_id"],
        filename: json["filename"],
        url: json["url"],
        deletedAt: json["deleted_at"]== null ? null : DateTime.parse(json["deleted_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "load_id": loadId,
        "filename": filename,
        "url": url,
        "deleted_at": deletedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
