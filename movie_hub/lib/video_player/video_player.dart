import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'full_screen_video.dart';

class MyVideoPlayer extends StatefulWidget {
  final String videoUrl;
  MyVideoPlayer({required this.videoUrl});
  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _controller;
  bool _showControls = true;
  Timer? _hideTimer;



  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          widget.videoUrl
      ),
    )..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      setState(() {});
    });
    _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
      if (_showControls) {
        _startHideTimer();
      }
    });
  }

  void _skipForward() {
    final currentPosition = _controller.value.position;
    final targetPosition = currentPosition + Duration(seconds: 10);
    _controller.seekTo(targetPosition);
    _startHideTimer();
  }

  void _skipBackward() {
    final currentPosition = _controller.value.position;
    final targetPosition = currentPosition - Duration(seconds: 10);
    _controller.seekTo(targetPosition);
    _startHideTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleControls,
      child: Center(
        child: _controller.value.isInitialized
            ? Stack(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: VideoPlayer(_controller),
                      ),
                      Spacer()
                    ],
                  ),
                  // Buffering indicator
                  if (_controller.value.isBuffering)
                    Center(
                      child: CircularProgressIndicator(),
                    ),

                  // Show buttons only when _showControls is true
                  if (_showControls)
                    Center(
                      child: Column(
                        children: [
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton(
                                onPressed: _skipBackward,
                                child: Icon(Icons.replay_10),
                              ),
                              SizedBox(width: 20),
                              FilledButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                  _startHideTimer();
                                },
                                child: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                              ),
                              SizedBox(width: 20),
                              FilledButton(
                                onPressed: _skipForward,
                                child: Icon(Icons.forward_10),
                              ),

                              // Fullscreen Button
                            ],
                          ),
                          Spacer()
                        ],
                      ),
                    ),

                  if (_showControls)
                    Positioned(
                      top: 20,
                      right: 20,
                      child: DropdownButton<double>(
                        value: _controller.value.playbackSpeed,
                        items: [0.5, 1.0, 1.5, 2.0].map((speed) {
                          return DropdownMenuItem(
                            value: speed,
                            child: Text('${speed}x',
                                style: TextStyle(fontSize: 12,color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (speed) {
                          _controller.setPlaybackSpeed(speed!);
                        },
                      ),
                    ),

                  if (_showControls)
                    Positioned(
                      bottom: 10,
                      left: 5,
                      right: 5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 10),
                              Center(
                                child: SizedBox(
                                  width: 50,
                                  child: Text(
                                      '${_controller.value.position.inMinutes}:${_controller.value.position.inSeconds.remainder(60)}',style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              Expanded(
                                child: Slider(
                                  value: _controller.value.position.inSeconds
                                      .toDouble(),
                                  min: 0,
                                  max: _controller.value.duration.inSeconds
                                      .toDouble(),
                                  onChanged: (value) {
                                    _controller.seekTo(
                                        Duration(seconds: value.toInt()));
                                  },
                                ),
                              ),
                              Text(
                                  '${_controller.value.duration.inMinutes}:${_controller.value.duration.inSeconds.remainder(60)}',style: TextStyle(color: Colors.white)),
                              IconButton(
                                icon: Icon(Icons.fullscreen),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenVideoPlayer(_controller),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }
}
