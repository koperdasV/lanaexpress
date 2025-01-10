import 'dart:io';

import 'package:lanaexpress/constants/strings.dart';

Future<String> checkFileType(final File? filePath) async {
  final String extension = filePath!.path.split('.').last.toLowerCase();

  if (extension == FileType.pdf) {
    return 'PDF';
  }
  if (extension == FileType.jpg || extension == 'jpeg') {
    return 'JPG';
  }
    return '';
}