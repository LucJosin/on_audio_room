import 'package:on_audio_room/on_audio_room.dart';

/// A [on_audio_room] extension to help the package.
extension OnEntityChecker on dynamic {
  /// Used to check if the [dynamic] parameter is a [Entity] or no. This check is
  /// based on [RoomType] parameter.
  bool isEntity(RoomType roomType, {int? playlistKey}) {
    if (this == null)
      return throw Exception("[isEntity] - [entity] cannot be null");
    switch (roomType) {
      case RoomType.FAVORITES:
        return this is FavoritesEntity;
      case RoomType.LAST_PLAYED:
        return this is LastPlayedEntity;
      case RoomType.MOST_PLAYED:
        return this is MostPlayedEntity;
      case RoomType.PLAYLIST:
        return this is PlaylistEntity;
      default:
        return this is SongEntity
            ? true
            : throw Exception(
                "[isEntity] - [entity] isn't a instance of Entity\n"
                "Choose one of the existing entities");
    }
  }
}
