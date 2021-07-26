part of on_audio_room;

class _LastPlayedDao {
  Box<dynamic> get initLastPlayedDb =>
      Hive.box<LastPlayedEntity>("on_last_played_room");

  Future<int?> addToLastPlayed(LastPlayedEntity entity) async {
    try {
      await initLastPlayedDb.put(entity.key, entity);
      return entity.key;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return null;
  }

  Future<List<int>> addAllToLastPlayed(List<LastPlayedEntity> entities) async {
    List<int> keys = [];
    try {
      await initLastPlayedDb.putAll(entities.formatEntity);
      keys.addAll(entities.getAllKeys);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return keys;
  }

  Future<bool> updateLastPlayed(LastPlayedEntity entity) async {
    if (initLastPlayedDb.containsKey(entity.key)) {
      try {
        await initLastPlayedDb.put(entity.key, entity);
        return true;
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  Future<bool> deleteFromLastPlayed(int key) async {
    if (initLastPlayedDb.containsKey(key)) {
      try {
        await initLastPlayedDb.delete(key);
        return true;
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  Future<bool> deleteAllFromLastPlayed(List<int> keys) async {
    try {
      await initLastPlayedDb.deleteAll(keys);
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  Future<bool> clearLastPlayed() async {
    try {
      await initLastPlayedDb.clear();
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  bool checkInLastPlayed(int key) {
    try {
      return initLastPlayedDb.containsKey(key);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  LastPlayedEntity? queryFromLastPlayed(int key) {
    return initLastPlayedDb.get(key) as LastPlayedEntity;
  }

  List<LastPlayedEntity> queryLastPlayed(int limit, bool reverse) {
    List<LastPlayedEntity> tempLastPlayedList = [];

    if (initLastPlayedDb.isEmpty) return tempLastPlayedList;

    for (var i = 0; i < limit; i++) {
      if (i == limit) break;
      tempLastPlayedList.add(initLastPlayedDb.getAt(i) as LastPlayedEntity);
    }
    return reverse ? tempLastPlayedList.reversed.toList() : tempLastPlayedList;
  }
}
