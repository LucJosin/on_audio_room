/*
=============
Author: Lucas Josino
Github: https://github.com/LucasPJS
Website: https://lucasjosino.com/
=============
Plugin/Id: on_audio_room#4
Homepage: https://github.com/LucasPJS/on_audio_room
Pub: https://pub.dev/packages/on_audio_room
License: https://github.com/LucasPJS/on_audio_room/blob/main/LICENSE
Copyright: © 2021, Lucas Josino. All rights reserved.
=============
*/

/// Interface and Main method for use [on_audio_room].
///
/// [on_audio_room] is a [Flutter](https://flutter.dev/) Package used to create a
/// "room" to storage audio sections.
///
/// RoomTypes:
///
/// * Favorites.
/// * Last Played.
/// * MostPlayed.
/// * Playlists.
///     * Playlist songs.
///
/// See more:
///
/// Homepage: [GitHub](https://github.com/LucasPJS/on_audio_room) <br>
/// Documentation: [API](https://pub.dev/documentation/on_audio_room/latest/) <br>
///
/// Any problem? [Issues](https://github.com/LucasPJS/on_audio_room/issues) <br>
/// Any suggestion? [Pull request](https://github.com/LucasPJS/on_audio_room/pulls)
part of on_audio_room;

/// A Calculator.
class OnAudioRoom {
  /// Internal Controller to keep the package clean and organized.
  _RoomController get _controller => _RoomController();

  //Room methods

  /// Used to init/open room's
  ///
  /// Usage:
  ///
  /// * Call [initRoom] before [runApp] or [navigate] to another screen that **REQUIRE**
  /// call any room.
  /// * If you don't define [roomType], only the room's path will be loaded, but
  /// you **CAN'T** call any method
  ///
  /// Parameters:
  ///
  /// * [roomType] this will define which room will be opened/loaded/used.
  /// * [subDir] this will be the path to create/load room's.
  ///
  /// Important:
  ///
  /// * This method will **ONLY** work 100% if you add a [async/await], if don't,
  /// the widget will load almost in the same time and will throw a error.
  /// * You **CAN** open all the room's at the same time, **BUT**, this will
  /// require a lof of memory. I **DON'T** recommend.
  /// * **REMEMBER TO CLOSE THE ROOM'S BEFORE [DISPOSE]**.
  ///
  /// Example:
  ///
  /// ```dart
  /// void main() async {
  ///   //Init Room.
  ///   await OnAudioRoom().initRoom(RoomType.FAVORITES);
  ///   runApp(MaterialApp(home: MyApp()));
  /// }
  /// ```
  ///
  /// Return:
  ///
  /// * [initRoom] will **ALWAYS** return a [bool]:
  ///   * [true] if the room/path is loaded
  ///   * [false] if something wrong happend or path is [null]
  ///
  /// See also:
  ///
  /// * [closeRoom]
  Future<bool> initRoom([RoomType? roomType, String? subDir]) async {
    await Hive.initFlutter(subDir);
    return roomType == null ? true : await roomType.openRoom;
  }

  /// Used to close room's
  ///
  /// Usage:
  ///
  /// * Call [closeRoom] before [dispose]. This will avoid memory leaks.
  ///
  /// Example:
  ///
  /// ```dart
  /// @override
  /// void dispose() {
  ///   OnAudioRoom().closeRoom();
  ///   super.dispose();
  /// }
  /// ```
  ///
  /// See also:
  ///
  /// * [initRoom]
  void closeRoom() => Hive.close();

  /// Used to delete the file which contains the box and closes the box.
  ///
  /// Important:
  ///
  /// * You **CAN'T** revert this deletion.
  ///
  /// Return:
  ///
  /// * [deleteRoomFile] will **ALWAYS** return a [bool]:
  ///   * [true] if the file was deleted.
  ///   * [false] if something wrong happend.
  Future<bool> deleteRoomFile(RoomType roomType) async {
    Box<dynamic> tempBox = roomType.getBox;
    return await tempBox.deleteFromDisk().then((value) => true);
  }

  /// Used to get some information about a specific [Room].
  ///
  /// Return:
  ///
  /// * [getRoomInfo] will **ALWAYS** return a [RoomEntity] with this informations:
  ///   * Name
  ///   * Path
  ///   * isEmpty
  ///   * isOpen
  ///   * length
  ///   * keys
  ///   * values
  RoomEntity getRoomInfo(RoomType roomType) {
    Box<dynamic> tempBox = roomType.getBox;
    return RoomEntity()
      ..name = tempBox.name
      ..path = tempBox.path
      ..isEmpty = tempBox.isEmpty
      ..isOpen = tempBox.isOpen
      ..length = tempBox.length
      ..keys = tempBox.keys
      ..values = tempBox.values;
  }

  /// Used to reset **ALL** the database.
  ///
  /// ### Before usage:
  ///
  /// **The data is completely erased. The space will be reclaimed**
  ///
  /// Return:
  ///
  /// * Will return [true] if all the room's has been cleaned.
  Future<bool> clearAll() async {
    return _controller.clearAllController();
  }

  //Global methods

  /// Used to add a specific song(entity) into a specific [Room].
  ///
  /// Parameters:
  ///
  /// * [roomType] this will define which room the entity will be added.
  /// * [entity] this is the entity with all information about song.
  /// * [playlistKey] this will be the id/key of the playlist [*].
  ///
  /// **[*] [playlistKey] it's only required when using [RoomType.PLAYLIST].**
  ///
  /// Important:
  ///
  /// * For now if you add two entities with the same information, will be added.
  /// You can use [checkIn] to make sure that the song was already added.
  ///
  /// Usage:
  ///
  /// * A [entity] is a [Map<dynamic, dynamic>]. You have two options:
  ///
  ///   * [1] Create a manual entity.
  ///
  ///   * [2] Use [on_audio_query] extension to create the entity.
  ///
  /// Examples:
  ///
  /// 1- Manual
  ///
  /// ```dart
  /// Map<dynamic, dynamic> entityMap = {
  ///   "_data": song.data,
  ///   "_display_name": song.displayName,
  ///   "_id": song.id,
  ///   "album": song.album,
  ///   "album_id": song.albumId,
  ///   "artist": song.artist,
  ///   "artist_id": song.artistId,
  ///   "date_added": song.dateAdded,
  ///   "duration": song.duration,
  ///   "title": song.title,
  ///   "artwork": song.artwork,
  /// };
  ///
  /// // After this, you can call this method to convert to [FavoritesEntity]:
  /// var favoritesEntity = entityMap.toFavoritesEntity();
  ///
  /// ```
  ///
  /// 2- [OnAudioQuery](https://github.com/LucasPJS/on_audio_query)
  ///
  /// ```dart
  /// List<SongModel> listOfSongs;
  /// //toFavoritesEntity()
  /// //toLastPlayedEntity()
  /// //toMostPlayedEntity()
  /// Map<dynamic, dynamic> entityMap = listOfSongs[index].getMap.toFavoritesEntity();
  /// ```
  ///
  /// Return:
  ///
  /// * If the song(entity) was added, will return [int] that represent the song key
  /// inside the room, if some problem occurred, will throw a error.
  ///
  /// Throw:
  ///
  /// * Will throw a error when [entity] is null or when [RoomType.PLAYLIST]
  /// is called and [playlistKey] is null.
  ///
  /// See also:
  ///
  /// * [addAllTo]
  /// * [checkIn]
  Future<int?> addTo(
    RoomType roomType,
    dynamic entity, {
    int? playlistKey,
  }) async {
    assert(
        OnEntityChecker(entity).isEntity(roomType),
        "[addTo] - [entity] isn't a instance of Entity\n"
        "Choose one of the existing entities");
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
    return await _controller.addToController(
      roomType,
      entity,
      playlistKey: playlistKey,
    );
  }

  /// Used to add a list of song(entity) to a specific room.
  ///
  /// Parameters:
  ///
  /// * [roomType] this will define which room the entities will be added.
  /// * [entities] this is the entities with all information about songs.
  /// * [playlistKey] this will be the id/key of the playlist [*].
  ///
  /// **[*] [playlistKey] it's only required when using [RoomType.PLAYLIST].**
  ///
  /// Important:
  ///
  /// * For now if you add two entities with the same information, will be added.
  /// You can use [checkIn] to make sure that the song was already added.
  ///
  /// Usage:
  ///
  /// * All [entities] are a [List<Map<dynamic, dynamic>>]. You have two options:
  ///
  ///   * [1] Create a manual entities.
  ///
  ///   * [2] Use [on_audio_query] extension to create the entities.
  ///
  /// Examples:
  ///
  /// 1- Manual
  ///
  /// ```dart
  /// //Create a [Map<dynamic, dynamic>] and convert to a [Entity]
  /// Map<dynamic, dynamic> entityMap = {
  ///   "last_data": song.data,
  ///   "display_name": song.displayName,
  ///   "id": song.id,
  ///   "album": song.album,
  ///   "album_id": song.albumId,
  ///   "artist": song.artist,
  ///   "artist_id": song.artistId,
  ///   "date_added": song.dateAdded,
  ///   "duration": song.duration,
  ///   "title": song.title,
  ///   "artwork": song.artwork,
  /// };
  ///
  /// // After this, you can call this method to convert to [FavoritesEntity]:
  /// var favoritesEntity = entityMap.toFavoritesEntity();
  ///
  /// //Now, add to a list of entity
  /// List<FavoritesEntity> entities = [];
  /// entities.add(favoritesEntity);
  ///
  /// ```
  ///
  /// 2- [OnAudioQuery](https://github.com/LucasPJS/on_audio_query)
  ///
  /// ```dart
  /// List<SongModel> listOfSongs;
  /// //toFavoritesEntity()
  /// //toLastPlayedEntity()
  /// //toMostPlayedEntity()
  /// List<FavoritesEntity> entities = [];
  ///
  /// listOfSongs.forEach((element)
  ///   entities.add(element.getMap.toFavoritesEntity());
  /// });
  /// ```
  ///
  /// Return:
  ///
  /// * If the list of song(entity) was added, will return a list of [int] that
  /// represent the songs ids inside the room, if some problem occurred,
  /// will throw a error.
  ///
  /// Throw:
  ///
  /// * Will throw a error when some of the [entity] is null or when
  /// [RoomType.PLAYLIST_SONG] is called and [playlistId] is null.
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [checkIn]
  Future<List<int>> addAllTo(
    RoomType roomType,
    List<dynamic> entities, {
    int? playlistKey,
  }) async {
    assert(
        OnEntityChecker(entities).isEntity(roomType),
        "[addAllTo] - [entities] isn't a instance of Entity\n"
        "Choose one of the existing entities");
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
    return await _controller.addAllToController(
      roomType,
      entities,
      playlistKey: playlistKey,
    );
  }

  /// Used to update a specific [Room].
  ///
  /// Parameters:
  ///
  /// * [roomType] this will define which room the entity will be updated.
  /// * [entity] this is the entity with all the new information about song.
  ///
  /// Important:
  ///
  /// * All methods will use the [key] as parameter to identify the entity. **DON'T change it.**
  ///
  /// Return:
  ///
  /// * [updateRoom] will **ALWAYS** return a [bool]:
  ///   * [true] if the entity was changed.
  ///   * [false] if something wrong happend.
  Future<bool> updateRoom(RoomType roomType, dynamic entity) async {
    assert(
        OnEntityChecker(entity).isEntity(roomType),
        "[updateRoom] - [entity] isn't a instance of Entity\n"
        "Choose one of the existing entities");
    return await _controller.updateController(roomType, entity);
  }

  /// Used to delete a specific song(entity) from a specific room.
  ///
  /// Parameters:
  ///
  /// * [roomType] this will define which room the entity will be deleted.
  /// * [entityKey] this is the key of the song that will be deleted.
  /// * [playlistKey] this will be the id/key of the playlist [*].
  ///
  /// **[*] [playlistKey] it's only required when using [RoomType.PLAYLIST].**
  ///
  /// Return:
  ///
  /// * If the song was deleted, will return [true], if not, will return [false].
  ///
  /// See too:
  ///
  /// * [deleteAllFrom]
  /// * [checkIn]
  Future<bool> deleteFrom(
    RoomType roomType,
    int entityKey, {
    int? playlistKey,
  }) async {
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
    return await _controller.deleteFromController(
      roomType,
      entityKey,
      playlistKey: playlistKey,
    );
  }

  /// Used to delete all defined entities from a specific room.
  ///
  /// Parameters:
  ///
  /// * [roomType] this will define which room will be cleaned.
  /// * [keys] this will define all entities that will be deleted.
  /// * [playlistKey] this will be the id/key of the playlist [*].
  ///
  /// **[*] [playlistKey] it's only required when using [RoomType.PLAYLIST].**
  ///
  /// Return:
  ///
  /// * If all defined entities was deleted, will return [true], if not, will return [false].
  ///
  /// See too:
  ///
  /// * [deleteFrom]
  /// * [checkIn]
  Future<bool> deleteAllFrom(
    RoomType roomType,
    List<int> keys, {
    int? playlistKey,
  }) async {
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
    return await _controller.deleteAllFromController(
      roomType,
      keys,
      playlistKey: playlistKey,
    );
  }

  /// Used to delete **ALL** the entities from a specific room.
  ///
  /// Parameters:
  ///
  /// * [roomType] this will define which room will be cleaned.
  /// * [playlistKey] this will be the id/key of the playlist [*].
  ///
  /// **[*] [playlistKey] it's only required when using [RoomType.PLAYLIST].**
  ///
  /// Return:
  ///
  /// * If the room was cleaned, will return [true], if not, will return [false].
  ///
  /// See too:
  ///
  /// * [deleteFrom]
  /// * [checkIn]
  Future<bool> clearRoom(RoomType roomType, {int? playlistKey}) async {
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
    return await _controller.clearController(
      roomType,
      playlistKey: playlistKey,
    );
  }

  /// Used to check if a song(entity) was added to a specific room.
  ///
  /// Parameters:
  ///
  /// * [roomType] this will define which room will be checked.
  /// * [entityKey] this is the key of the song that will be checked.
  /// * [playlistKey] this will be the id/key of the playlist [*].
  ///
  /// **[*] [playlistKey] it's only required when using [RoomType.PLAYLIST].**
  ///
  /// Return:
  ///
  /// * If the song(entity) exist in the room, will return [true], if not,
  /// will return [false] and if some problem occurred, will throw a error.
  ///
  /// Throw:
  ///
  /// * Will throw a error when some of the [entityKey] is null or when
  /// [RoomType.PLAYLIST] is called and [playlistKey] is null.
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<bool> checkIn(
    RoomType roomType,
    int entityKey, {
    int? playlistKey,
  }) async {
    if (roomType == RoomType.PLAYLIST && playlistKey == null)
      throw Exception("Cannot add [entity] to a undefined [playlist]\n"
          "Define the [playlistKey] parameter.");
    return await _controller.checkController(
      roomType,
      entityKey,
      playlistKey: playlistKey,
    );
  }

  ///
  // Future<T> queryFrom<T>(int entityKey) async {
  //   return _FavoritesDao().queryFromFavorites(entityKey) as T;
  // }

  //Query methods

  //Favorites query

  /// Used to query a specific song(entity) from [favorites] room.
  ///
  /// Use [checkIn] to know if song exist on [favorites] room.
  ///
  /// Parameters:
  ///
  /// * [entityKey] this is the key of the song that will be queried.
  ///
  /// Return:
  ///
  /// * Will return a [FavoritesEntity] or a [Null] value.
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<FavoritesEntity?> queryFromFavorites(int entityKey) async {
    return _FavoritesDao().queryFromFavorites(entityKey);
  }

  /// Used to query all songs(entities) from [favorites] room.
  ///
  /// Use [checkIn] to know if song exist on [favorites] room.
  ///
  /// Parameters:
  ///
  /// * [limit] this will limit the amount of entities queried. Taking less
  /// time to run and giving a better performance.
  /// * [reverse] this will define if list return will be reversed or no.
  /// * [sortType] this will define the list sort type.
  ///
  /// Important:
  ///
  /// * If [limit] is null, will be set to [50].
  /// * If [reverse] is null, will be set to [false].
  /// * If [sortType] is null, will be set to [key].
  ///
  /// Return:
  ///
  /// * Will return a list of [FavoritesEntity].
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<List<FavoritesEntity>> queryFavorites({
    int limit = 50,
    bool reverse = false,
    RoomSortType? sortType,
  }) async {
    return await _FavoritesDao().queryFavorites(
      limit,
      reverse,
      sortType,
    );
  }

  //Last Played query

  /// Used to query a specific song(entity) from [last_played] room.
  ///
  /// Use [checkIn] to know if song exist on [last_played] room.
  ///
  /// Parameters:
  ///
  /// * [entityKey] this is the key of the song that will be queried.
  ///
  /// Return:
  ///
  /// * Will return a [LastPlayedEntity] or a [Null] value.
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<LastPlayedEntity?> queryFromLastPlayed(int entityKey) async {
    return _LastPlayedDao().queryFromLastPlayed(entityKey);
  }

  /// Used to query all songs(entities) from [last_played] room.
  ///
  /// Use [checkIn] to know if song exist on [last_played] room.
  ///
  /// Parameters:
  ///
  /// * [limit] this will limit the amount of entities queried. Taking less
  /// time to run and giving a better performance.
  /// * [reverse] this will define if list return will be reversed or no.
  /// * [sortType] this will define the list sort type.
  ///
  /// Important:
  ///
  /// * If [limit] is null, will be set to [50].
  /// * If [reverse] is null, will be set to [false].
  /// * If [sortType] is null, will be set to [key].
  ///
  /// Return:
  ///
  /// * Will return a list of [LastPlayedEntity].
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<List<LastPlayedEntity>> queryLastPlayed({
    int limit = 50,
    bool reverse = false,
    RoomSortType? sortType,
  }) async {
    return _LastPlayedDao().queryLastPlayed(
      limit,
      reverse,
      sortType,
    );
  }

  //Most Played query

  /// Used to query a specific song(entity) from [most_played] room.
  ///
  /// Use [checkIn] to know if song exist on [most_played] room.
  ///
  /// Parameters:
  ///
  /// * [entityKey] this is the key of the song that will be queried.
  ///
  /// Return:
  ///
  /// * Will return a [MostPlayedEntity] or a [Null] value.
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<MostPlayedEntity?> queryFromMostPlayed(int entityKey) async {
    return _MostPlayedDao().queryFromMostPlayed(entityKey);
  }

  /// Used to query all songs(entities) from [most_played] room.
  ///
  /// Use [checkIn] to know if song exist on [most_played] room.
  ///
  /// Parameters:
  ///
  /// * [limit] this will limit the amount of entities queried. Taking less
  /// time to run and giving a better performance.
  /// * [reverse] this will define if list return will be reversed or no.
  /// * [sortType] this will define the list sort type.
  ///
  /// Important:
  ///
  /// * If [limit] is null, will be set to [50].
  /// * If [reverse] is null, will be set to [false].
  /// * If [sortType] is null, will be set to [key].
  ///
  /// Return:
  ///
  /// * Will return a list of [MostPlayedEntity].
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<List<MostPlayedEntity>> queryMostPlayed({
    int limit = 50,
    bool reverse = false,
    RoomSortType? sortType,
  }) async {
    return _MostPlayedDao().queryMostPlayed(
      limit,
      reverse,
      sortType,
    );
  }

  /// Used to update the count of listened songs.
  ///
  /// Parameters:
  ///
  /// * [key] this is the key of the song that will be updated.
  /// * [automatic] this will define if the count will be increased automatically.
  /// * [newCount] this will define the new count.
  ///
  /// Important:
  ///
  /// * If [automatic] is null, will be set to [true].
  /// * If [automatic] is [false] and [newCount] is null, will throw a error.
  ///
  /// Return:
  ///
  /// * If the song(entity) was updated, will return [true], if not, will return [false].
  Future<bool> updateCount(int key, {bool automatic = true, int? newCount}) {
    if (automatic == false && newCount == null) return throw "";
    return _MostPlayedDao().updateCount(key, automatic, newCount);
  }

  //Playlist songs query

  /// Used to query a specific song(entity) from [playlist] room.
  ///
  /// Use [checkIn] to know if song exist on [playlist] room.
  ///
  /// Parameters:
  ///
  /// * [id] this is the id of the song that will be queried.
  /// * [playlistKey] this will be the id/key of the playlist.
  ///
  /// Return:
  ///
  /// * Will return a [SongEntity] or a [Null] value.
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<SongEntity?> queryFromPlaylist(int playlistKey, int id) async {
    return _PlaylistDao().queryFromPlaylist(playlistKey, id);
  }

  /// Used to query all songs(entities) from [playlist] room.
  ///
  /// Use [checkIn] to know if song exist on [playlist] room.
  ///
  /// Parameters:
  ///
  /// * [playlistKey] this is the id/key of the playlist that will be queried.
  /// * [limit] this will limit the amount of entities queried. Taking less
  /// time to run and giving a better performance.
  /// * [reverse] this will define if list return will be reversed or no.
  /// * [sortType] this will define the list sort type.
  ///
  /// Important:
  ///
  /// * If [limit] is null, will be set to [50].
  /// * If [reverse] is null, will be set to [false].
  /// * If [sortType] is null, will be set to [key].
  ///
  /// Return:
  ///
  /// * Will return a list of [SongEntity].
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<List<SongEntity>> queryAllFromPlaylist(
    int playlistKey, {
    int limit = 50,
    bool reverse = false,
    RoomSortType? sortType,
  }) async {
    return _PlaylistDao().queryAllFromPlaylist(
      playlistKey,
      limit,
      reverse,
      sortType,
    );
  }

  //Playlist methods

  /// Used to create a internal playlist.
  ///
  /// Usage:
  ///
  /// * To create a internal playlist you will only need one information.
  ///
  ///     * Playlist Name
  ///
  /// **You can use [toPlaylistEntity] method extension from a [String].**
  ///
  /// Parameters:
  ///
  /// * [playlistName] this is the name of the playlist.
  ///
  /// Important:
  ///
  /// * When creating a playlist, the unique parameter you need to set is [playlistName].
  /// * The [key] will be automatically setted.
  /// * The [playlistDateModified] will be automatically setted.
  /// * The [playlistDataAdded] will be automatically setted.
  /// * The [playlistSongs] will be empty.
  ///
  /// Example:
  ///
  /// ```dart
  /// PlaylistEntity playlistEntity = "My playlist".toPlaylistEntity();
  /// ```
  ///
  /// Return:
  ///
  /// * Will return a [int] representing the playlist Id.
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<int?> createPlaylist(String playlistName) async {
    return await _PlaylistDao().createPlaylist(
      OnPlaylistFormatter(playlistName).toPlaylistEntity,
    );
  }

  /// Used to delete a internal playlist.
  ///
  /// Parameters:
  ///
  /// * [key] this will be used to find the specific playlist.
  ///
  /// Return:
  ///
  /// * Will return [true] if the playlist has delete and [false] if not.
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<bool> deletePlaylist(int key) async {
    return await _PlaylistDao().deletePlaylist(key);
  }

  /// Used to rename a internal playlist.
  ///
  /// Parameters:
  ///
  /// * [key] this is the key of the playlist that will be renamed.
  /// * [newName] this is the new name of the playlist.
  ///
  /// Return:
  ///
  /// * Will return [true] if the playlist has renamed and [false] if not.
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<bool> renamePlaylist(int key, String newName) async {
    return await _PlaylistDao().renamePlaylist(key, newName);
  }

  /// Used to delete **ALL** the playlists.
  ///
  /// Return:
  ///
  /// * If the room was cleaned, will return [true], if not, will return [false].
  ///
  /// See too:
  ///
  /// * [deleteFrom]
  /// * [checkIn]
  Future<bool> clearPlaylists() async {
    return await _PlaylistDao().clearPlaylists();
  }

  /// Used to query a specific playlist(entity) from [playlists] room.
  ///
  /// Parameters:
  ///
  /// * [key] this is the key of the playlist that will be queried.
  ///
  /// Return:
  ///
  /// * Will return a [PlaylistEntity] or a [Null] value.
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<PlaylistEntity?> queryPlaylist(int key) async {
    return _PlaylistDao().queryPlaylist(key);
  }

  /// Used to query all playlist(entities) from [playlists] room.
  ///
  /// Parameters:
  ///
  /// * [limit] this will limit the amount of entities queried. Taking less
  /// time to run and giving a better performance.
  /// * [reverse] this will define if list return will be reversed or no.
  ///
  /// Important:
  ///
  /// * If [limit] is null, will be set to [50].
  /// * If [reverse] is null, will be set to [false].
  ///
  /// Return:
  ///
  /// * Will return a list of [PlaylistEntity].
  ///
  /// See too:
  ///
  /// * [addTo]
  /// * [addAllTo]
  /// * [deleteFrom]
  /// * [deleteAllFrom]
  Future<List<PlaylistEntity>> queryPlaylists({
    int limit = 50,
    bool reverse = false,
  }) async {
    return _PlaylistDao().queryPlaylists(limit, reverse);
  }
}
