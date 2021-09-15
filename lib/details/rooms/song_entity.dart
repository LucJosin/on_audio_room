import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'song_entity.g.dart';

/// A [Entity] that contains all favorites information.
@HiveType(typeId: 0)
class SongEntity {
  /// The last [_data] from a specific song/audio.
  ///
  /// Important:
  ///
  /// * Cannot be [Null].
  @HiveField(0)
  late String lastData;

  /// [displayName]
  @HiveField(1)
  String? displayName;

  /// The [id] gerenated by the platform for a specific song/audio.
  ///
  /// Important:
  ///
  /// * Cannot be [Null].
  @HiveField(2)
  late int id;

  /// [album]
  @HiveField(3)
  String? album;

  /// [albumId]
  @HiveField(4)
  int? albumId;

  /// [artist]
  @HiveField(5)
  String? artist;

  /// [artistId]
  @HiveField(6)
  int? artistId;

  /// [dateAdded]
  @HiveField(7)
  int? dateAdded;

  /// [duration]
  @HiveField(8)
  int? duration;

  /// The [title] from a specific song/audio.
  ///
  /// Important:
  ///
  /// * Cannot be [Null].
  @HiveField(9)
  late String title;

  /// Deprecated after [2.1.0].
  @HiveField(10)
  @Deprecated("Use [artworkAsBytes] instead")
  String? artwork;

  /// [artworkBytes]
  @HiveField(15)
  Uint8List? artworkAsBytes;
}
