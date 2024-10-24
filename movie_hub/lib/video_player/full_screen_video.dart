import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  FullScreenVideoPlayer(this.controller);

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  bool _showControls = true;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
    _startHideTimer();
  }

  void _updateState() {
    // Check if mounted to avoid calling setState after dispose
    if (mounted) {
      setState(() {});
    }
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
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
    final currentPosition = widget.controller.value.position;
    final targetPosition = currentPosition + Duration(seconds: 10);
    widget.controller.seekTo(targetPosition);
    _startHideTimer();
  }

  void _skipBackward() {
    final currentPosition = widget.controller.value.position;
    final targetPosition = currentPosition - Duration(seconds: 10);
    widget.controller.seekTo(targetPosition);
    _startHideTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Center(
          child: widget.controller.value.isInitialized
              ? Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: widget.controller.value.aspectRatio,
                  child: VideoPlayer(widget.controller),
                ),
              ),

              if (widget.controller.value.isBuffering)
                Center(
                  child: CircularProgressIndicator(),
                ),

              if (_showControls)
                Center(
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _skipBackward,
                            icon: Icon(Icons.replay_10),
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                widget.controller.value.isPlaying
                                    ? widget.controller.pause()
                                    : widget.controller.play();
                              });
                              _startHideTimer();
                            },
                            icon: Icon(
                              widget.controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            onPressed: _skipForward,
                            icon: Icon(Icons.forward_10),
                          ),
                        ],
                      ),
                      Spacer()
                    ],
                  ),
                ),

              if (_showControls)
                Positioned(
                    top: 30,
                    right: 30,
                    child: DropdownButton<double>(
                      value: widget.controller.value.playbackSpeed,
                      items: [0.5, 1.0, 1.5, 2.0].map((speed) {
                        return DropdownMenuItem(
                          value: speed,
                          child: Text('${speed}x',
                              style: TextStyle(fontSize: 12)),
                        );
                      }).toList(),
                      onChanged: (speed) {
                        widget.controller.setPlaybackSpeed(speed!);
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
                          SizedBox(width: 0), // No space
                          SizedBox(
                            width: 50,
                            child: Text(
                              '${widget.controller.value.position.inMinutes}:${widget.controller.value.position.inSeconds.remainder(60)}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: widget.controller.value.position.inSeconds.toDouble(),
                              min: 0,
                              max: widget.controller.value.duration.inSeconds.toDouble(),
                              onChanged: (value) {
                                widget.controller.seekTo(Duration(seconds: value.toInt()));
                              },
                            ),
                          ),
                          SizedBox(width: 0), // No space between slider and text
                          Text(
                            '${widget.controller.value.duration.inMinutes}:${widget.controller.value.duration.inSeconds.remainder(60)}',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 0), // No space between text and icon
                          IconButton(
                            icon: Icon(Icons.fullscreen_exit, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context); // Exit fullscreen
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
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState); // Remove listener
    _hideTimer?.cancel();
    super.dispose();
  }
}
