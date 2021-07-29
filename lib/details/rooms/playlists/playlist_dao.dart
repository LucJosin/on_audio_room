part of on_audio_room;

class _PlaylistDao {
  Box<PlaylistEntity> get initPlaylistDb =>
      Hive.box<PlaylistEntity>("on_playlists_room");

  //Playlist methods

  /// [createPlaylist]
  Future<int?> createPlaylist(PlaylistEntity entity) async {
    try {
      entity
        ..playlistDataAdded = DateTime.now().millisecondsSinceEpoch
        ..playlistDateModified = DateTime.now().millisecondsSinceEpoch;
      await initPlaylistDb.put(entity.key, entity);
      return entity.key;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return null;
  }

  /// [deletePlaylist]
  Future<bool> deletePlaylist(int key) async {
    if (initPlaylistDb.containsKey(key)) {
      try {
        return await initPlaylistDb.delete(key).then((value) => true);
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  /// [renamePlaylist]
  Future<bool> renamePlaylist(int key, String newName) async {
    if (initPlaylistDb.containsKey(key)) {
      try {
        var tempEntity = initPlaylistDb.get(key)!
          ..playlistName = newName
          ..playlistDateModified = DateTime.now().millisecondsSinceEpoch;
        return updatePlaylist(tempEntity);
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  /// [clearPlaylists]
  Future<bool> clearPlaylists() async {
    try {
      await initPlaylistDb.clear();
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// [updatePlaylist]
  Future<bool> updatePlaylist(PlaylistEntity entity) async {
    if (initPlaylistDb.containsKey(entity.key)) {
      try {
        entity..playlistDateModified = DateTime.now().millisecondsSinceEpoch;
        await initPlaylistDb.put(entity.key, entity);
        return true;
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  /// [queryPlaylist]
  PlaylistEntity? queryPlaylist(int key) {
    return initPlaylistDb.get(key);
  }

  /// [queryPlaylists]
  List<PlaylistEntity> queryPlaylists(int limit, bool reverse) {
    List<PlaylistEntity> tempPlaylistList = [];

    if (initPlaylistDb.isEmpty) return tempPlaylistList;

    for (var i = 0; i < initPlaylistDb.length; i++) {
      if (i == limit) break;
      tempPlaylistList.add(initPlaylistDb.getAt(i) as PlaylistEntity);
    }
    return reverse ? tempPlaylistList.reversed.toList() : tempPlaylistList;
  }

  //Playlist songs methods

  /// [addToPlaylist]
  Future<int?> addToPlaylist(int playlistKey, SongEntity entity) async {
    if (initPlaylistDb.containsKey(playlistKey)) {
      try {
        var tempEntity = initPlaylistDb.get(playlistKey)!;
        tempEntity
          ..playlistDateModified = DateTime.now().millisecondsSinceEpoch;
        tempEntity.playlistSongs.add(entity);
        updatePlaylist(tempEntity);
        return entity.id;
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return null;
  }

  /// [addAllPlaylist]
  Future<List<int>> addAllPlaylist(
    int playlistKey,
    List<SongEntity> entities,
  ) async {
    List<int> ids = [];
    try {
      var tempEntity = initPlaylistDb.get(playlistKey)!;
      tempEntity..playlistDateModified = DateTime.now().millisecondsSinceEpoch;
      tempEntity.playlistSongs.addAll(entities);
      ids.addAll(entities.getAllIds);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return ids;
  }

  /// [updateSongFromPlaylist]
  Future<bool> updateSongFromPlaylist(
    int playlistKey,
    SongEntity entity,
  ) async {
    if (initPlaylistDb.containsKey(playlistKey)) {
      try {
        //TODO Check if works
        var tempEntity = initPlaylistDb.get(playlistKey);
        var tempSongEntity = tempEntity!.playlistSongs
            .firstWhere((element) => element.id == entity.id);
        print("Playlist before: " + tempSongEntity.toString());
        tempSongEntity = entity;
        print("Playlist after: " + tempSongEntity.toString());
        return updatePlaylist(tempEntity);
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  /// [deleteFromPlaylist]
  Future<bool> deleteFromPlaylist(int playlistKey, int id) async {
    if (initPlaylistDb.containsKey(playlistKey)) {
      try {
        var tempEntity = initPlaylistDb.get(playlistKey)!;
        tempEntity
          ..playlistDateModified = DateTime.now().millisecondsSinceEpoch;
        tempEntity.playlistSongs.removeWhere((element) => element.id == id);
        return true;
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  /// [deleteAllFromPlaylist]
  Future<bool> deleteAllFromPlaylist(int playlistKey, List<int> ids) async {
    try {
      for (var id = 0; id < ids.length; id++) {
        await deleteFromPlaylist(playlistKey, id);
      }
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// [clearPlaylist]
  Future<bool> clearPlaylist(int playlistKey) async {
    try {
      var tempEntity = initPlaylistDb.get(playlistKey)!;
      tempEntity..playlistDateModified = DateTime.now().millisecondsSinceEpoch;
      tempEntity.playlistSongs.clear();
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// [checkInPlaylist]
  bool checkInPlaylist(int playlistKey, int id) {
    if (initPlaylistDb.containsKey(playlistKey)) {
      try {
        //TODO: Check if works
        var tempEntity = initPlaylistDb.get(playlistKey)!.playlistSongs;
        return tempEntity.contains(id);
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  /// [queryFromPlaylist]
  SongEntity? queryFromPlaylist(
    int playlistKey,
    int id,
  ) {
    var tempEntity = initPlaylistDb.get(playlistKey)!.playlistSongs;
    return tempEntity.firstWhere((element) => element.id == id);
  }

  /// [queryAllFromPlaylist]
  Future<List<SongEntity>> queryAllFromPlaylist(
    int playlistKey,
    int limit,
    bool reverse,
    RoomSortType? sortType,
  ) async {
    var tempEntity = initPlaylistDb.get(playlistKey)!.playlistSongs;
    List<SongEntity> tempSongsList = [];

    if (tempEntity.isEmpty) return tempSongsList;

    for (var i = 0; i < tempEntity.length; i++) {
      if (i == limit) break;
      tempSongsList.add(tempEntity[i]);
    }

    switch (sortType) {
      case RoomSortType.ID:
        tempSongsList.sort((a, b) => a.id.compareTo(b.id));
        break;
      case RoomSortType.TITLE:
        tempSongsList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case RoomSortType.DATE_ADDED:
        tempSongsList.sort((a, b) {
          if (a.dateAdded != null && b.dateAdded != null) {
            return a.dateAdded!.compareTo(b.dateAdded!);
          }
          return -1;
        });
        break;
      case RoomSortType.DURATION:
        tempSongsList.sort((a, b) {
          if (a.duration != null && b.duration != null) {
            return a.duration!.compareTo(b.duration!);
          }
          print("-1");
          return -1;
        });
        break;
      default:
    }

    return reverse ? tempSongsList.reversed.toList() : tempSongsList;
  }
}
