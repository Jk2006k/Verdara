package com.example.client

import android.graphics.Canvas
import android.os.Handler
import android.os.Looper
import android.service.wallpaper.WallpaperService
import android.view.SurfaceHolder
import com.example.client.engine.WallpaperRenderer

class KittenWallpaperService : WallpaperService() {

    override fun onCreateEngine(): Engine {
        return VerdaraEngine()
    }

    inner class VerdaraEngine : Engine() {

        private lateinit var renderer: WallpaperRenderer

        private val handler = Handler(Looper.getMainLooper())

        // Check every minute
        private val refreshTime = 60 * 1000L

        private val wallpaperRunnable = object : Runnable {

            override fun run() {

                drawWallpaper()

                handler.postDelayed(
                    this,
                    refreshTime
                )
            }
        }

        override fun onCreate(surfaceHolder: SurfaceHolder) {
            super.onCreate(surfaceHolder)

            renderer = WallpaperRenderer(
                this@KittenWallpaperService
            )
        }

        override fun onVisibilityChanged(visible: Boolean) {

            if (visible) {

                handler.post(wallpaperRunnable)

            } else {

                handler.removeCallbacks(wallpaperRunnable)

            }
        }

        override fun onDestroy() {
            super.onDestroy()

            handler.removeCallbacks(
                wallpaperRunnable
            )
        }

        private fun drawWallpaper() {

            var canvas: Canvas? = null

            try {

                canvas = surfaceHolder.lockCanvas()

                if (canvas != null) {

                    renderer.draw(canvas)

                }

            } finally {

                if (canvas != null) {

                    surfaceHolder.unlockCanvasAndPost(
                        canvas
                    )

                }

            }
        }
    }
}