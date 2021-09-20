import 'package:on_audio_room/on_audio_room.dart';

/// A [on_audio_room] extension to help the package.
extension OnSongsListHelper on List<SongEntity> {
  /// Used to get all [ids] from a list of [SongEntity].
  List<int> get getAllIds {
    List<int> tempKeyList = [];
    for (var entity in this) {
      tempKeyList.add(entity.id);
    }
    return tempKeyList;
  }

  /// A helper to get a list of [SongEntity] as a [Map].
  List<Map> get getListOfMap {
    List<Map> tempList = [];

    for (var entity in this) {
      tempList.add(entity.getMap);
    }

    return tempList;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnSongsHelper on SongEntity {
  /// A helper to get the [SongEntity] as a [Map].
  Map get getMap {
    Map tempKeyMap = {
      "_data": lastData,
      "_display_name": displayName,
      "_id": id,
      "album": album,
      "album_id": albumId,
      "artist": artist,
      "artist_id": artistId,
      "date_added": dateAdded,
      "duration": duration,
      "title": title,
      "artwork": artworkAsBytes,
    };
    return tempKeyMap;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnFavoritesListHelper on List<FavoritesEntity> {
  /// Used to get all [keys] from a list of [FavoritesEntity].
  List<int> get getAllKeys {
    List<int> tempKeyList = [];
    for (var entity in this) {
      tempKeyList.add(entity.key);
    }
    return tempKeyList;
  }

  /// Used to format a list of [FavoritesEntity] into a map.
  Map<dynamic, FavoritesEntity> get formatEntity {
    Map<dynamic, FavoritesEntity> tempMap = {};
    //
    for (var entity in this) {
      tempMap[entity.key] = entity;
    }
    return tempMap;
  }

  /// A helper to get a list of [FavoritesEntity] as a [Map].
  List<Map> get getListOfMap {
    List<Map> tempList = [];

    for (var entity in this) {
      tempList.add(entity.getMap);
    }

    return tempList;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnFavoritesHelper on FavoritesEntity {
  /// A helper to get the [FavoritesEntity] as a [Map].
  Map get getMap {
    Map tempKeyMap = {
      "_data": lastData,
      "_display_name": displayName,
      "_id": id,
      "album": album,
      "album_id": albumId,
      "artist": artist,
      "artist_id": artistId,
      "date_added": dateAdded,
      "duration": duration,
      "title": title,
      "artwork": artworkAsBytes,
    };
    return tempKeyMap;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnLastPlayedListHelper on List<LastPlayedEntity> {
  /// Used to get all [keys] from a list of [LastPlayedEntity].
  List<int> get getAllKeys {
    List<int> tempKeyList = [];
    for (var entity in this) {
      tempKeyList.add(entity.key);
    }
    return tempKeyList;
  }

  /// Used to format a list of [LastPlayedEntity] into a map.
  Map<dynamic, LastPlayedEntity> get formatEntity {
    Map<dynamic, LastPlayedEntity> tempMap = {};
    //
    for (var entity in this) {
      tempMap[entity.key] = entity;
    }
    return tempMap;
  }

  /// A helper to get a list of [LastPlayedEntity] as a [Map].
  List<Map> get getListOfMap {
    List<Map> tempList = [];

    for (var entity in this) {
      tempList.add(entity.getMap);
    }

    return tempList;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnLastPlayedHelper on LastPlayedEntity {
  /// A helper to get the [LastPlayedEntity] as a [Map].
  Map get getMap {
    Map tempKeyMap = {
      "_data": lastData,
      "_display_name": displayName,
      "_id": id,
      "album": album,
      "album_id": albumId,
      "artist": artist,
      "artist_id": artistId,
      "date_added": dateAdded,
      "duration": duration,
      "title": title,
      "artwork": artworkAsBytes,
    };
    return tempKeyMap;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnMostPlayedListHelper on List<MostPlayedEntity> {
  /// Used to get all [keys] from a list of [MostPlayedEntity].
  List<int> get getAllKeys {
    List<int> tempKeyList = [];
    for (var entity in this) {
      tempKeyList.add(entity.key);
    }
    return tempKeyList;
  }

  /// Used to format a list of [MostPlayedEntity] into a map.
  Map<dynamic, MostPlayedEntity> get formatEntity {
    Map<dynamic, MostPlayedEntity> tempMap = {};
    //
    for (var entity in this) {
      tempMap[entity.key] = entity;
    }
    return tempMap;
  }

  /// A helper to get a list of [MostPlayedEntity] as a [Map].
  List<Map> get getListOfMap {
    List<Map> tempList = [];

    for (var entity in this) {
      tempList.add(entity.getMap);
    }

    return tempList;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnMostPlayedHelper on MostPlayedEntity {
  /// A helper to get the [MostPlayedEntity] as a [Map].
  Map get getMap {
    Map tempKeyMap = {
      "_data": lastData,
      "_display_name": displayName,
      "_id": id,
      "album": album,
      "album_id": albumId,
      "artist": artist,
      "artist_id": artistId,
      "date_added": dateAdded,
      "duration": duration,
      "title": title,
      "artwork": artworkAsBytes,
    };
    return tempKeyMap;
  }
}
