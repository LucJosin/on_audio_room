import 'package:on_audio_room/on_audio_room.dart';

extension OnSongsHelper on List<SongEntity> {
  List<int> get getAllIds {
    List<int> tempKeyList = [];
    this.forEach((entity) {
      tempKeyList.add(entity.id);
    });
    return tempKeyList;
  }
}

extension OnFavoritesHelper on List<FavoritesEntity> {
  List<int> get getAllKeys {
    List<int> tempKeyList = [];
    this.forEach((entity) {
      tempKeyList.add(entity.key);
    });
    return tempKeyList;
  }

  Map<dynamic, FavoritesEntity> get formatEntity {
    Map<dynamic, FavoritesEntity> tempMap = {};
    //
    this.forEach((entity) {
      tempMap[entity.key] = entity;
    });
    return tempMap;
  }
}

extension OnLastPlayedHelper on List<LastPlayedEntity> {
  List<int> get getAllKeys {
    List<int> tempKeyList = [];
    this.forEach((entity) {
      tempKeyList.add(entity.key);
    });
    return tempKeyList;
  }

  Map<dynamic, LastPlayedEntity> get formatEntity {
    Map<dynamic, LastPlayedEntity> tempMap = {};
    //
    this.forEach((entity) {
      tempMap[entity.key] = entity;
    });
    return tempMap;
  }
}

extension OnMostPlayedHelper on List<MostPlayedEntity> {
  List<int> get getAllKeys {
    List<int> tempKeyList = [];
    this.forEach((entity) {
      tempKeyList.add(entity.key);
    });
    return tempKeyList;
  }

  Map<dynamic, MostPlayedEntity> get formatEntity {
    Map<dynamic, MostPlayedEntity> tempMap = {};
    //
    this.forEach((entity) {
      tempMap[entity.key] = entity;
    });
    return tempMap;
  }
}
