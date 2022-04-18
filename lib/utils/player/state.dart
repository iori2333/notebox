import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notebox/models/track.dart';
import 'package:notebox/utils/platform.dart';
import 'package:notebox/utils/player/desktop.dart';

enum PlayerMode {
  random,
  sequence,
  loop,
}

class PlayerState extends Equatable {
  const PlayerState({
    required this.isPlaying,
    required this.volume,
    required this.mode,
    required this.trackList,
    this.currentTrack,
    this.duration,
  });

  final bool isPlaying;
  final double volume;
  final Duration? duration;
  final PlayerMode mode;
  final Track? currentTrack;
  final TrackList trackList;

  @override
  List<Object?> get props => [isPlaying, volume, duration, mode, currentTrack];
}

abstract class PlayerController extends StateNotifier<PlayerState> {
  PlayerController()
      : super(PlayerState(
          isPlaying: false,
          volume: 0,
          mode: PlayerMode.sequence,
          trackList: TrackList.empty(),
        ));

  factory PlayerController.instance() {
    if (isDesktop) {
      return DesktopPlayerController();
    }
    return DesktopPlayerController();
  }

  @protected
  PlayerMode _mode = PlayerMode.sequence;

  Future<void> play();

  Future<void> pause();

  Future<void> previous();

  Future<void> next();

  Future<void> seekTo(Duration pos);

  Future<void> setVolume(double volume);

  Future<void> setMode(PlayerMode mode) async {
    _mode = mode;
  }

  Future<void> setTrack(Track track);

  Future<void> setTrackList(TrackList trackList);

  bool get isPlaying;

  PlayerMode get mode => _mode;

  double get volume;

  Duration? get position;

  Duration? get duration;

  Track? get currentTrack;

  TrackList get trackList;

  @protected
  void notifyListeners() {
    state = PlayerState(
      trackList: trackList,
      isPlaying: isPlaying,
      volume: volume,
      mode: mode,
      duration: duration,
      currentTrack: currentTrack,
    );
  }
}
