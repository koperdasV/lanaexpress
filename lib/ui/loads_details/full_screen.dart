import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lanaexpress/utils/utils.dart';

class FullScreenPhotoWidget extends StatelessWidget {

  const FullScreenPhotoWidget({required this.src, final Key? key}) : super(key: key);
  final File src;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: containsSymbol(src.path) ? Image.network(src.path) : Image.asset(src.path),
    );
  }
}