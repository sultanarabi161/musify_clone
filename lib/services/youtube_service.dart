import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeService {
  final yt = YoutubeExplode();

  Future<List<Map<String, dynamic>>> getPlaylist(String url) async {
    final playlist = await yt.playlists.get(url);
    final videos = yt.playlists.getVideos(playlist.id);

    List<Map<String, dynamic>> list = [];

    await for (var video in videos) {
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
