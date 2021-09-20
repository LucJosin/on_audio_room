// ignore_for_file: avoid_print

part of on_audio_room;

/// Used to control all methods from [Favorites].
class _FavoritesDao {
  /// Used to [init] a specific box/room (Favorites).
  Box<FavoritesEntity> get initFavoritesDb =>
      Hive.box<FavoritesEntity>("on_favorites_room");

  /// addToFavorites
  Future<int?> addToFavorites(
    FavoritesEntity entity,
    bool ignoreDuplicate,
  ) async {
    // This will check if already exist a song with the same id.
    if (!ignoreDuplicate) {
      for (var i = 0; i < initFavoritesDb.length; i++) {
        if (initFavoritesDb.get(i)?.id == entity.id) return 0;
      }
    }
    //
    try {
      await initFavoritesDb.put(entity.key, entity);
      return entity.key;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return null;
  }

  /// addAllToFavorites
  Future<List<int>> addAllToFavorites(List<FavoritesEntity> entities) async {
    List<int> keys = [];
    try {
      await initFavoritesDb.putAll(entities.formatEntity);
      keys.addAll(entities.getAllKeys);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return keys;
  }

  /// updateFavorites
  Future<bool> updateFavorites(FavoritesEntity entity) async {
    if (initFavoritesDb.containsKey(entity.key)) {
      try {
        await initFavoritesDb.put(entity.key, entity);
        return true;
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  /// deleteFromFavorites
  Future<bool> deleteFromFavorites(int key) async {
    if (initFavoritesDb.containsKey(key)) {
      try {
        await initFavoritesDb.delete(key);
        return true;
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  /// deleteAllFromFavorites
  Future<bool> deleteAllFromFavorites(List<int> keys) async {
    try {
      await initFavoritesDb.deleteAll(keys);
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// clearFavorites
  Future<bool> clearFavorites() async {
    try {
      await initFavoritesDb.clear();
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// checkInFavorites
  bool checkInFavorites(int key) {
    try {
      return initFavoritesDb.containsKey(key);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// queryFromFavorites
  FavoritesEntity? queryFromFavorites(int key) {
    return initFavoritesDb.get(key);
  }

  /// queryFavorites
  Future<List<FavoritesEntity>> queryFavorites(
    int limit,
    bool reverse,
    RoomSortType? sortType,
  ) async {
    List<FavoritesEntity> tempFavoritesList = [];

    if (initFavoritesDb.isEmpty) return tempFavoritesList;

    for (var i = 0; i < initFavoritesDb.length; i++) {
      if (i == limit) break;
      tempFavoritesList.add(initFavoritesDb.getAt(i) as FavoritesEntity);
    }

    switch (sortType) {
      case RoomSortType.ID:
        tempFavoritesList.sort((a, b) => a.id.compareTo(b.id));
        break;
      case RoomSortType.TITLE:
        tempFavoritesList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case RoomSortType.DATE_ADDED:
        tempFavoritesList.sort((a, b) {
          if (a.dateAdded != null && b.dateAdded != null) {
            return a.dateAdded!.compareTo(b.dateAdded!);
          }
          return -1;
        });
        break;
      case RoomSortType.DURATION:
        tempFavoritesList.sort((a, b) {
          if (a.duration != null && b.duration != null) {
            return a.duration!.compareTo(b.duration!);
          }
          print("-1");
          return -1;
        });
        break;
      default:
    }

    return reverse ? tempFavoritesList.reversed.toList() : tempFavoritesList;
  }
}
