import 'package:on_audio_room/on_audio_room.dart';

/// A [on_audio_room] extension to help the package.
extension OnSongsHelper on List<SongEntity> {
  /// Used to get all [ids] from a list of [SongEntity].
  List<int> get getAllIds {
    List<int> tempKeyList = [];
    this.forEach((entity) {
      tempKeyList.add(entity.id);
    });
    return tempKeyList;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnFavoritesHelper on List<FavoritesEntity> {
  /// Used to get all [keys] from a list of [FavoritesEntity].
  List<int> get getAllKeys {
    List<int> tempKeyList = [];
    this.forEach((entity) {
      tempKeyList.add(entity.key);
    });
    return tempKeyList;
  }

  /// Used to format a list of [FavoritesEntity] into a map.
  Map<dynamic, FavoritesEntity> get formatEntity {
    Map<dynamic, FavoritesEntity> tempMap = {};
    //
    this.forEach((entity) {
      tempMap[entity.key] = entity;
    });
    return tempMap;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnLastPlayedHelper on List<LastPlayedEntity> {
  /// Used to get all [keys] from a list of [LastPlayedEntity].
  List<int> get getAllKeys {
    List<int> tempKeyList = [];
    this.forEach((entity) {
      tempKeyList.add(entity.key);
    });
    return tempKeyList;
  }

  /// Used to format a list of [LastPlayedEntity] into a map.
  Map<dynamic, LastPlayedEntity> get formatEntity {
    Map<dynamic, LastPlayedEntity> tempMap = {};
    //
    this.forEach((entity) {
      tempMap[entity.key] = entity;
    });
    return tempMap;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnMostPlayedHelper on List<MostPlayedEntity> {
  /// Used to get all [keys] from a list of [MostPlayedEntity].
  List<int> get getAllKeys {
    List<int> tempKeyList = [];
    this.forEach((entity) {
      tempKeyList.add(entity.key);
    });
    return tempKeyList;
  }

  /// Used to format a list of [MostPlayedEntity] into a map.
  Map<dynamic, MostPlayedEntity> get formatEntity {
    Map<dynamic, MostPlayedEntity> tempMap = {};
    //
    this.forEach((entity) {
      tempMap[entity.key] = entity;
    });
    return tempMap;
  }
}
