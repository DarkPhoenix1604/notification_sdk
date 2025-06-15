import 'package:flutter/material.dart';
import '../core/fcm_handler.dart';

class FCMWrapper extends StatefulWidget {
  final Widget child;

  const FCMWrapper({super.key, required this.child});

  @override
  State<FCMWrapper> createState() => _FCMWrapperState();
}

class _FCMWrapperState extends State<FCMWrapper> {
  @override
  void initState() {
    super.initState();
    FCMHandler.initializeFCM(context);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
