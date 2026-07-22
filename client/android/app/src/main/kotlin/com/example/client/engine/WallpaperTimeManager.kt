package com.example.client.engine

import com.example.client.R
import java.util.Calendar

object WallpaperTimeManager {

    fun getCurrentWallpaper(): Int {

        val hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY)

        return when (hour) {

            5 -> R.drawable.wallpaper_5am
            6 -> R.drawable.wallpaper_6am
            7 -> R.drawable.wallpaper_7am
            8 -> R.drawable.wallpaper_8am
            9 -> R.drawable.wallpaper_9am
            10 -> R.drawable.wallpaper_10am
            11 -> R.drawable.wallpaper_11am
            12 -> R.drawable.wallpaper_12pm
            13 -> R.drawable.wallpaper_1pm
            14 -> R.drawable.wallpaper_2pm
            15 -> R.drawable.wallpaper_3pm
            16 -> R.drawable.wallpaper_4pm
            17 -> R.drawable.wallpaper_5pm
            18 -> R.drawable.wallpaper_6pm
            19 -> R.drawable.wallpaper_7pm
            20 -> R.drawable.wallpaper_8pm

            21,
            22,
            23 -> R.drawable.wallpaper_10pm

            0,
            1,
            2,
            3,
            4 -> R.drawable.wallpaper_12am

            else -> R.drawable.wallpaper_5am
        }
    }
}