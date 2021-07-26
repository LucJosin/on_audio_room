import 'package:hive/hive.dart';
import 'package:on_audio_room/details/databases/song_entity.dart';

part 'most_played_entity.g.dart';

///
@HiveType(typeId: 3)
class MostPlayedEntity extends SongEntity {
  MostPlayedEntity(
    this.key,
    this.timePlayed,
    this.lastTimePlayed,
    this.playCount,
  );

  ///
  @HiveField(11)
  late int key;

  ///
  @HiveField(12)
  int? timePlayed;

  ///
  @HiveField(13)
  int? lastTimePlayed;

  ///
  @HiveField(14)
  late int playCount;

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
        "artwork: ${this.artwork}, " +
        "time_played: ${this.timePlayed}, " +
        "last_time_played: ${this.lastTimePlayed}, " +
        "play_count: ${this.playCount}";
  }
}
