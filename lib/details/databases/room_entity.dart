part of on_audio_room;

///
class RoomEntity {
  ///
  String? path;

  ///
  String? name;

  ///
  bool? isEmpty;

  ///
  bool? isOpen;

  ///
  int? length;

  ///
  Iterable<dynamic>? values;

  ///
  Iterable<dynamic>? keys;

  @override
  String toString() {
    return "[Name]: $name" +
        "[Path]: $path" +
        "[Status]: $isOpen" +
        "[Empty]: $isEmpty" +
        "[Size]: $length";
  }
}
