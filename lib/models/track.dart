import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:notebox/models/artist.dart';

part 'track.g.dart';

@JsonSerializable()
class Track with EquatableMixin {
  final int id;
  final String name;
  final List<Artist> artists;
  final String? imageUrl;
  final Duration duration;
  final String? songUrl;

  Track({
    required this.id,
    required this.name,
    required this.artists,
    this.imageUrl,
    required this.duration,
    this.songUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);

  @override
  List<Object?> get props => [id, name, artists, imageUrl, duration, songUrl];
}

@JsonSerializable()
class TrackList with EquatableMixin {
  final String id;
  final List<Track> tracks;

  TrackList({
    required this.id,
    required this.tracks,
  });

  TrackList.empty()
      : id = '',
        tracks = [];

  int findById(int id) {
    return tracks.indexWhere((track) => track.id == id);
  }

  int find(Track track) {
    return tracks.indexOf(track);
  }

  factory TrackList.fromJson(Map<String, dynamic> json) =>
      _$TrackListFromJson(json);

  Map<String, dynamic> toJson() => _$TrackListToJson(this);

  @override
  List<Object?> get props => [id, tracks];
}
