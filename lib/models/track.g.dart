// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) {
  return Track(
    id: json['id'] as int,
    name: json['name'] as String,
    artists: (json['artists'] as List<dynamic>)
        .map((e) => Artist.fromJson(e as Map<String, dynamic>))
        .toList(),
    imageUrl: json['imageUrl'] as String?,
    duration: Duration(microseconds: json['duration'] as int),
    songUrl: json['songUrl'] as String?,
  );
}

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'artists': instance.artists,
      'imageUrl': instance.imageUrl,
      'duration': instance.duration.inMicroseconds,
      'songUrl': instance.songUrl,
    };

TrackList _$TrackListFromJson(Map<String, dynamic> json) {
  return TrackList(
    id: json['id'] as String,
    tracks: (json['tracks'] as List<dynamic>)
        .map((e) => Track.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TrackListToJson(TrackList instance) => <String, dynamic>{
      'id': instance.id,
      'tracks': instance.tracks,
    };
