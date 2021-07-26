import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_room/on_audio_room.dart';

///
extension OnRoom on RoomType {
  Future<bool> get openRoom async {
    //
    Hive.registerAdapter(FavoritesEntityAdapter());
    Hive.registerAdapter(LastPlayedEntityAdapter());
    Hive.registerAdapter(MostPlayedEntityAdapter());
    Hive.registerAdapter(PlaylistEntityAdapter());
    Hive.registerAdapter(SongEntityAdapter());
    switch (this) {
      //
      case RoomType.FAVORITES:
        return await Hive.openBox<FavoritesEntity>(
          "on_favorites_room",
        ).then(
          (value) => value.isOpen,
        );
      //
      case RoomType.LAST_PLAYED:
        return await Hive.openBox<LastPlayedEntity>(
          "on_last_played_room",
        ).then(
          (value) => value.isOpen,
        );
      //
      case RoomType.MOST_PLAYED:
        return await Hive.openBox<MostPlayedEntity>(
          "on_most_played_room",
        ).then(
          (value) => value.isOpen,
        );
      //
      case RoomType.PLAYLIST:
        return await Hive.openBox<PlaylistEntity>(
          "on_playlists_room",
        ).then(
          (value) => value.isOpen,
        );
      //
      default:
        throw "[initOnAudioRoom] - Room don't exist!";
    }
  }

  Box<dynamic> get getBox {
    switch (this) {
      case RoomType.FAVORITES:
        return Hive.box<FavoritesEntity>("on_favorites_room");
      case RoomType.LAST_PLAYED:
        return Hive.box<LastPlayedEntity>("on_last_played_room");
      case RoomType.MOST_PLAYED:
        return Hive.box<MostPlayedEntity>("on_most_played_room");
      case RoomType.FAVORITES:
        return Hive.box<PlaylistEntity>("on_playlists_room");
      default:
        throw "[getRoomInfo] - [roomType] doesn't return a real Room\n"
            "Choose one of the existing Room's";
    }
  }
}
