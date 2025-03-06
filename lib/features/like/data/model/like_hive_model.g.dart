// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LikeHiveModelAdapter extends TypeAdapter<LikeHiveModel> {
  @override
  final int typeId = 2;

  @override
  LikeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LikeHiveModel(
      likeId: fields[0] as String?,
      listing: fields[1] as String,
      user: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LikeHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.likeId)
      ..writeByte(1)
      ..write(obj.listing)
      ..writeByte(2)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
