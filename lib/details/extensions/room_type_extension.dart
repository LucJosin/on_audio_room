import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_room/on_audio_room.dart';

/// A [on_audio_room] extension to help the package.
extension OnRoom on RoomType {
  /// Used to init all the adapters, and open the necessary room.
  ///
  /// Important:
  ///
  /// * Avoid opening multiple room's at the same time.
  ///
  /// Return:
  ///
  /// * [openRoom] will **ALWAYS** return a [bool]:
  ///   * [true] if the room/path is opened
  ///   * [false] if something wrong happend.
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

  /// Used to get all the box/room information from a specific [RoomType].
  Box<dynamic> get getBox {
    switch (this) {
      case RoomType.FAVORITES:
        return Hive.box<FavoritesEntity>("on_favorites_room");
      case RoomType.LAST_PLAYED:
        return Hive.box<LastPlayedEntity>("on_last_played_room");
      case RoomType.MOST_PLAYED:
        return Hive.box<MostPlayedEntity>("on_most_played_room");
      case RoomType.PLAYLIST:
        return Hive.box<PlaylistEntity>("on_playlists_room");
      default:
        throw "[getRoomInfo] - [roomType] doesn't return a real Room\n"
            "Choose one of the existing Room's";
    }
  }
}
