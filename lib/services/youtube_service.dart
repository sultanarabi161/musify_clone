import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeService {
  final yt = YoutubeExplode();

  Future<List<Map<String, dynamic>>> getContent(String url) async {
    List<Map<String, dynamic>> list = [];

    if (url.contains("list=")) {
      final playlist = await yt.playlists.get(url);
      final videos = yt.playlists.getVideos(playlist.id);

      await for (var video in videos) {
        list.add({
          "title": video.title,
          "id": video.id.value,
        });
      }
    } else {
      final video = await yt.videos.get(url);
      list.add({
        "title": video.title,
        "id": video.id.value,
      });
    }

    return list;
  }

  Future<String> getAudioUrl(String videoId) async {
    final manifest = await yt.videos.streamsClient.getManifest(videoId);
    final audio = manifest.audioOnly.withHighestBitrate();
    return audio.url.toString();
  }
}
