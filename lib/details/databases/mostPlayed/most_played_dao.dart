part of on_audio_room;

class _MostPlayedDao {
  Box<MostPlayedEntity> get initMostPlayedDb =>
      Hive.box<MostPlayedEntity>("on_most_played_room");

  Future<int?> addToMostPlayed(MostPlayedEntity entity) async {
    try {
      await initMostPlayedDb.put(entity.key, entity);
      return entity.key;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return null;
  }

  Future<List<int>> addAllToMostPlayed(List<MostPlayedEntity> entities) async {
    List<int> keys = [];
    try {
      await initMostPlayedDb.putAll(entities.formatEntity);
      keys.addAll(entities.getAllKeys);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return keys;
  }

  Future<bool> updateMostPlayed(MostPlayedEntity entity) async {
    if (initMostPlayedDb.containsKey(entity.key)) {
      try {
        await initMostPlayedDb.put(entity.key, entity);
        return true;
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  Future<bool> updateCount(int key, bool automatic, int? newCount) async {
    var tempEntity = initMostPlayedDb.get(key);
    if (tempEntity != null) {
      try {
        var oldCount = tempEntity.playCount;
        tempEntity..playCount = automatic == true ? oldCount + 1 : newCount!;
        print(tempEntity.playCount);
        return await updateMostPlayed(tempEntity);
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  Future<bool> deleteFromMostPlayed(int key) async {
    if (initMostPlayedDb.containsKey(key)) {
      try {
        await initMostPlayedDb.delete(key);
        return true;
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  Future<bool> deleteAllFromMostPlayed(List<int> keys) async {
    try {
      await initMostPlayedDb.deleteAll(keys);
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  Future<bool> clearMostPlayed() async {
    try {
      await initMostPlayedDb.clear();
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  bool checkInMostPlayed(int key) {
    try {
      return initMostPlayedDb.containsKey(key);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  MostPlayedEntity? queryFromMostPlayed(int key) {
    return initMostPlayedDb.get(key);
  }

  List<MostPlayedEntity> queryMostPlayed(int limit, bool reverse) {
    List<MostPlayedEntity> tempMostPlayedList = [];

    if (initMostPlayedDb.isEmpty) return tempMostPlayedList;

    for (var i = 0; i < initMostPlayedDb.length; i++) {
      if (i == limit) break;
      tempMostPlayedList.add(initMostPlayedDb.getAt(i) as MostPlayedEntity);
    }
    return reverse ? tempMostPlayedList.reversed.toList() : tempMostPlayedList;
  }
}
