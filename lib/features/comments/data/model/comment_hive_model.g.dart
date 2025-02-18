// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentHiveModelAdapter extends TypeAdapter<CommentHiveModel> {
  @override
  final int typeId = 3;

  @override
  CommentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentHiveModel(
      commentId: fields[0] as String?,
      listing: fields[1] as String,
      comment: fields[3] as String,
      user: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CommentHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.commentId)
      ..writeByte(1)
      ..write(obj.listing)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(2)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
