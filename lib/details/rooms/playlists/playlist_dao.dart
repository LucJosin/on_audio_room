// ignore_for_file: avoid_print

part of on_audio_room;

class _PlaylistDao {
  Box<PlaylistEntity> get initPlaylistDb =>
      Hive.box<PlaylistEntity>("on_playlists_room");

  //Playlist methods

  /// [createPlaylist]
  Future<int?> createPlaylist(
    PlaylistEntity entity,
    bool ignoreDuplicate,
  ) async {
    // This will check if already exist a playlist with the same name.
    if (!ignoreDuplicate) {
      var tmpEntities = initPlaylistDb.values.toList();
      for (int i = 0; i < initPlaylistDb.length; i++) {
        // The name in lowercase to make it more accurate.
        String indexEntity = tmpEntities[i].playlistName.toLowerCase();
        String currentEntity = entity.playlistName.toLowerCase();

        //
        if (indexEntity == currentEntity) return 0;
      }
    }

    //
    try {
      entity
        ..playlistDateAdded = DateTime.now().millisecondsSinceEpoch
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
        return await initPlaylistDb.delete(key).then((_) => true);
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
        entity.playlistDateModified = DateTime.now().millisecondsSinceEpoch;
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
  Future<int?> addToPlaylist(
    int playlistKey,
    SongEntity entity,
    bool ignoreDuplicate,
  ) async {
    // This will check if already exist a song with the same id.
    if (!ignoreDuplicate) {
      var songsInPlaylist = initPlaylistDb.get(playlistKey)!.playlistSongs;
      for (var song in songsInPlaylist) {
        if (song.id == entity.id) return 0;
      }
    }
    //
    if (initPlaylistDb.containsKey(playlistKey)) {
      try {
        PlaylistEntity tmpEntity = initPlaylistDb.get(playlistKey)!;
        tmpEntity.playlistDateModified = DateTime.now().millisecondsSinceEpoch;
        tmpEntity.playlistSongs.add(entity);
        await updatePlaylist(tmpEntity);
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
      PlaylistEntity tmpEntity = initPlaylistDb.get(playlistKey)!;
      tmpEntity.playlistDateModified = DateTime.now().millisecondsSinceEpoch;
      tmpEntity.playlistSongs.addAll(entities);
      ids.addAll(entities.getAllIds);
      await updatePlaylist(tmpEntity);
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
        PlaylistEntity tmpPEntity = initPlaylistDb.get(playlistKey)!;
        int tmpSIndex = tmpPEntity.playlistSongs.indexWhere(
          (currentEntity) => currentEntity.id == entity.id,
        );

        // Replace the specific entity.
        tmpPEntity.playlistSongs[tmpSIndex] = entity;
        return await updatePlaylist(tmpPEntity);
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
        PlaylistEntity tmpEntity = initPlaylistDb.get(playlistKey)!;
        tmpEntity.playlistDateModified = DateTime.now().millisecondsSinceEpoch;
        tmpEntity.playlistSongs.removeWhere((element) => element.id == id);
        return await updatePlaylist(tmpEntity);
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  /// [deleteAllFromPlaylist]
  Future<bool> deleteAllFromPlaylist(int playlistKey, List<int> ids) async {
    try {
      for (int id = 0; id < ids.length; id++) {
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
      PlaylistEntity tmpEntity = initPlaylistDb.get(playlistKey)!;
      tmpEntity.playlistDateModified = DateTime.now().millisecondsSinceEpoch;
      tmpEntity.playlistSongs.clear();
      return await updatePlaylist(tmpEntity);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// [checkInPlaylist]
  bool checkInPlaylist(int playlistKey, int entityKey) {
    if (initPlaylistDb.containsKey(playlistKey)) {
      try {
        var tmpEntity = initPlaylistDb.get(playlistKey)!.playlistSongs;
        for (var entity in tmpEntity) {
          if (entity.id == entityKey) return true;
        }
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
    var tmpEntity = initPlaylistDb.get(playlistKey)!.playlistSongs;
    return tmpEntity.firstWhere((element) => element.id == id);
  }

  /// [queryAllFromPlaylist]
  Future<List<SongEntity>> queryAllFromPlaylist(
    int playlistKey,
    int limit,
    bool reverse,
    RoomSortType? sortType,
  ) async {
    var tmpEntity = initPlaylistDb.get(playlistKey)!.playlistSongs;
    List<SongEntity> tempSongsList = [];

    if (tmpEntity.isEmpty) return tempSongsList;

    for (var i = 0; i < tmpEntity.length; i++) {
      if (i == limit) break;
      tempSongsList.add(tmpEntity[i]);
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
