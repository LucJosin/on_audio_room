import 'package:on_audio_room/on_audio_room.dart';
import 'package:nanoid/nanoid.dart';

/// A [on_audio_room] extension to help the package.
extension OnEntityFormatter on Map {
  /// Generate a unique key.
  int get _getUniqueKey => int.parse(customAlphabet("123456789", 8));

  /// Used to parse a [Map] into a [SongEntity].
  ///
  /// Important & Paramaters:
  ///
  /// * Only this parameters will be used used:
  ///
  ///   * @NonNull _data
  ///   * _display_name
  ///   * @NonNull _id
  ///   * album
  ///   * album_id
  ///   * artist
  ///   * artist_id
  ///   * date_added
  ///   * duration
  ///   * @NonNull title
  ///   * artwork
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

  /// Used to parse a [Map] into a [FavoritesEntity].
  ///
  /// Important & Paramaters:
  ///
  /// * The [key] will be automatically generated and added.
  /// * Only this parameters will be used used:
  ///
  ///   * @NonNull _data
  ///   * _display_name
  ///   * @NonNull _id
  ///   * album
  ///   * album_id
  ///   * artist
  ///   * artist_id
  ///   * date_added
  ///   * duration
  ///   * @NonNull title
  ///   * artwork
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

  /// Used to parse a [Map] into a [LastPlayedEntity].
  ///
  /// Important & Paramaters:
  ///
  /// * The [key] will be automatically generated and added.
  /// * If [lastTimePlayed] is null, will be set to [DateTime.now()].
  /// * Only this parameters will be used used:
  ///
  ///   * @NonNull _data
  ///   * _display_name
  ///   * @NonNull _id
  ///   * album
  ///   * album_id
  ///   * artist
  ///   * artist_id
  ///   * date_added
  ///   * duration
  ///   * @NonNull title
  ///   * artwork
  LastPlayedEntity toLastPlayedEntity(int timePlayed, {int? lastTimePlayed}) {
    if (lastTimePlayed == null)
      lastTimePlayed = DateTime.now().millisecondsSinceEpoch;
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

  /// Used to parse a [Map] into a [MostPlayedEntity].
  ///
  /// Important & Paramaters:
  ///
  /// * The [key] will be automatically generated and added.
  /// * If [lastTimePlayed] is null, will be set to [DateTime.now()].
  /// * If [playCount] is null, will be set to [0].
  /// * Only this parameters will be used used:
  ///
  ///   * @NonNull _data
  ///   * _display_name
  ///   * @NonNull _id
  ///   * album
  ///   * album_id
  ///   * artist
  ///   * artist_id
  ///   * date_added
  ///   * duration
  ///   * @NonNull title
  ///   * artwork
  MostPlayedEntity toMostPlayedEntity(
    int timePlayed, {
    int? lastTimePlayed,
    int? playCount,
  }) {
    if (lastTimePlayed == null)
      lastTimePlayed = DateTime.now().millisecondsSinceEpoch;
    if (playCount == null) playCount = 0;
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
