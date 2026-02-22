import 'package:flutter/material.dart';
import '../services/youtube_service.dart';
import '../widgets/audio_player_widget.dart';

class PlaylistView extends StatefulWidget {
  final String playlistUrl;
  const PlaylistView({super.key, required this.playlistUrl});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  final YoutubeService ytService = YoutubeService();
  List<Map<String, dynamic>> videos = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadPlaylist();
  }

  Future<void> loadPlaylist() async {
    try {
      final result = await ytService.getPlaylist(widget.playlistUrl);
      setState(() {
        videos = result;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Playlist")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return ListTile(
                  title: Text(video["title"]),
                  onTap: () async {
                    final audioUrl =
                        await ytService.getAudioUrl(video["id"]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AudioPlayerWidget(url: audioUrl),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
