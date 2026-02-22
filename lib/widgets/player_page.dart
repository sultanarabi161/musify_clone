import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerPage extends StatefulWidget {
  final String title;
  final String url;

  const PlayerPage({super.key, required this.title, required this.url});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final player = AudioPlayer();
  bool playing = true;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await player.setUrl(widget.url);
    player.play();
  }

  void toggle() {
    if (playing) {
      player.pause();
    } else {
      player.play();
    }
    setState(() {
      playing = !playing;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: IconButton(
          iconSize: 80,
          icon: Icon(
            playing ? Icons.pause_circle : Icons.play_circle,
          ),
          onPressed: toggle,
        ),
      ),
    );
  }
}
