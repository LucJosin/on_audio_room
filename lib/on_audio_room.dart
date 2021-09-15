/*
=============
Author: Lucas Josino
Github: https://github.com/LucasPJS
Website: https://lucasjosino.com/
=============
Plugin/Id: on_audio_room#4
Homepage: https://github.com/LucasPJS/on_audio_room
Pub: https://pub.dev/packages/on_audio_room
License: https://github.com/LucasPJS/on_audio_room/blob/main/LICENSE
Copyright: © 2021, Lucas Josino. All rights reserved.
=============
*/

library on_audio_room;

//Database
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

//Nanoid
import 'package:nanoid/nanoid.dart';

//Entities import
import 'details/rooms/song_entity.dart';
import 'details/rooms/favorites/favorites_entity.dart';
import 'details/rooms/lastPlayed/last_played_entity.dart';
import 'details/rooms/mostPlayed/most_played_entity.dart';
import 'details/rooms/playlists/playlist_entity.dart';

//Entities export
export 'details/rooms/song_entity.dart';
export 'details/rooms/favorites/favorites_entity.dart';
export 'details/rooms/lastPlayed/last_played_entity.dart';
export 'details/rooms/mostPlayed/most_played_entity.dart';
export 'details/rooms/playlists/playlist_entity.dart';

//Extensions import
import 'package:on_audio_room/details/extensions/room_type_extension.dart';
import 'package:on_audio_room/details/extensions/entity_checker_extension.dart';
import 'package:on_audio_room/details/extensions/room_helper_extension.dart';

//Extensions export
export 'package:on_audio_room/details/extensions/song_map_formatter_extension.dart';
export 'package:on_audio_room/details/extensions/room_helper_extension.dart';

//Controller
part 'details/on_audio_room_controller.dart';
part 'details/controller/room_controller.dart';

//Types
part 'details/types/room_type.dart';
part 'details/types/sort_type.dart';

//Dao
part 'details/rooms/favorites/favorites_dao.dart';
part 'details/rooms/lastPlayed/last_played_dao.dart';
part 'details/rooms/mostPlayed/most_played_dao.dart';
part 'details/rooms/playlists/playlist_dao.dart';

//RoomEntity
part 'details/rooms/room_entity.dart';

//Internal Extension
part 'details/extensions/playlist_formatter_extension.dart';
