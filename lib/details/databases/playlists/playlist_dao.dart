part of on_audio_room;

class _PlaylistDao {
  Box<PlaylistEntity> get initPlaylistDb =>
      Hive.box<PlaylistEntity>("on_playlists_room");

  //Playlist methods

  ///
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

  ///
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

  ///
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

  Future<bool> clearPlaylists() async {
    try {
      await initPlaylistDb.clear();
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  ///
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

  PlaylistEntity? queryPlaylist(int key) {
    return initPlaylistDb.get(key);
  }

  ///
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

  ///
  Future<int?> addToPlaylist(int playlistKey, SongEntity entity) async {
    if (initPlaylistDb.containsKey(playlistKey)) {
      try {
        var tempEntity = initPlaylistDb.get(playlistKey)!;
        tempEntity
          ..playlistDateModified = DateTime.now().millisecondsSinceEpoch;
        tempEntity.playlistSongs.add(entity);
        return entity.id;
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return null;
  }

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

  SongEntity? queryFromPlaylist(int playlistKey, int id) {
    var tempEntity = initPlaylistDb.get(playlistKey)!.playlistSongs;
    return tempEntity.firstWhere((element) => element.id == id);
  }

  Future<List<SongEntity>> queryAllFromPlaylist(
    int playlistKey,
    int limit,
    bool reverse,
  ) async {
    var tempEntity = initPlaylistDb.get(playlistKey)!.playlistSongs;
    List<SongEntity> tempSongsList = [];

    if (tempEntity.isEmpty) return tempSongsList;

    for (var i = 0; i < tempEntity.length; i++) {
      if (i == limit) break;
      tempSongsList.add(tempEntity[i]);
    }
    return reverse ? tempSongsList.reversed.toList() : tempSongsList;
  }
}
