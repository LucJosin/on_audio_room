part of on_audio_room;

/// A [Entity] that contains all box/room information.
class RoomEntity {
  /// The [path] file from a specific room.
  String? path;

  /// The [name] file from a specific room.
  String? name;

  /// The [Status] file from a specific room.
  bool? isEmpty;

  /// The [Status] file from a specific room.
  bool? isOpen;

  /// The [length] file from a specific room.
  int? length;

  /// All the [values] from a specific room.
  Iterable<dynamic>? values;

  /// All the [keys] from a specific room.
  Iterable<dynamic>? keys;

  @override
  String toString() {
    return "[Name]: $name, "
        "[Path]: $path, "
        "[Status]: $isOpen, "
        "[Empty]: $isEmpty, "
        "[Size]: $length";
  }
}
