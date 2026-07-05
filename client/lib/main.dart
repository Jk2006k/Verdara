import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    ),
  );
}