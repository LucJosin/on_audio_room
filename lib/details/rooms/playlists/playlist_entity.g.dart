// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistEntityAdapter extends TypeAdapter<PlaylistEntity> {
  @override
  final int typeId = 4;

  @override
  PlaylistEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistEntity(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
      fields[3] as int?,
      (fields[4] as List).cast<SongEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.playlistName)
      ..writeByte(2)
      ..write(obj.playlistDateModified)
      ..writeByte(3)
      ..write(obj.playlistDataAdded)
      ..writeByte(4)
      ..write(obj.playlistSongs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
