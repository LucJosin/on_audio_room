part of on_audio_room;

/// This method will convert a [String] into a [PlaylistEntity].
extension OnPlaylistFormatter on String {
  /// Create a unique key.
  int get _getUniqueKey => int.parse(customAlphabet("123456789", 8));

  /// This method will convert a [String] into a [PlaylistEntity].
  ///
  /// When creating a playlist entity:
  ///   * [Key] will be automatically generated.
  ///   * [DateModified] will be automatically added.
  ///   * [DateAdded] will be automatically added.
  ///   * [Songs] will be a empty list.
  PlaylistEntity get toPlaylistEntity {
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
