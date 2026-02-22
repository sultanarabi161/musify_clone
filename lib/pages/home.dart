import 'package:flutter/material.dart';
import 'playlist_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();

  void openPlaylist() {
    final cleaned = controller.text.trim().split("?").first;

    if (cleaned.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlaylistView(url: cleaned),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Musify Clone")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Paste YouTube Video / Playlist URL",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: openPlaylist,
              child: const Text("Load"),
            ),
          ],
        ),
      ),
    );
  }
}
