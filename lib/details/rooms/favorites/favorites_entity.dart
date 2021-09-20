import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:on_audio_room/details/rooms/song_entity.dart';

part 'favorites_entity.g.dart';

/// A [Entity] that contains all favorites information.
@HiveType(typeId: 1)
class FavoritesEntity extends SongEntity {
  FavoritesEntity(this.key);

  /// A unique [key] that represent every [favorite] song.
  @HiveField(11)
  late int key;

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
        "title: $title, "
        "artwork (Length): ${artworkAsBytes?.length}";
  }
}
