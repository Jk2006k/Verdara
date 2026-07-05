import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../services/battery_service.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';
import '../widgets/tree_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int battery = 0;
  String location = "Fetching location...";
  String weather = "Loading weather...";

  final BatteryService batteryService = BatteryService();
  final LocationService locationService = LocationService();
  final WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    loadBattery();
    loadLocation();
  }

  Future<void> loadBattery() async {
    try {
      int level = await batteryService.getBatteryLevel();

      if (!mounted) return;

      setState(() {
        battery = level;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loadLocation() async {
    try {
      Position position = await locationService.getLocation();

      final data = await weatherService.getWeather(
        position.latitude,
        position.longitude,
      );

      if (!mounted) return;

      setState(() {
        location =
            '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}';

        weather =
            '${data['weather'][0]['main']} | ${data['main']['temp']}°C';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        location = e.toString();
        weather = 'Unable to fetch weather';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    String weatherEmoji = '🌤️';

    if (weather.contains('Cloud')) {
      backgroundColor = Colors.blueGrey.shade200;
      weatherEmoji = '☁️';
    } else if (weather.contains('Rain')) {
      backgroundColor = Colors.grey.shade400;
      weatherEmoji = '🌧️';
    } else if (weather.contains('Clear')) {
      backgroundColor = Colors.lightBlue.shade200;
      weatherEmoji = '☀️';
    } else if (weather.contains('Thunderstorm')) {
      backgroundColor = Colors.deepPurple.shade300;
      weatherEmoji = '⛈️';
    } else if (weather.contains('Snow')) {
      backgroundColor = Colors.white;
      weatherEmoji = '❄️';
    } else {
      backgroundColor = Colors.green.shade100;
      weatherEmoji = '🌿';
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Verdara'),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TreeWidget(battery: battery),

              const SizedBox(height: 20),

              Text(
                'Battery : $battery%',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Current Location',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  location,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                '$weatherEmoji  $weather',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}