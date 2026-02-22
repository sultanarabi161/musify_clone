import 'package:flutter/material.dart';
import '../services/youtube_service.dart';
import '../widgets/player_page.dart';

class PlaylistView extends StatefulWidget {
  final String url;
  const PlaylistView({super.key, required this.url});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  final yt = YoutubeService();
  List<Map<String, dynamic>> videos = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final result = await yt.getContent(widget.url);
    setState(() {
      videos = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Videos")),
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
                        await yt.getAudioUrl(video["id"]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlayerPage(
                          title: video["title"],
                          url: audioUrl,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
