import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:on_audio_room/details/rooms/song_entity.dart';

part 'most_played_entity.g.dart';

/// A [Entity] that contains all most_played information.
@HiveType(typeId: 3)
class MostPlayedEntity extends SongEntity {
  MostPlayedEntity(
    this.key,
    this.timePlayed,
    this.lastTimePlayed,
    this.playCount,
  );

  /// A unique [key] that represent every [most_played] song.
  @HiveField(11)
  late int key;

  /// [timePlayed]
  @HiveField(12)
  int? timePlayed;

  /// [lastTimePlayed]
  @HiveField(13)
  int? lastTimePlayed;

  /// [playCount]
  @HiveField(14)
  late int playCount;

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
        "last_time_played: $lastTimePlayed, "
        "play_count: $playCount";
  }
}
