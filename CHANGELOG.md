## [2.2.0] - [09.20.2021]
### Features
- **[Added]** Now `ignoreDuplicate` will convert the name to lowercase and make it more accurate.

### Fixes
- **[Fixed]** Fix for `ignoreDuplicate` in `[createPlaylist]`. - Thanks [@giga10](https://github.com/giga10)

## [2.1.1] - [09.17.2021]
### Features
- **[Added]** `ignoreDuplicate` parameter to `[addTo]` and `[createPlaylist]`.

### Fixes
- **[Fixed]** playlist method not saving data. - [#6](https://github.com/LucasPJS/on_audio_room/issues/6)

### Documentation
- Updated `README` documentation.

## [2.1.0] - [09.15.2021]
### Features
- **[Added]** `getMap` to `[SongEntity]` as `extension`, this will help to convert `[SongEntity]` to `[SongModel]`. - [#3](https://github.com/LucasPJS/on_audio_room/issues/3)

### Fixes
- **[Fixed]** Entity checker error when using `[addAllTo]`. - [#5](https://github.com/LucasPJS/on_audio_room/issues/5)
- **[Fixed]** No value returning when using `[queryLastPlayed]`. - [#4](https://github.com/LucasPJS/on_audio_room/issues/4)

### Documentation
- Updated `README` documentation.
- Updated `OnAudioRoomExample` documentation to support new `[Flutter 2.5]`.

## [2.0.0] - [07.29.2021]
### Release

- `[2.0.0]` release.

## [2.0.0-beta.2] - [07.28.2021]
### Features
- Added a option to load all room's using `[initRoom]`.

### Fixes
- Fixed playlists not saving the songs.

### Documentation
- Updated `README` documentation.

### Changes
- Removed `[path_provider]` from `[pubspec.yaml]`.
- ~~**[Test]** Removed `[Flutter]` from `[pubspec.yaml]`.~~

## [2.0.0-beta.1] - [07.26.2021]
### Features
- Added `[ID]`, `[TITLE]`, `[DURATION]` and `[DATE_ADDED]` to `[RoomSortType]`.
- Added `[RoomSortType]` to `[query]` methods.
- Added `[deleteRoomFile]`. **This method will delete the file PERMANENTLY**.
- Added `[clearRoom]`.
- Added `[updateRoom]`.

### Fixes
- Fixed wrong export. - [Fixed #1](https://github.com/LucasPJS/on_audio_room/issues/1)

### Documentation
- Updated `README` documentation.

### Changes
- Added a better example using the `[Favorites]` method has example.
- Added a better documentation to example.
- Now all `[entity/entities]` will be checked based on `[RoomType]`.
- Added internal `[RoomController]` to clean the package main method.

### ⚠ Important Changes
- Now `[deleteAllFrom]` no longer delete all data from specific `[Room]`, use `[clearRoom]` instead.
- Now `[queryAllFromFavorites]` are `[queryFavorites]`.
- Now `[queryAllFromLastPlayed]` are `[queryLastPlayed]`.
- Now `[queryAllFromMostPlayed]` are `[queryMostPlayed]`.
- Now `[resetAllDatabase]` are `[clearAll]`.

#### @**Deprecated**
- `[setDatabaseName]` - 
- `[setDatabaseLimit]` - 
- `[getDatabaseName]` - 
- `[getDatabaseStatus]`
    - Use `[getRoomInfo]` instead.
- `[resetDatabaseName]` - 
- `[resetDatabaseLimit]` - 
- `[queryAllIdsFrom]` - 

## [2.0.0-beta.0] - [07.26.2021]
### Documentation
- Updated `README` documentation.

### ⚠ Important Changes
- Now `[on_audio_room]` is a `[Package]`. Supporting all platforms.
- Added [Hive](https://pub.dev/packages/hive) to storage information.

## [1.0.1+1] - [07.19.2021]
### Fixes
#### Kotlin
- Fixed `[Kotlin]` issue when installing the plugin.

### Documentation
- Updated `README` documentation.

### Changes
#### Kotlin
- Downgraded some `[Kotlin]` dependencies.

## [1.0.1] - [07.17.2021]
### Fixes
#### Dart/Kotlin
- Fixed `excepting a parameter declaration` and `excepting an argument` from `[OnSongEntity]` and `[OnDatabaseExtension]`. - [Fixed #1](https://github.com/LucasPJS/on_audio_room/issues/1)

### Documentation
- Updated `README` documentation.

### Changes
#### Kotlin
- Updated some `[Kotlin]` dependencies.

## [1.0.0] - [06.19.2021]
### Release

- `[on_audio_room]` release.

## [0.10.1] - [06.18.2021]
### Features
#### Dart
- Created `[OnTimerFormatter]` and `[OnEntityFormatter]`.
- Created a int extension(OnTimerFormatter) used to format the duration into Time.
- Created a String extension(OnEntityFormatter) used to format the string to `[PlaylistEntity]`.

### Fixes
#### Dart/Kotlin
- Fixed all problems with comminication between Dart <-> Kotlin.

#### Dart
- Changed method to check null values.

### Documentation
- Added better comments to all plugin.
- Created `README` translation for `pt-BR` [Portuguese].
- Updated `README` documentation.
- Updated `README.pt-BR` documentation.
- Updated `pubspec.yaml`.

## [0.10.0] - [06.16.2021]
### Features
#### Kotlin
- Added basics methods for futures `[Migrations]`.
- Added `[OnGlobalSource]`, `[OnPlaylistSource]` and `[OnQuerySource]`.

#### Dart/Kotlin
- Added `[getDatabaseLimit]`, `[resetDatabaseLimit]`, `[setDatabaseLimit]`.
- Added `[AddAllTo]`.
- Added `[RoomType]`.
- Added `[FAVORITES]`, `[LASTPLAYED]`, `[MOSTPLAYED]`, `[PLAYLIST_SONGS]` to `[RoomType]`.

### Changes
#### Dart/Kotlin
- All methods used to `[Add/Delete/DeleteAll/Check]` are now `[AddTo]`, `[DeleteFrom]`, `[DeleteAllFrom]` and `[CheckIn]`.

### ⚠ Important Changes
#### Dart/Kotlin
- Removed:
    - `[getFavoritesSize]`
    - `[getFavoritesTotalDuration]`
    - `[getLastPlayedSize]`
    - `[getLastPlayedTotalDuration]`
    - `[getMostPlayedSize]`
    - `[getMostPlayedTotalDuration]`
- Removed:
    - `[addToFavorites]`
    - `[deleteFromFavorites]`
    - `[deleteAllFromFavorites]`
    - `[checkInFavorites]`
- Removed:
    - `[addToLastPlayed]`
    - `[deleteFromLastPlayed]`
    - `[deleteAllFromLastPlayed]`
    - `[checkInLastPlayed]`
- Removed: 
    - `[addToMostPlayed]`
    - `[deleteFromMostPlayed]`
    - `[deleteAllFromMostPlayed]`
    - `[checkInMostPlayed]`

## [0.9.0] - [06.11.2021]
### Features
#### Kotlin
- Added `[getDatabaseName]`, `[resetDatabaseName]`, `[setDatabaseName]`.
- Added `[closeDatabase]`, `[resetAllDatabase]`.
- Added `[getDatabaseStatus]`.
- Added:
    - `[getFavoritesSize]`
    - `[getFavoritesTotalDuration]`
    - `[getLastPlayedSize]`
    - `[getLastPlayedTotalDuration]`
    - `[getMostPlayedSize]`
    - `[getMostPlayedTotalDuration]`

## [0.8.0] - [06.10.2021]
### Documentation
- Added some comments/explication on how this plugin works.

## [0.6.0] - [06.07.2021]
### Features
#### Kotlin
- Created `[OnPlaylistDao]` and `[OnPlaylistEntity]`.
- Created `[OnPlaylistSongsDao]` and `[OnPlaylistSongsEntity]`.

#### Dart
- Created `[PlaylistEntity]` and `[PlaylistSongsEntity]`.
- Added `[createPlaylist]`, `[deletePlaylist]`, `[renamePlaylist]`, `[checkPlaylist]` and `[queryAllPlaylist]`.
- Added: 
    - `[addToPlaylist]`
    - `[deleteAllFromPlaylist]`
    - `[deleteFromPlaylist]`
    - `[checkInPlaylist]`
    - `[queryAllFromPlaylist]`.

## [0.5.0] - [06.02.2021]
### Features
#### Dart
- Created `[SongEntity]`, `[FavoritesEntity]`, `[LastPlayedEntity]` and `[MostPlayedEntity]`.
- Added:
    - `[addToFavorites]`
    - `[deleteFromFavorites]`
    - `[deleteAllFromFavorites]`
    - `[checkInFavorites]`
    - `[queryAllFromFavorites]`
- Added:
    - `[addToLastPlayed]`
    - `[deleteFromLastPlayed]`
    - `[deleteAllFromLastPlayed]`
    - `[checkInLastPlayed]`
    - `[queryAllFromLastPlayed]`
- Added: 
    - `[addToMostPlayed]`
    - `[deleteFromMostPlayed]`
    - `[deleteAllFromMostPlayed]`
    - `[updateCount]`
    - `[checkInMostPlayed]`
    - `[queryAllFromMostPlayed]`

### Changes
#### Kotlin
- Changed some function methods.

## [0.3.0] - [05.25.2021]
### Features
#### Kotlin
- Created `[OnLastPlayedDao]` and `[OnLastPlayedEntity]`.
- Created `[OnMostPlayedDao]` and `[OnMostPlayedEntity]`.

## [0.2.0] - [05.24.2021]
### Features
#### Kotlin
- Added `[Room]` database and `[Lifecyle]`.
- Created `[OnAudioDatabase]`, the main class to start using `[Room]` database.
- Created `[OnSongEntity]`.
- Created `[OnFavoritesDao]` and `[OnFavoritesEntity]`.
- Added basic functions to database.

## [0.1.0] - [05.22.2021]
### Features
#### Dart
- Added basic information to `[CHANGELOG]`, `[README]` and `[pubspec]`.

## [0.0.1] - [05.22.2021]
### Features
#### Dart/Kotlin
- Created the base for the plugin.

<!-- 
## [Version] - [Date]
### Features
- TODO

### Fixes
- TODO

### Documentation
- TODO

### Changes
- TODO

### ⚠ Important Changes
#### @**Deprecated**
- TODO
 -->

<!-- 
 https://github.com/LucasPJS/on_audio_room/issues/
 - **[Added]** (Text)- [#Issue](Link)
 - **[Fixed]** (Text)- [#Issue](Link)
 - **[Changed]** (Text)- [#Issue](Link)
-->
