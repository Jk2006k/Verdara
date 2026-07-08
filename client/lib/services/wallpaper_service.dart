import 'package:flutter/services.dart';

class WallpaperService {
  static const MethodChannel _channel =
      MethodChannel(
    'verdara/wallpaper',
  );

  static Future<void>
      openWallpaperPicker() async {
    await _channel.invokeMethod(
      'openWallpaperPicker',
    );
  }
}