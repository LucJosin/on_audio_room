import 'package:on_audio_room/on_audio_room.dart';

/// A [on_audio_room] extension to help the package.
extension OnSongsListHelper on List<SongEntity> {
  /// Used to get all [ids] from a list of [SongEntity].
  List<int> get getAllIds {
    List<int> tempKeyList = [];
    this.forEach((entity) {
      tempKeyList.add(entity.id);
    });
    return tempKeyList;
  }

  /// A helper to get a list of [SongEntity] as a [Map].
  List<Map> get getListOfMap {
    List<Map> tempList = [];

    this.forEach((entity) {
      tempList.add(entity.getMap);
    });

    return tempList;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnSongsHelper on SongEntity {
  /// A helper to get the [SongEntity] as a [Map].
  Map get getMap {
    Map tempKeyMap = {
      "_data": this.lastData,
      "_display_name": this.displayName,
      "_id": this.id,
      "album": this.album,
      "album_id": this.albumId,
      "artist": this.artist,
      "artist_id": this.artistId,
      "date_added": this.dateAdded,
      "duration": this.duration,
      "title": this.title,
      "artwork": this.artworkAsBytes,
    };
    return tempKeyMap;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnFavoritesListHelper on List<FavoritesEntity> {
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

  /// A helper to get a list of [FavoritesEntity] as a [Map].
  List<Map> get getListOfMap {
    List<Map> tempList = [];

    this.forEach((entity) {
      tempList.add(entity.getMap);
    });

    return tempList;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnFavoritesHelper on FavoritesEntity {
  /// A helper to get the [FavoritesEntity] as a [Map].
  Map get getMap {
    Map tempKeyMap = {
      "_data": this.lastData,
      "_display_name": this.displayName,
      "_id": this.id,
      "album": this.album,
      "album_id": this.albumId,
      "artist": this.artist,
      "artist_id": this.artistId,
      "date_added": this.dateAdded,
      "duration": this.duration,
      "title": this.title,
      "artwork": this.artworkAsBytes,
    };
    return tempKeyMap;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnLastPlayedListHelper on List<LastPlayedEntity> {
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

  /// A helper to get a list of [LastPlayedEntity] as a [Map].
  List<Map> get getListOfMap {
    List<Map> tempList = [];

    this.forEach((entity) {
      tempList.add(entity.getMap);
    });

    return tempList;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnLastPlayedHelper on LastPlayedEntity {
  /// A helper to get the [LastPlayedEntity] as a [Map].
  Map get getMap {
    Map tempKeyMap = {
      "_data": this.lastData,
      "_display_name": this.displayName,
      "_id": this.id,
      "album": this.album,
      "album_id": this.albumId,
      "artist": this.artist,
      "artist_id": this.artistId,
      "date_added": this.dateAdded,
      "duration": this.duration,
      "title": this.title,
      "artwork": this.artworkAsBytes,
    };
    return tempKeyMap;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnMostPlayedListHelper on List<MostPlayedEntity> {
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

  /// A helper to get a list of [MostPlayedEntity] as a [Map].
  List<Map> get getListOfMap {
    List<Map> tempList = [];

    this.forEach((entity) {
      tempList.add(entity.getMap);
    });

    return tempList;
  }
}

/// A [on_audio_room] extension to help the package.
extension OnMostPlayedHelper on MostPlayedEntity {
  /// A helper to get the [MostPlayedEntity] as a [Map].
  Map get getMap {
    Map tempKeyMap = {
      "_data": this.lastData,
      "_display_name": this.displayName,
      "_id": this.id,
      "album": this.album,
      "album_id": this.albumId,
      "artist": this.artist,
      "artist_id": this.artistId,
      "date_added": this.dateAdded,
      "duration": this.duration,
      "title": this.title,
      "artwork": this.artworkAsBytes,
    };
    return tempKeyMap;
  }
}
