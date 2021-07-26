library on_audio_room;

//Database
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_room/details/extensions/song_map_formatter_extension.dart';

//Entities import
import 'details/databases/song_entity.dart';
import 'details/databases/favorites/favorites_entity.dart';
import 'details/databases/lastPlayed/last_played_entity.dart';
import 'details/databases/mostPlayed/most_played_entity.dart';
import 'details/databases/playlists/playlist_entity.dart';

//Entities export
export 'details/databases/song_entity.dart';
export 'details/databases/favorites/favorites_entity.dart';
export 'details/databases/lastPlayed/last_played_entity.dart';
export 'details/databases/mostPlayed/most_played_entity.dart';
export 'details/databases/playlists/playlist_entity.dart';

//Extensions import
import 'package:on_audio_room/details/extensions/room_type_extension.dart';
import 'package:on_audio_room/details/extensions/entity_checker_extension.dart';
import 'package:on_audio_room/details/extensions/room_helper_extension.dart';

//Extensions export
export 'package:on_audio_room/details/extensions/song_map_formatter_extension.dart';

//Controller
part 'details/on_audio_room_controller.dart';

//Types
part 'details/types/room_type.dart';

//Dao
part 'details/databases/favorites/favorites_dao.dart';
part 'details/databases/lastPlayed/last_played_dao.dart';
part 'details/databases/mostPlayed/most_played_dao.dart';
part 'details/databases/playlists/playlist_dao.dart';

//RoomEntity
part 'details/databases/room_entity.dart';
