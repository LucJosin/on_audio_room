part of on_audio_room;

/// [RoomSortType] will define the order when querying the entities.
enum RoomSortType {
  /// Order based on [ID].
  ID,

  /// Order based on [TITLE].
  TITLE,

  /// Order based on [DATE_ADDED].
  DATE_ADDED,

  /// Order based on [DURATION].
  DURATION,
}
