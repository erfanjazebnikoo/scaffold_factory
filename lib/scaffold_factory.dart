import 'dart:async';

import 'package:flutter/services.dart';

class ScaffoldFactory {
  static const MethodChannel _channel =
      const MethodChannel('scaffold_factory');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
