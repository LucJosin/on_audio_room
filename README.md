# on_audio_room
[![Pub.dev](https://img.shields.io/pub/v/on_audio_room?color=9cf&label=Pub.dev&style=flat-square)](https://pub.dev/packages/on_audio_room)
[![Pub.dev](https://img.shields.io/pub/v/on_audio_room?color=9cf&include_prereleases&label=Pub.dev&style=flat-square)](https://pub.dev/packages/on_audio_room/versions/2.0.0-beta.0)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20IOS%20%7C%20Web%20%7C%20MacOs%20%7C%20Linux%20%7C%20Windows-9cf?&style=flat-square)](https://www.android.com/)
[![Flutter](https://img.shields.io/badge/Language-Flutter%20%7C%20Null--Safety-9cf?logo=flutter&style=flat-square)](https://www.flutter.dev/)

`on_audio_room` is a [Flutter](https://flutter.dev/) Package used to create a "room" to storage audio sections [Favorites, Internal Playlists, Most Played, etc...]. <br>

This Package works as a "extension" to [on_audio_query](https://github.com/LucasPJS/on_audio_query) and some methods will require it.

## Help:

**Any problem? [Issues](https://github.com/LucasPJS/on_audio_room/issues)** <br>
**Any suggestion? [Pull request](https://github.com/LucasPJS/on_audio_room/pulls)**

### Translations:

NOTE: Feel free to help with readme translations

* [English](README.md)
* [Portuguese](README.pt-BR.md)

### Topics:

* [How to Install](#how-to-install)
* [How to use](#how-to-use)
* [Examples](#examples)
* [License](#license)

## How to Install:
Add the following code to your `pubspec.yaml`:
```yaml
dependencies:
  on_audio_room: ^1.0.1+1
  # Or you can test the beta version
  # on_audio_room: 2.0.0-beta.2
```

## Some Features:

* Favorites section
* Last Played section
* Most Played section
* Internal playlists section

## TODO:

* Add better performance for all plugin.
* Add `[Features]`.
* Fix bugs.

## How to use:

```dart
OnAudioRoom() // The main method to start using the plugin.
```
All types of methods on this plugin:

### Room methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`initRoom`]() | `(RoomType, SubDir?)` | `bool` | <br>
| [`closeRoom`]() |  | `bool` | <br>
| [`deleteRoomFile`]() |  | `bool` | <br>
| [`getRoomInfo`]() |  | `RoomEntity` | <br>
| [`clearAll`]() |  | `bool` | <br>

### Global methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`addTo`]() | `(RoomType, Entity, PlaylistKey?)` | `int?` | <br>
| [`addAllTo`]() | `(RoomType, Entity, PlaylistKey?)` | `List<int>` | <br>
| [`updateRoom`]() | `(RoomType, Entity)` | `bool` | <br>
| [`deleteFrom`]() | `(RoomType, EntityKey, PlaylistKey?)` | `bool` | <br>
| [`deleteAllFrom`]() | `(RoomType, EntityKeys, PlaylistKey?)` | `bool` | <br>
| [`clearRoom`]() | `(RoomType)` | `bool` | <br>
| [`checkIn`]() | `(RoomType, EntityKey, PlaylistKey?)` | `bool` | <br>

### Query methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`queryFromFavorites`]() | `(EntityKey)` | `FavoritesEntity` | <br>
| [`queryFavorites`]() | `(Limit?, Reverse?, RoomSortType?)` | `List<FavoritesEntity>` | <br>
| [`queryFromLastPlayed`]() | `(EntityKey)` | `LastPlayedEntity` | <br>
| [`queryLastPlayed`]() | `(Limit?, Reverse?, RoomSortType?)` | `List<LastPlayedEntity>` | <br>
| [`queryFromMostPlayed`]() | `(EntityKey)` | `MostPlayedEntity` | <br>
| [`queryMostPlayed`]() | `(Limit?, Reverse?, RoomSortType?)` | `List<MostPlayedEntity>` | <br>
| [`queryFromPlaylist`]() | `(PlaylistKey, EntityKey)` | `SongEntity` | <br>
| [`queryAllFromPlaylist`]() | `(PlaylistKey, Limit?, Reverse?, RoomSortType?)` | `List<SongEntity>` | <br>

### Playlist methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`createPlaylist`]() | `(PlaylistName)` | `int?` | <br>
| [`deletePlaylist`]() | `(PlaylistKey)` | `bool` | <br>
| [`renamePlaylist`]() | `(PlaylistKey, NewName)` | `bool` | <br>
| [`clearPlaylists`]() |  | `bool` | <br>
| [`queryPlaylist`]() | `(PlaylistKey)` | `PlaylistEntity` | <br>
| [`queryPlaylists`]() | `(Limit?, Reverse?)` | `List<PlaylistEntity>` | <br>

## Examples:

**All examples will use [on_audio_query] plugin to get songs/audios information**

#### addTo
```dart
  //If you use [on_audio_query] just extend SongModel to create any entity.
  someName() async {
    //The return will be the song id inside the room.
    int? addToResult = await OnAudioRoom().addTo(
      RoomType.FAVORITES, 
      entity[index].getMap.toFavoritesEntity(),
    );
  }

  //If you don't use [on_audio_query] just create a map with all information.
  someOtherName() async {
    Map<dynamic, dynamic> favoritesEntity = {
      "_data": song.data,
      "_display_name": song.displayName,
      "_id": song.id,
      "album": song.album,
      "album_id": song.albumId,
      "artist": song.artist,
      "artist_id": song.artistId,
      "date_added": song.dateAdded,
      "duration": song.duration,
      "title": song.title,
      "artwork": song.artwork,
    };

    //Now, add to the room
    //The return will be the song key inside the room.
    int? addToResult = await OnAudioRoom().addTo(
      RoomType.FAVORITES, 
      favoritesEntity.toFavoritesEntity(),
    ); 
  }
```

#### addAllTo
```dart
  //If you use [on_audio_query] just extend SongModel to create any entity.
  someName() async {
    //Create a list with all SongModel.
    List<SongModel> listOfSongs;
    List<dynamic> listOfEntities;
    
    //Add all songs from model to entity.
    listOfSongs.forEach(element) {
      listOfEntities.add(element.getMap.toFavoritesEntity());
    }

    //Now, add to the room.
    //The return will be a list of song id inside the room.
    List<int> addAllToResult = await OnAudioRoom().addAllTo(
      RoomType.FAVORITES, 
      listOfEntities,
      //playlistKey,
    );
  }

  //If you don't use [on_audio_query] just create a list of map with all information.
  someOtherName() async {
    List<dynamic> listOfEntities;

    listOfSongs.forEach(element) {
      Map<dynamic, dynamic> favoritesEntity = {
      "last_data": song.data,
      "display_name": song.displayName,
      "id": song.id,
      "album": song.album,
      "album_id": song.albumId,
      "artist": song.artist,
      "artist_id": song.artistId,
      "date_added": song.dateAdded,
      "duration": song.duration,
      "title": song.title,
      "artwork": song.artwork,
      };

      listOfEntities.add(favoritesEntity.toFavoritesEntity());
    }

    //Now, add to the room
    //The return will be a list of song id inside the room.
    List<int> addAllToResult = await OnAudioRoom().addAllTo(
      RoomType.FAVORITES, 
      favoritesEntity,
      //playlistKey,
    ); 
  }
```

#### deleteFrom
```dart
  someName() async {
    //The return will be [true] if song has been deleted or [false] if not.
    bool deleteFromResult = await OnAudioRoom().deleteFrom(
      RoomType.FAVORITES,
      EntityKey,
      //playlistKey,
    );
  }

  //When [Adding/Deleting/Checking] songs from a playlist, remember to add the
  //[PlaylistKey] or you'll get a exception.
  someName() async {
    //The return will be [true] if song has been deleted or [false] if not.
    bool deleteFromResult = await OnAudioRoom().deleteFrom(
      RoomType.PLAYLIST,
      EntityKey,
      PlaylistKey: PlaylistKey,
    );
  }
```

#### deleteAllFrom
```dart
  someName() async {
    List<int> listOfKeysToDelete = [...];
    //The return will be [true] if all songs has been deleted or [false] if not.
    bool deleteAllFromResult = await OnAudioRoom().deleteAllFrom(
      RoomType.FAVORITES,
      listOfKeysToDelete,
      //playlistKey,
    );
  }
```

#### clearRoom
```dart
  //This one it's pretty simple.
  someName() async {
    //The return will be [true] if all songs has been deleted or [false] if not.
    bool deleteAllFromResult = await OnAudioRoom().clearRoom(
      RoomType.FAVORITES,
      //playlistKey,
    );
  }
```

#### checkIn
```dart
  //You'll use this one to check if some song has already been added.
  //Why? If you try to add the same song twice, will work. To avoid this, check if exist.
  someName() async {
    //The return will be [true] if song has already been added or [false] if not.
    bool checkInResult = await OnAudioRoom().checkIn(
      RoomType.FAVORITES,
      EntityKey,
      //playlistKey,
    );
  }
```

#### queryFromFavorites
```dart
  someName() async {
    //With this method you will define a key and will return all information
    //about this favorite song.
    FavoritesEntity? queryFromResult = await OnAudioRoom().queryFromFavorites(
      EntityKey,
    );
  }
```

#### queryFavorites
```dart
  someName() async {
    //With this method you will get all songs with all information based on Type[Entity].
    //
    //You can add a [int] as parameter to define how much song will return from this query.
    //You can add a [bool] as parameter to define if list will be reversed or no.
    //You can add a [RoomSortType] as parameter to define the list sort type.
    List<FavoritesEntity> queryResult = await OnAudioRoom().queryFavorites(
      100, //Default: 50
      true, //Default: false
      RoomSortType.TITLE //Default: null
    );
  }
```

## LICENSE:

* [LICENSE](https://github.com/LucasPJS/on_audio_room/blob/main/LICENSE)

> * [Back to top](#on_audio_room)