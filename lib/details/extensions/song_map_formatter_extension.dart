import 'package:on_audio_room/on_audio_room.dart';
import 'package:nanoid/nanoid.dart';

extension OnEntityFormatter on Map {
  //Create a unique key.
  int get _getUniqueKey => int.parse(customAlphabet("123456789", 8));

  SongEntity toSongEntity() {
    return SongEntity()
      ..lastData = this["_data"]
      ..displayName = this["_display_name"]
      ..id = this["_id"]
      ..album = this["album"]
      ..albumId = this["album_id"]
      ..artist = this["artist"]
      ..artistId = this["artist_id"]
      ..dateAdded = this["date_added"]
      ..duration = this["duration"]
      ..title = this["title"]
      ..artwork = this["artwork"];
  }

  FavoritesEntity toFavoritesEntity() {
    return FavoritesEntity(_getUniqueKey)
      ..lastData = this["_data"]
      ..displayName = this["_display_name"]
      ..id = this["_id"]
      ..album = this["album"]
      ..albumId = this["album_id"]
      ..artist = this["artist"]
      ..artistId = this["artist_id"]
      ..dateAdded = this["date_added"]
      ..duration = this["duration"]
      ..title = this["title"]
      ..artwork = this["artwork"];
  }

  LastPlayedEntity toLastPlayedEntity(int timePlayed, int lastTimePlayed) {
    return LastPlayedEntity(_getUniqueKey, timePlayed, lastTimePlayed)
      ..lastData = this["_data"]
      ..displayName = this["_display_name"]
      ..id = this["_id"]
      ..album = this["album"]
      ..albumId = this["album_id"]
      ..artist = this["artist"]
      ..artistId = this["artist_id"]
      ..dateAdded = this["date_added"]
      ..duration = this["duration"]
      ..title = this["title"]
      ..artwork = this["artwork"];
  }

  MostPlayedEntity toMostPlayedEntity(
    int timePlayed,
    int lastTimePlayed,
    int playCount,
  ) {
    return MostPlayedEntity(
        _getUniqueKey, timePlayed, lastTimePlayed, playCount)
      ..lastData = this["_data"]
      ..displayName = this["_display_name"]
      ..id = this["_id"]
      ..album = this["album"]
      ..albumId = this["album_id"]
      ..artist = this["artist"]
      ..artistId = this["artist_id"]
      ..dateAdded = this["date_added"]
      ..duration = this["duration"]
      ..title = this["title"]
      ..artwork = this["artwork"];
  }
}

///This method will convert a [Map<dynamic, dynamic>] into a [PlaylistEntity].
extension OnPlaylistFormatter on String {
  //Create a unique key.
  int get _getUniqueKey => int.parse(customAlphabet("123456789", 8));

  /// This method will convert a [Map<dynamic, dynamic>] into a [PlaylistEntity].
  ///
  /// Important:
  ///
  /// * You have to follow always the same sequence:
  ///
  ///     * Playlist Name
  ///
  ///     * Playlist Date Added
  ///
  ///     * Playlist Date Modified
  ///
  /// Example:
  ///
  /// ```dart
  /// Map<dynamic, dynamic> playlistEntity = "My playlist 100000000 100000000".toPlaylistEntity();
  /// //This is the same as:
  /// Map<dynamic, dynamic> playlistEntity = {
  ///   "playlist_id": "My playlist",
  ///   "playlist_date_added": "100000000",
  ///   "playlist_date_modified": "100000000",
  /// };
  /// ```
  ///
  PlaylistEntity get _toPlaylistEntity {
    List<SongEntity> emptyList = [];
    return PlaylistEntity(
      _getUniqueKey,
      this,
      0,
      0,
      emptyList,
    );
  }
}
