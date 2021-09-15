// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoritesEntityAdapter extends TypeAdapter<FavoritesEntity> {
  @override
  final int typeId = 1;

  @override
  FavoritesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoritesEntity(
      fields[11] as int,
    )
      ..lastData = fields[0] as String
      ..displayName = fields[1] as String?
      ..id = fields[2] as int
      ..album = fields[3] as String?
      ..albumId = fields[4] as int?
      ..artist = fields[5] as String?
      ..artistId = fields[6] as int?
      ..dateAdded = fields[7] as int?
      ..duration = fields[8] as int?
      ..title = fields[9] as String
      ..artwork = fields[10] as String?
      ..artworkAsBytes = fields[15] as Uint8List?;
  }

  @override
  void write(BinaryWriter writer, FavoritesEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(11)
      ..write(obj.key)
      ..writeByte(0)
      ..write(obj.lastData)
      ..writeByte(1)
      ..write(obj.displayName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.album)
      ..writeByte(4)
      ..write(obj.albumId)
      ..writeByte(5)
      ..write(obj.artist)
      ..writeByte(6)
      ..write(obj.artistId)
      ..writeByte(7)
      ..write(obj.dateAdded)
      ..writeByte(8)
      ..write(obj.duration)
      ..writeByte(9)
      ..write(obj.title)
      ..writeByte(10)
      ..write(obj.artwork)
      ..writeByte(15)
      ..write(obj.artworkAsBytes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoritesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
