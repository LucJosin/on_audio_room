part of on_audio_room;

/// A Calculator.
class OnAudioRoom {
  //TODO: Check if is enttiy using room type
  //Room methods

  //Open room
  Future<bool> initRoom([RoomType? roomType, String? subDir]) async {
    await Hive.initFlutter(subDir);
    return roomType == null ? true : await roomType.openRoom;
  }

  ///Close the room
  void closeRoom() => Hive.close();

  //Hive methods
  RoomEntity getRoomInfo(RoomType roomType) {
    Box<dynamic> tempBox = roomType.getBox;
    return RoomEntity()
      ..name = tempBox.name
      ..path = tempBox.path
      ..isEmpty = tempBox.isEmpty
      ..isOpen = tempBox.isOpen
      ..length = tempBox.length
      ..keys = tempBox.keys
      ..values = tempBox.values;
  }

  //Global methods

  ///
  Future<int?> addTo(
    RoomType roomType,
    dynamic entity, {
    int? playlistKey,
  }) async {
    assert(
        OnEntityChecker(entity).isEntity,
        "[addTo] - [entity] isn't a instance of Entity\n"
        "Choose one of the existing entities");
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
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

  ///
  Future<List<int>> addAllTo(
    RoomType roomType,
    List<dynamic> entities, {
    int? playlistKey,
  }) async {
    assert(
        OnEntityChecker(entities).isEntity,
        "[addAllTo] - [entities] isn't a instance of Entity\n"
        "Choose one of the existing entities");
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
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

  Future<bool> updateRoom(RoomType roomType, dynamic entity) async {
    assert(
        OnEntityChecker(entity).isEntity,
        "[updateRoom] - [entity] isn't a instance of Entity\n"
        "Choose one of the existing entities");
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

  ///
  Future<bool> deleteFrom(
    RoomType roomType,
    int entityKey, {
    int? playlistKey,
  }) async {
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
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

  ///
  Future<bool> deleteAllFrom(RoomType roomType, List<int> keys,
      {int? playlistKey}) async {
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
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

  ///
  Future<bool> clearRoom(RoomType roomType, {int? playlistKey}) async {
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
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

  ///
  Future<bool> checkIn(
    RoomType roomType,
    int entityKey, {
    int? playlistKey,
  }) async {
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
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

  ///
  // Future<T> queryFrom<T>(int entityKey) async {
  //   return _FavoritesDao().queryFromFavorites(entityKey) as T;
  // }

  //Query methods

  //Favorites query

  ///
  Future<FavoritesEntity?> queryFromFavorites(int entityKey) async {
    return _FavoritesDao().queryFromFavorites(entityKey);
  }

  ///
  Future<List<FavoritesEntity>> queryFavorites({
    int limit = 50,
    bool reverse = false,
  }) async {
    return await _FavoritesDao().queryFavorites(
      limit,
      reverse,
    );
  }

  //Last Played query

  ///
  Future<LastPlayedEntity?> queryFromLastPlayed(int entityKey) async {
    return _LastPlayedDao().queryFromLastPlayed(entityKey);
  }

  ///
  Future<List<LastPlayedEntity>> queryLastPlayed({
    int limit = 50,
    bool reverse = false,
  }) async {
    return _LastPlayedDao().queryLastPlayed(
      limit,
      reverse,
    );
  }

  //Most Played query

  ///
  Future<MostPlayedEntity?> queryFromMostPlayed(int entityKey) async {
    return _MostPlayedDao().queryFromMostPlayed(entityKey);
  }

  ///
  Future<List<MostPlayedEntity>> queryMostPlayed({
    int limit = 50,
    bool reverse = false,
  }) async {
    return _MostPlayedDao().queryMostPlayed(
      limit,
      reverse,
    );
  }

  ///
  Future<bool> updateCount(int key, {bool automatic = true, int? newCount}) {
    if (automatic == false && newCount == null) return throw "";
    return _MostPlayedDao().updateCount(key, automatic, newCount);
  }

  //Playlist songs query
  ///
  Future<SongEntity?> queryFromPlaylist(int playlistKey, int id) async {
    return _PlaylistDao().queryFromPlaylist(playlistKey, id);
  }

  ///
  Future<List<SongEntity>> queryAllFromPlaylist(
    int playlistKey, {
    int limit = 50,
    bool reverse = false,
  }) async {
    return _PlaylistDao().queryAllFromPlaylist(
      playlistKey,
      limit,
      reverse,
    );
  }

  //Playlist methods

  Future<int?> createPlaylist(String playlistName) async {
    return await _PlaylistDao().createPlaylist(
      OnPlaylistFormatter(playlistName)._toPlaylistEntity,
    );
  }

  Future<bool> deletePlaylist(int key) async {
    return await _PlaylistDao().deletePlaylist(key);
  }

  Future<bool> renamePlaylist(int key, String newName) async {
    return await _PlaylistDao().renamePlaylist(key, newName);
  }

  Future<bool> clearPlaylists() async {
    return await _PlaylistDao().clearPlaylists();
  }

  Future<PlaylistEntity?> queryPlaylist(int key) async {
    return _PlaylistDao().queryPlaylist(key);
  }

  Future<List<PlaylistEntity>> queryPlaylists({
    int limit = 50,
    bool reverse = false,
  }) async {
    return _PlaylistDao().queryPlaylists(limit, reverse);
  }
}
