import 'dart:io';

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..maxConnectionsPerHost = 6
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}