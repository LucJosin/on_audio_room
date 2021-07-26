# on_audio_room
[![Pub.dev](https://img.shields.io/pub/v/on_audio_room?color=9cf&label=Pub.dev&style=flat-square)](https://pub.dev/packages/on_audio_room)
[![Platform](https://img.shields.io/badge/Platform-Android-9cf?logo=android&style=flat-square)](https://www.android.com/)
[![Flutter](https://img.shields.io/badge/Language-Flutter%20%7C%20Null--Safety-9cf?logo=flutter&style=flat-square)](https://www.flutter.dev/)
[![Kotlin](https://img.shields.io/badge/Language-Kotlin-9cf?logo=kotlin&style=flat-square)](https://kotlinlang.org/)

`on_audio_room` is a [Flutter](https://flutter.dev/) Plugin used to create a database for storage audio sections [Favorites, Internal Playlists, Most Played, etc...]. <br>

This Plugin works as a "extension" to [on_audio_query](https://github.com/LucasPJS/on_audio_query) and some methods will require it.

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
  # on_audio_room: 2.0.0-beta.0
```

<!-- #### Request Permission:
If you want to use the built-in request permission, will need add the following code to your `AndroidManifest.xml`
```xml
<manifest> ...

  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
  <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

</manifest>
``` -->

## Some Features:

* Favorites section
* Last Played section
* Most Played section
* Internal playlists section

## TODO:

* Add better performance for all plugin.
* Add `[Features]`.
* Create methods for IOS.
* Fix bugs.

## How to use:

```dart
OnAudioRoom() // The main method to start using the plugin.
```
All types of methods on this plugin:

### Database methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`setDatabaseName`]() | `(String)` | `bool` | <br>
| [`setDatabaseLimit`]() | `(int)` | `bool` | <br>
| [`getDatabaseName`]() |  | `String` | <br>
| [`getDatabaseLimit`]() |  | `int` | <br>
| [`getDatabaseStatus`]() |  | `bool` | <br>
| [`resetDatabaseName`]() |  | `bool` | <br>
| [`resetDatabaseLimit`]() |  | `bool` | <br>
| [`resetAllDatabase`]() |  | `bool` | <br>
| [`closeDatabase`]() |  | `bool` | <br>

### Global methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`addTo`]() | `(RoomType, Entity, PlaylistId?)` | `int` | <br>
| [`addAllTo`]() | `(RoomType, Entity, PlaylistId?)` | `List<int>` | <br>
| [`deleteFrom`]() | `(RoomType, SongId, PlaylistId?)` | `bool` | <br>
| [`deleteAllFrom`]() | `(RoomType)` | `bool` | <br>
| [`checkIn`]() | `(RoomType, SongId, PlaylistId?)` | `bool` | <br>
| [`queryAllIdsFrom`]() | `(RoomType, PlaylistId?)` | `List<int>` | <br>

### Query methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`queryFromFavorites`]() | `(SongId)` | `FavoritesEntity` | <br>
| [`queryAllFromFavorites`]() | `(QueryLimit?)` | `List<FavoritesEntity>` | <br>
| [`queryFromLastPlayed`]() | `(SongId)` | `LastPlayedEntity` | <br>
| [`queryAllFromLastPlayed`]() | `(QueryLimit?)` | `List<LastPlayedEntity>` | <br>
| [`queryFromMostPlayed`]() | `(SongId)` | `MostPlayedEntity` | <br>
| [`queryAllFromMostPlayed`]() | `(QueryLimit?)` | `List<MostPlayedEntity>` | <br>
| [`queryFromPlaylist`]() | `(SongId)` | `PlaylistSongsEntity` | <br>
| [`queryAllFromPlaylist`]() | `(QueryLimit?)` | `List<PlaylistSongsEntity>` | <br>

### Playlist methods

|  Methods  |   Parameters   |   Return   |
|--------------|-----------------|-----------------|
| [`createPlaylist`]() | `(Entity)` | `int` | <br>
| [`deletePlaylist`]() | `(Entity)` | `bool` | <br>
| [`renamePlaylist`]() | `(PlaylistId, NewPlaylistName)` | `bool` | <br>
| [`queryPlaylist`]() | `(PlaylistId)` | `PlaylistEntity` | <br>
| [`queryAllPlaylists`]() | `(QueryLimit?)` | `List<PlaylistEntity>` | <br>

## Examples:

**All examples will use [on_audio_query] plugin to get songs/audios information**

#### addTo
```dart
  //If you use [on_audio_query] just extend SongModel to create any entity.
  someName() async {
    //The return will be the song id inside the database.
    int addToResult = await OnAudioRoom().addTo(
      RoomType.FAVORITES, 
      entity[index].toFavoritesEntity,
    );
  }

  //If you don't use [on_audio_query] just create a map with all information.
  someOtherName() async {
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

    //Now, add to the database
    //The return will be the song id inside the database.
    int addToResult = await OnAudioRoom().addTo(
      RoomType.FAVORITES, 
      favoritesEntity,
    ); 
  }
```

#### addAllTo
```dart
  //If you use [on_audio_query] just extend SongModel to create any entity.
  someName() async {
    //Create a list with all SongModel.
    List<SongModel> listOfSongs;
    List<Map<dynamic, dynamic>> listOfEntities;
    
    //Add all songs from model to entity.
    listOfSongs.forEach(element) {
      listOfEntities.add(element.toFavoritesEntity());
    }

    //Now, add to the database.
    //The return will be a list of song id inside the database.
    List<int> addAllToResult = await OnAudioRoom().addAllTo(
      RoomType.FAVORITES, 
      listOfEntities,
    );
  }

  //If you don't use [on_audio_query] just create a list of map with all information.
  someOtherName() async {
    List<Map<dynamic, dynamic>> listOfEntities;
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

      listOfEntities.add(favoritesEntity);
    }

    //Now, add to the database
    //The return will be a list of song id inside the database.
    List<int> addAllToResult = await OnAudioRoom().addAllTo(
      RoomType.FAVORITES, 
      favoritesEntity,
    ); 
  }
```

#### deleteFrom
```dart
  someName() async {
    //The return will be [true] if song has been deleted or [false] if not.
    bool deleteFromResult = await OnAudioRoom().deleteFrom(
      RoomType.FAVORITES,
      SongId,
    );
  }

  //When [Adding/Deleting/Checking] songs from a playlist, remember to add the
  //[PlaylistId] or you'll get a exception.
  someName() async {
    //The return will be [true] if song has been deleted or [false] if not.
    bool deleteFromResult = await OnAudioRoom().deleteFrom(
      RoomType.PLAYLIST_SONGS,
      SongId,
      PlaylistId: PlaylistId,
    );
  }
```

#### deleteAllFrom
```dart
  //This one it's pretty simple.
  someName() async {
    //The return will be [true] if all songs has been deleted or [false] if not.
    bool deleteAllFromResult = await OnAudioRoom().deleteAllFrom(
      RoomType.FAVORITES,
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
      SongId,
    );
  }
```

#### queryFromFavorites
```dart
  someName() async {
    //With this method you will define a songId and will return all information
    //about this song.
    FavoritesEntity queryFromResult = await OnAudioRoom().queryFromFavorites(
      SongId,
    );
  }
```

#### queryFromFavorites
```dart
  someName() async {
    //With this method you will get all songs with all information based on Type[Entity].
    //You can add a [int] as parameter to define how much song will return from this query.
    List<FavoritesEntity> queryAllFromResult = await OnAudioRoom().queryAllFromFavorites(
      100, //Default: 50
    );
  }
```

## LICENSE:

* [LICENSE](https://github.com/LucasPJS/on_audio_room/blob/main/LICENSE)

> * [Back to top](#on_audio_room)