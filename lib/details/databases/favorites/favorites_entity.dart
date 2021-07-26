import 'package:hive/hive.dart';
import 'package:on_audio_room/details/databases/song_entity.dart';

part 'favorites_entity.g.dart';

///
@HiveType(typeId: 1)
class FavoritesEntity extends SongEntity {
  FavoritesEntity(this.key);

  ///
  @HiveField(11)
  late int key;

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
        "title: ${this.title}, " +
        "artwork: ${this.artwork}";
  }
}
