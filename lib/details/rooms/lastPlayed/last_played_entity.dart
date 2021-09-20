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
    return "($runtimeType): "
        "key: $key, "
        "_data: $lastData, "
        "_display_name: $displayName, "
        "_id: $id, "
        "album: $album, "
        "album_id: $albumId, "
        "artist: $artist, "
        "artist_id: $artistId, "
        "date_added: $dateAdded, "
        "duration: $duration, "
        "artwork (Length): ${artworkAsBytes?.length}, "
        "time_played: $timePlayed, "
        "last_time_played: $lastTimePlayed";
  }
}
