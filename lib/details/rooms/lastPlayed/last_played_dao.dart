part of on_audio_room;

/// Used to control all methods from [Last Played].
class _LastPlayedDao {
  /// Used to [init] a specific box/room (Last Played).
  Box<dynamic> get initLastPlayedDb =>
      Hive.box<LastPlayedEntity>("on_last_played_room");

  /// addToLastPlayed
  Future<int?> addToLastPlayed(LastPlayedEntity entity) async {
    try {
      await initLastPlayedDb.put(entity.key, entity);
      return entity.key;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return null;
  }

  /// addAllToLastPlayed
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

  /// updateLastPlayed
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

  /// deleteFromLastPlayed
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

  /// deleteAllFromLastPlayed
  Future<bool> deleteAllFromLastPlayed(List<int> keys) async {
    try {
      await initLastPlayedDb.deleteAll(keys);
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// clearLastPlayed
  Future<bool> clearLastPlayed() async {
    try {
      await initLastPlayedDb.clear();
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// checkInLastPlayed
  bool checkInLastPlayed(int key) {
    try {
      return initLastPlayedDb.containsKey(key);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// queryFromLastPlayed
  LastPlayedEntity? queryFromLastPlayed(int key) {
    return initLastPlayedDb.get(key) as LastPlayedEntity;
  }

  /// queryLastPlayed
  List<LastPlayedEntity> queryLastPlayed(
    int limit,
    bool reverse,
    RoomSortType? sortType,
  ) {
    List<LastPlayedEntity> tempLastPlayedList = [];

    if (initLastPlayedDb.isEmpty) return tempLastPlayedList;

    for (var i = 0; i < limit; i++) {
      if (i == limit) break;
      tempLastPlayedList.add(initLastPlayedDb.getAt(i) as LastPlayedEntity);
    }

    switch (sortType) {
      case RoomSortType.ID:
        tempLastPlayedList.sort((a, b) => a.id.compareTo(b.id));
        break;
      case RoomSortType.TITLE:
        tempLastPlayedList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case RoomSortType.DATE_ADDED:
        tempLastPlayedList.sort((a, b) {
          if (a.dateAdded != null && b.dateAdded != null) {
            return a.dateAdded!.compareTo(b.dateAdded!);
          }
          return -1;
        });
        break;
      case RoomSortType.DURATION:
        tempLastPlayedList.sort((a, b) {
          if (a.duration != null && b.duration != null) {
            return a.duration!.compareTo(b.duration!);
          }
          print("-1");
          return -1;
        });
        break;
      default:
    }

    return reverse ? tempLastPlayedList.reversed.toList() : tempLastPlayedList;
  }
}
