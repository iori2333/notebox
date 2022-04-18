import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist with EquatableMixin {
  final int id;
  final String name;
  final String? imageUrl;

  const Artist({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);

  @override
  List<Object?> get props => [id, name, imageUrl];
}
