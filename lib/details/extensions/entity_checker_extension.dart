import 'package:on_audio_room/on_audio_room.dart';

///a
extension OnEntityChecker on dynamic {
  bool get isEntity {
    return (this is SongEntity ||
        this is FavoritesEntity ||
        this is LastPlayedEntity ||
        this is MostPlayedEntity ||
        this is PlaylistEntity);
  }
}
