// ignore_for_file: avoid_print

part of on_audio_room;

/// Used to control all methods from [Most Played].
class _MostPlayedDao {
  /// Used to [init] a specific box/room (Most Played).
  Box<MostPlayedEntity> get initMostPlayedDb =>
      Hive.box<MostPlayedEntity>("on_most_played_room");

  /// addToMostPlayed
  Future<int?> addToMostPlayed(
    MostPlayedEntity entity,
    bool ignoreDuplicate,
  ) async {
    // This will check if already exist a song with the same id.
    if (!ignoreDuplicate) {
      for (var i = 0; i < initMostPlayedDb.length; i++) {
        if (initMostPlayedDb.get(i)?.id == entity.id) return 0;
      }
    }
    //
    try {
      await initMostPlayedDb.put(entity.key, entity);
      return entity.key;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return null;
  }

  /// addAllToMostPlayed
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

  /// updateMostPlayed
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

  /// updateCount
  Future<bool> updateCount(int key, bool automatic, int? newCount) async {
    var tempEntity = initMostPlayedDb.get(key);
    if (tempEntity != null) {
      try {
        var oldCount = tempEntity.playCount;
        tempEntity.playCount = automatic == true ? oldCount + 1 : newCount!;
        print(tempEntity.playCount);
        return await updateMostPlayed(tempEntity);
      } catch (e) {
        print("[on_audio_error]" + e.toString());
      }
    }
    return false;
  }

  /// deleteFromMostPlayed
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

  /// deleteAllFromMostPlayed
  Future<bool> deleteAllFromMostPlayed(List<int> keys) async {
    try {
      await initMostPlayedDb.deleteAll(keys);
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// clearMostPlayed
  Future<bool> clearMostPlayed() async {
    try {
      await initMostPlayedDb.clear();
      return true;
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// checkInMostPlayed
  bool checkInMostPlayed(int key) {
    try {
      return initMostPlayedDb.containsKey(key);
    } catch (e) {
      print("[on_audio_error]" + e.toString());
    }
    return false;
  }

  /// queryFromMostPlayed
  MostPlayedEntity? queryFromMostPlayed(int key) {
    return initMostPlayedDb.get(key);
  }

  /// queryMostPlayed
  List<MostPlayedEntity> queryMostPlayed(
    int limit,
    bool reverse,
    RoomSortType? sortType,
  ) {
    List<MostPlayedEntity> tempMostPlayedList = [];

    if (initMostPlayedDb.isEmpty) return tempMostPlayedList;

    for (var i = 0; i < initMostPlayedDb.length; i++) {
      if (i == limit) break;
      tempMostPlayedList.add(initMostPlayedDb.getAt(i) as MostPlayedEntity);
    }

    switch (sortType) {
      case RoomSortType.ID:
        tempMostPlayedList.sort((a, b) => a.id.compareTo(b.id));
        break;
      case RoomSortType.TITLE:
        tempMostPlayedList.sort((a, b) => a.title.compareTo(b.title));
        break;
      case RoomSortType.DATE_ADDED:
        tempMostPlayedList.sort((a, b) {
          if (a.dateAdded != null && b.dateAdded != null) {
            return a.dateAdded!.compareTo(b.dateAdded!);
          }
          return -1;
        });
        break;
      case RoomSortType.DURATION:
        tempMostPlayedList.sort((a, b) {
          if (a.duration != null && b.duration != null) {
            return a.duration!.compareTo(b.duration!);
          }
          print("-1");
          return -1;
        });
        break;
      default:
    }

    return reverse ? tempMostPlayedList.reversed.toList() : tempMostPlayedList;
  }
}
