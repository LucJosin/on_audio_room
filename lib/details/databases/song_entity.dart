import 'package:hive/hive.dart';

part 'song_entity.g.dart';

///
@HiveType(typeId: 0)
class SongEntity {
  ///
  @HiveField(0)
  late String lastData;

  ///
  @HiveField(1)
  String? displayName;

  ///
  @HiveField(2)
  late int id;

  ///
  @HiveField(3)
  String? album;

  ///
  @HiveField(4)
  int? albumId;

  ///
  @HiveField(5)
  String? artist;

  ///
  @HiveField(6)
  int? artistId;

  ///
  @HiveField(7)
  int? dateAdded;

  ///
  @HiveField(8)
  int? duration;

  ///
  @HiveField(9)
  late String title;

  ///
  @HiveField(10)
  String? artwork;
}
