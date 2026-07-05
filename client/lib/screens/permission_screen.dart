import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() =>
      _PermissionScreenState();
}

class _PermissionScreenState
    extends State<PermissionScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      'assets/videos/Permission.mp4',
    )
      ..initialize().then((_) {
        setState(() {});
        _controller
          ..setLooping(true)
          ..setVolume(0)
          ..play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget permissionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.orange,
            size: 30,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_controller.value.isInitialized)
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width:
                      _controller
                          .value
                          .size
                          .width,
                  height:
                      _controller
                          .value
                          .size
                          .height,
                  child: VideoPlayer(
                    _controller,
                  ),
                ),
              ),
            )
          else
            Container(
              color: Colors.black,
            ),

          Container(
            color:
                Colors.black.withOpacity(0.45),
          ),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  const Text(
                    'Your kitten needs a few things to come alive.',
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 60),

                  permissionCard(
                    icon:
                        Icons.location_on,
                    title: 'Location',
                    subtitle:
                        'For weather and environment updates.',
                  ),

                  permissionCard(
                    icon:
                        Icons.notifications,
                    title:
                        'Notifications',
                    subtitle:
                        'Optional updates about your kitten.',
                  ),

                  permissionCard(
                    icon:
                        Icons.wallpaper,
                    title:
                        'Live Wallpaper',
                    subtitle:
                        'Set your kitten as a live wallpaper.',
                  ),

                  const Spacer(),

                  SizedBox(
                    width:
                        double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.orange,
                            shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                        30,
                                      ),
                                ),
                          ),
                      onPressed: () {
                        // permissions later
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          color:
                              Colors.white,
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}