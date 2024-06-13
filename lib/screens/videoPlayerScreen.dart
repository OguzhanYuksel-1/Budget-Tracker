import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:budget_tracker/widgets/widgets/auth_gate.dart'; 

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('lib/assets/WelcomeScreen.mp4')
      ..initialize().then((_) {
        setState(() {}); 
        _controller.play(); 
        setState(() {
          _isPlaying = true;
        });
        _controller.addListener(_onVideoEnd); 
      });
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoEnd); 
    _controller.dispose(); 
    super.dispose();
  }

  void _onVideoEnd() {
    if (_controller.value.position == _controller.value.duration) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthGate()), 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
            _isPlaying = !_isPlaying;
          });
        },
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

