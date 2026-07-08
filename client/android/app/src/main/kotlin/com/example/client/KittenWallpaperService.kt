package com.example.client

import android.service.wallpaper.WallpaperService
import android.view.SurfaceHolder
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint

class KittenWallpaperService : WallpaperService() {

    override fun onCreateEngine(): Engine {
        return KittenEngine()
    }

    inner class KittenEngine : Engine() {

        private val paint = Paint().apply {
            color = Color.WHITE
            textSize = 70f
            isAntiAlias = true
        }

        override fun onSurfaceCreated(holder: SurfaceHolder) {
            super.onSurfaceCreated(holder)
            drawWallpaper()
        }

        private fun drawWallpaper() {
            val holder = surfaceHolder

            var canvas: Canvas? = null

            try {
                canvas = holder.lockCanvas()

                canvas?.drawColor(Color.BLACK)

                canvas?.drawText(
                    "Verdara Live Wallpaper",
                    80f,
                    200f,
                    paint
                )
            } finally {
                if (canvas != null) {
                    holder.unlockCanvasAndPost(canvas)
                }
            }
        }
    }
}