import 'package:on_audio_room/on_audio_room.dart';

/// A [on_audio_room] extension to help the package.
extension OnEntityChecker on dynamic {
  /// Used to check if the [dynamic] parameter is a [Entity] or no. This check is
  /// based on [RoomType] parameter.
  bool isEntity(RoomType roomType) {
    if (this == null) {
      return throw Exception(
        "[isEntity] - [entity] cannot be null",
      );
    }
    switch (roomType) {
      case RoomType.FAVORITES:
        return this is FavoritesEntity ||
            this[0] != null && this[0] is FavoritesEntity;
      case RoomType.LAST_PLAYED:
        return this is LastPlayedEntity ||
            this[0] != null && this[0] is LastPlayedEntity;
      case RoomType.MOST_PLAYED:
        return this is MostPlayedEntity ||
            this[0] != null && this[0] is MostPlayedEntity;
      case RoomType.PLAYLIST:
        if (this is SongEntity ||
            this is PlaylistEntity ||
            this[0] != null && this[0] is SongEntity ||
            this[0] != null && this[0] is PlaylistEntity) {
          return true;
        }
        return false;
      default:
        return false;
    }
  }
}
