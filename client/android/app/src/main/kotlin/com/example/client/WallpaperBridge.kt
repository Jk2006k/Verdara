package com.example.client

import android.app.WallpaperManager
import android.content.Intent
import android.os.Build
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.ComponentName

class WallpaperBridge {

    companion object {
        const val CHANNEL =
            "verdara/wallpaper"

        fun configure(
            flutterEngine: FlutterEngine,
            activity:
                io.flutter.embedding.android.FlutterActivity,
        ) {
            MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                CHANNEL
            ).setMethodCallHandler {
                    call,
                    result ->

                if (call.method == "openWallpaperPicker") {

    val intent = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {

        Intent(WallpaperManager.ACTION_CHANGE_LIVE_WALLPAPER).apply {

            putExtra(
                WallpaperManager.EXTRA_LIVE_WALLPAPER_COMPONENT,
                android.content.ComponentName(
                    activity,
                    KittenWallpaperService::class.java
                )
            )
        }

    } else {

        Intent(WallpaperManager.ACTION_LIVE_WALLPAPER_CHOOSER)

    }

    activity.startActivity(intent)

    result.success(true)
}
            }
        }
    }
}