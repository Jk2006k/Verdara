package com.example.client

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Canvas
import android.graphics.Rect
import android.os.Handler
import android.os.Looper
import android.service.wallpaper.WallpaperService
import android.view.SurfaceHolder

class KittenWallpaperService : WallpaperService() {

    override fun onCreateEngine(): Engine {
        return KittenEngine()
    }

    inner class KittenEngine : Engine() {

        private lateinit var morningBitmap: Bitmap
        private lateinit var nightBitmap: Bitmap

        private var showMorning = true

        private val handler = Handler(Looper.getMainLooper())

        private val swapRunnable = object : Runnable {
            override fun run() {

                showMorning = !showMorning

                drawWallpaper()

                handler.postDelayed(this, 5000)
            }
        }

        override fun onSurfaceCreated(holder: SurfaceHolder) {
            super.onSurfaceCreated(holder)

            morningBitmap =
                BitmapFactory.decodeResource(
                    resources,
                    R.drawable.morning
                )

            nightBitmap =
                BitmapFactory.decodeResource(
                    resources,
                    R.drawable.night
                )

            drawWallpaper()

            handler.postDelayed(swapRunnable, 5000)
        }

        override fun onDestroy() {
            handler.removeCallbacks(swapRunnable)
            super.onDestroy()
        }

        private fun drawWallpaper() {

            var canvas: Canvas? = null

            try {

                canvas = surfaceHolder.lockCanvas()

                if (canvas == null) return

                val bitmap =
                    if (showMorning)
                        morningBitmap
                    else
                        nightBitmap

                canvas.drawBitmap(
                    bitmap,
                    null,
                    Rect(
                        0,
                        0,
                        canvas.width,
                        canvas.height
                    ),
                    null
                )

            } finally {

                if (canvas != null) {
                    surfaceHolder.unlockCanvasAndPost(canvas)
                }
            }
        }
    }
}