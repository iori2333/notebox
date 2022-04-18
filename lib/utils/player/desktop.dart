import 'package:dart_vlc/dart_vlc.dart';
import 'package:notebox/models/track.dart';
import 'state.dart';

class DesktopPlayerController extends PlayerController {
  DesktopPlayerController()
      : _player = Player(id: 0, commandlineArguments: ['--no-video']) {
    _player.playbackStream.listen((event) async {
      if (event.isCompleted) {
        await next();
      }
      notifyListeners();
    });
    _player.generalStream.listen((event) => notifyListeners());
  }

  final Player _player;

  Track? _current;

  TrackList _trackList = TrackList.empty();

  @override
  Duration? get duration => _player.position.duration;

  @override
  bool get isPlaying => _player.playback.isPlaying;

  @override
  double get volume => _player.general.volume;

  @override
  Track? get currentTrack => _current;

  @override
  Duration? get position => _player.position.position;

  @override
  TrackList get trackList => _trackList;

  @override
  Future<void> pause() async {
    _player.pause();
  }

  @override
  Future<void> play() async {
    _player.play();
  }

  @override
  Future<void> previous() async {
    if (trackList.tracks.isEmpty) {
      return;
    }

    var index = trackList.tracks.cast<Track?>().indexOf(_current);
    if (index == -1 || index == 0) {
      setTrack(trackList.tracks.first);
    } else {
      setTrack(trackList.tracks[index - 1]);
    }
  }

  @override
  Future<void> next() async {
    if (trackList.tracks.isEmpty) {
      return;
    }

    var index = trackList.tracks.cast<Track?>().indexOf(_current);
    if (index == -1 || index == trackList.tracks.length - 1) {
      setTrack(trackList.tracks.first);
    } else {
      setTrack(trackList.tracks[index + 1]);
    }
  }

  @override
  Future<void> seekTo(Duration pos) async {
    _player.seek(pos);
  }

  @override
  Future<void> setVolume(double volume) async {
    _player.setVolume(volume);
    notifyListeners();
  }

  @override
  Future<void> setTrack(Track track) async {
    if (track == _current) {
      return;
    }

    if (_trackList.findById(track.id) == -1) {
      _trackList.tracks.clear();
      _trackList.tracks.add(track);
    }

    var media = Media.network(track.songUrl);
    _player.open(media, autoStart: true);
    _current = track;
    notifyListeners();
  }

  @override
  Future<void> setTrackList(TrackList trackList) async {
    _trackList = trackList;
    notifyListeners();
  }
}
