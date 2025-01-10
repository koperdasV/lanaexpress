import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LocationResult {
  final double latitude;
  final double longitude;
  final String currentZip;
  final String state;
  final String currentLocation;

  LocationResult({
    required this.latitude,
    required this.longitude,
    required this.currentZip,
    required this.state,
    required this.currentLocation,
  });

  LocationResult copyWith({
    final double? latitude,
    final double? longitude,
    final String? currentZip,
    final String? state,
    final String? currentLocation,
  }) {
    return LocationResult(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      currentZip: currentZip ?? this.currentZip,
      state: state ?? this.state,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'currentZip': currentZip,
      'state': state,
      'currentLocation': currentLocation,
    };
  }

  factory LocationResult.fromMap(final Map<String, dynamic> map) {
    return LocationResult(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      currentZip: map['currentZip'] as String,
      state: map['state'] as String,
      currentLocation: map['currentLocation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationResult.fromJson(final String source) =>
      LocationResult.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationResult(latitude: $latitude, longitude: $longitude, currentZip: $currentZip, state: $state, currentLocation: $currentLocation)';
  }

  @override
  bool operator ==(covariant final LocationResult other) {
    if (identical(this, other)) {
      return true;
    }

    return other.latitude == latitude &&
        other.longitude == longitude &&
        other.currentZip == currentZip &&
        other.state == state &&
        other.currentLocation == currentLocation;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        currentZip.hashCode ^
        state.hashCode ^
        currentLocation.hashCode;
  }
}
