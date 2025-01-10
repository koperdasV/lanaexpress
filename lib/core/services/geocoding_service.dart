import 'dart:convert';
import 'package:http/http.dart' as http;

class GeocodingService {
  static const String _apiKey = 'AIzaSyAc2v7UBKrjA4Xz6OuualrEjpUmzHkLj0g';

  static Future<String?> getAddressFromCoordinates(
      final double latitude, final double longitude) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$_apiKey';
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      final List<dynamic> results = data['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        final dynamic address = results[0]['formatted_address'];
        return address;
      }
    }
    return null;
  }
}
