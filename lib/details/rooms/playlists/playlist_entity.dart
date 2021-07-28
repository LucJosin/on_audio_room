import 'package:hive/hive.dart';
import 'package:on_audio_room/details/rooms/song_entity.dart';

part 'playlist_entity.g.dart';

/// A [Entity] that contains all playlist information.
@HiveType(typeId: 4)
class PlaylistEntity {
  PlaylistEntity(
    this.key,
    this.playlistName,
    this.playlistDateModified,
    this.playlistDataAdded,
    this.playlistSongs,
  );

  /// A unique [key] that represent every [playlist] song.
  @HiveField(0)
  late int key;

  /// [playlistName]
  @HiveField(1)
  late String playlistName;

  /// [playlistDateModified]
  @HiveField(2)
  late int playlistDateModified;

  /// [playlistDataAdded]
  @HiveField(3)
  int? playlistDataAdded;

  /// A list of [SongEntity] inside a specific [playlist].
  ///
  /// Important:
  ///
  /// * This list will be empty when created.
  @HiveField(4)
  List<SongEntity> playlistSongs = [];
}
