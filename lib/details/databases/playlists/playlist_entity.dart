import 'package:hive/hive.dart';
import 'package:on_audio_room/details/databases/song_entity.dart';

part 'playlist_entity.g.dart';

///
@HiveType(typeId: 4)
class PlaylistEntity {
  PlaylistEntity(
    this.key,
    this.playlistName,
    this.playlistDateModified,
    this.playlistDataAdded,
    this.playlistSongs,
  );

  ///
  @HiveField(0)
  late int key;

  ///
  @HiveField(1)
  late String playlistName;

  ///
  @HiveField(2)
  late int playlistDateModified;

  ///
  @HiveField(3)
  int? playlistDataAdded;

  ///
  @HiveField(4)
  List<SongEntity> playlistSongs = [];
}
