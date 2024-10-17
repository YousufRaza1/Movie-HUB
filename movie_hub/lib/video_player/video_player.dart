import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CustomVideoPlayer({required this.videoUrl});

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    // Using the new networkUrl constructor
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));

    try {
      await _controller.initialize();
      setState(() {
        _isLoading = false;
        _hasError = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _forward10Seconds() {
    final newPosition = _controller.value.position + Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  void _rewind10Seconds() {
    final newPosition = _controller.value.position - Duration(seconds: 10);
    _controller.seekTo(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Video player view
        _isLoading
            ? CircularProgressIndicator() // Show loading while the video initializes
            : _hasError
            ? Text(
          'Error loading video',
          style: TextStyle(color: Colors.red),
        )
            : AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        SizedBox(height: 20),
        // Video controls
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rewind 10 seconds button
            IconButton(
              onPressed: _rewind10Seconds,
              icon: Icon(Icons.replay_10, color: Colors.white),
            ),
            // Play/Pause button
            IconButton(
              onPressed: _togglePlayPause,
              icon: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
            // Forward 10 seconds button
            IconButton(
              onPressed: _forward10Seconds,
              icon: Icon(Icons.forward_10, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
