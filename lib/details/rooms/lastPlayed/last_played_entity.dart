import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:on_audio_room/details/rooms/song_entity.dart';

part 'last_played_entity.g.dart';

/// A [Entity] that contains all last_played information.
@HiveType(typeId: 2)
class LastPlayedEntity extends SongEntity {
  LastPlayedEntity(
    this.key,
    this.timePlayed,
    this.lastTimePlayed,
  );

  /// A unique [key] that represent every [last_played] song.
  @HiveField(11)
  late int key;

  /// [timePlayed]
  @HiveField(12)
  int? timePlayed;

  /// [lastTimePlayed]
  @HiveField(13)
  int? lastTimePlayed;

  @override
  String toString() {
    return "(${this.runtimeType}): " +
        "key: ${this.key}, " +
        "_data: ${this.lastData}, " +
        "_display_name: ${this.displayName}, " +
        "_id: ${this.id}, " +
        "album: ${this.album}, " +
        "album_id: ${this.albumId}, " +
        "artist: ${this.artist}, " +
        "artist_id: ${this.artistId}, " +
        "date_added: ${this.dateAdded}, " +
        "duration: ${this.duration}, " +
        "artwork (Length): ${this.artworkAsBytes?.length}, " +
        "time_played: ${this.timePlayed}, " +
        "last_time_played: ${this.lastTimePlayed}";
  }
}
