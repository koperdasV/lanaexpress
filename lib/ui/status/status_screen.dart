import 'package:flutter/material.dart';
import 'package:lanaexpress/ui/status/inactive_screen.dart';
import 'package:lanaexpress/ui/status/status_viewmodel.dart';

final class StatusScreen extends StatelessWidget {
  const StatusScreen({required this.vm, super.key});
  final StatusViewModel vm;

  @override
  Widget build(final BuildContext context) {
    return InActiveStatusScreen(vm: vm);
  }
}
