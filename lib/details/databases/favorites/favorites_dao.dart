part of on_audio_room;

class _FavoritesDao {
  Box<FavoritesEntity> get initFavoritesDb =>
      Hive.box<FavoritesEntity>("on_favorites_room");

  Future<int?> addToFavorites(FavoritesEntity entity) async {
    try {
      await initFavoritesDb.put(entity.key, entity);
      return entity.key;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return null;
  }

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

  Future<bool> deleteAllFromFavorites(List<int> keys) async {
    try {
      await initFavoritesDb.deleteAll(keys);
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  Future<bool> clearFavorites() async {
    try {
      await initFavoritesDb.clear();
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  bool checkInFavorites(int key) {
    try {
      return initFavoritesDb.containsKey(key);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  FavoritesEntity? queryFromFavorites(int key) {
    return initFavoritesDb.get(key);
  }

  Future<List<FavoritesEntity>> queryFavorites(int limit, bool reverse) async {
    List<FavoritesEntity> tempFavoritesList = [];

    if (initFavoritesDb.isEmpty) return tempFavoritesList;

    for (var i = 0; i < initFavoritesDb.length; i++) {
      if (i == limit) break;
      tempFavoritesList.add(initFavoritesDb.getAt(i) as FavoritesEntity);
    }
    return reverse ? tempFavoritesList.reversed.toList() : tempFavoritesList;
  }
}
