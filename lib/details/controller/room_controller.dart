part of on_audio_room;

/// Used to control most of the methods and at the same time clean the main method.
class _RoomController {
  /// Used to reset **ALL** the database.
  Future<bool> clearAllController() async {
    try {
      await Hive.box<FavoritesEntity>("on_favorites_room").clear();
      await Hive.box<LastPlayedEntity>("on_last_played_room").clear();
      await Hive.box<MostPlayedEntity>("on_most_played_room").clear();
      await Hive.box<PlaylistEntity>("on_playlists_room").clear();
      return true;
    } catch (e) {
      print("[on_audio_room]" + e.toString());
    }
    return false;
  }

  /// Used to add a specific song(entity) into a specific [Room].
  Future<int?> addToController(
    RoomType roomType,
    dynamic entity, {
    int? playlistKey,
  }) async {
    switch (roomType) {
      case RoomType.FAVORITES:
        return await _FavoritesDao().addToFavorites(
          entity as FavoritesEntity,
        );
      case RoomType.LAST_PLAYED:
        return await _LastPlayedDao().addToLastPlayed(
          entity as LastPlayedEntity,
        );
      case RoomType.MOST_PLAYED:
        return await _MostPlayedDao().addToMostPlayed(
          entity as MostPlayedEntity,
        );
      case RoomType.PLAYLIST:
        return await _PlaylistDao().addToPlaylist(
          playlistKey!,
          entity as SongEntity,
        );
      default:
        throw Exception("[addTo] - [roomType] doesn't return a real Room\n"
            "Choose one of the existing Room's");
    }
  }

  /// Used to add a list of song(entity) to a specific room.
  Future<List<int>> addAllToController(
    RoomType roomType,
    List<dynamic> entities, {
    int? playlistKey,
  }) async {
    switch (roomType) {
      case RoomType.FAVORITES:
        return await _FavoritesDao().addAllToFavorites(
          entities as List<FavoritesEntity>,
        );
      case RoomType.LAST_PLAYED:
        return await _LastPlayedDao().addAllToLastPlayed(
          entities as List<LastPlayedEntity>,
        );
      case RoomType.MOST_PLAYED:
        return await _MostPlayedDao().addAllToMostPlayed(
          entities as List<MostPlayedEntity>,
        );
      case RoomType.PLAYLIST:
        return await _PlaylistDao().addAllPlaylist(
          playlistKey!,
          entities as List<SongEntity>,
        );
      default:
        throw Exception("[addAllTo] - [roomType] doesn't return a real Room\n"
            "Choose one of the existing Room's");
    }
  }

  /// Used to update a specific [Room].
  Future<bool> updateController(RoomType roomType, dynamic entity) async {
    switch (roomType) {
      case RoomType.FAVORITES:
        return await _FavoritesDao().updateFavorites(
          entity as FavoritesEntity,
        );
      case RoomType.LAST_PLAYED:
        return await _LastPlayedDao().updateLastPlayed(
          entity as LastPlayedEntity,
        );
      case RoomType.MOST_PLAYED:
        return await _MostPlayedDao().updateMostPlayed(
          entity as MostPlayedEntity,
        );
      case RoomType.PLAYLIST:
        return await _PlaylistDao().updatePlaylist(
          entity as PlaylistEntity,
        );
      default:
        throw Exception("[updateRoom] - [roomType] doesn't return a real Room\n"
            "Choose one of the existing Room's");
    }
  }

  /// Used to delete a specific song(entity) from a specific room.
  Future<bool> deleteFromController(
    RoomType roomType,
    int entityKey, {
    int? playlistKey,
  }) async {
    switch (roomType) {
      case RoomType.FAVORITES:
        return await _FavoritesDao().deleteFromFavorites(entityKey);
      case RoomType.LAST_PLAYED:
        return await _LastPlayedDao().deleteFromLastPlayed(entityKey);
      case RoomType.MOST_PLAYED:
        return await _MostPlayedDao().deleteFromMostPlayed(entityKey);
      case RoomType.PLAYLIST:
        return await _PlaylistDao().deleteFromPlaylist(playlistKey!, entityKey);
      default:
        throw Exception("[deleteFrom] - [roomType] doesn't return a real Room\n"
            "Choose one of the existing Room's");
    }
  }

  /// Used to delete all defined entities from a specific room.
  Future<bool> deleteAllFromController(
    RoomType roomType,
    List<int> keys, {
    int? playlistKey,
  }) async {
    switch (roomType) {
      case RoomType.FAVORITES:
        return await _FavoritesDao().deleteAllFromFavorites(keys);
      case RoomType.LAST_PLAYED:
        return await _LastPlayedDao().deleteAllFromLastPlayed(keys);
      case RoomType.MOST_PLAYED:
        return await _MostPlayedDao().deleteAllFromMostPlayed(keys);
      case RoomType.PLAYLIST:
        return await _PlaylistDao().deleteAllFromPlaylist(playlistKey!, keys);
      default:
        throw Exception(
            "[deleteAllFrom] - [roomType] doesn't return a real Room\n"
            "Choose one of the existing Room's");
    }
  }

  /// Used to delete **ALL** the entities from a specific room.
  Future<bool> clearController(RoomType roomType, {int? playlistKey}) async {
    switch (roomType) {
      case RoomType.FAVORITES:
        return await _FavoritesDao().clearFavorites();
      case RoomType.LAST_PLAYED:
        return await _LastPlayedDao().clearLastPlayed();
      case RoomType.MOST_PLAYED:
        return await _MostPlayedDao().clearMostPlayed();
      case RoomType.PLAYLIST:
        return await _PlaylistDao().clearPlaylist(playlistKey!);
      default:
        throw Exception("[clearRoom] - [roomType] doesn't return a real Room\n"
            "Choose one of the existing Room's");
    }
  }

  /// Used to check if a song(entity) was added to a specific room.
  Future<bool> checkController(
    RoomType roomType,
    int entityKey, {
    int? playlistKey,
  }) async {
    switch (roomType) {
      case RoomType.FAVORITES:
        return _FavoritesDao().checkInFavorites(entityKey);
      case RoomType.LAST_PLAYED:
        return _LastPlayedDao().checkInLastPlayed(entityKey);
      case RoomType.MOST_PLAYED:
        return _MostPlayedDao().checkInMostPlayed(entityKey);
      case RoomType.PLAYLIST:
        return _PlaylistDao().checkInPlaylist(playlistKey!, entityKey);
      default:
        throw Exception("[checkIn] - [roomType] doesn't return a real Room\n"
            "Choose one of the existing Room's");
    }
  }
}
