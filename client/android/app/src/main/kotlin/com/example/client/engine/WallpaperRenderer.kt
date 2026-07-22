package com.example.client.engine

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.Rect

class WallpaperRenderer(
    private val context: Context
) {

    private var currentBitmap: Bitmap? = null

    fun draw(canvas: Canvas) {

        loadCurrentWallpaper()

        currentBitmap?.let {

            canvas.drawBitmap(
                it,
                null,
                Rect(
                    0,
                    0,
                    canvas.width,
                    canvas.height
                ),
                null
            )

        }
    }

    private fun loadCurrentWallpaper() {

        val wallpaperId =
            WallpaperTimeManager.getCurrentWallpaper()

        currentBitmap =
            BitmapFactory.decodeResource(
                context.resources,
                wallpaperId
            )
    }
}