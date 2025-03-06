// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListingHiveModelAdapter extends TypeAdapter<ListingHiveModel> {
  @override
  final int typeId = 1;

  @override
  ListingHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListingHiveModel(
      listingId: fields[0] as String?,
      name: fields[1] as String,
      description: fields[2] as String,
      address: fields[3] as String,
      regularPrice: fields[4] as int,
      discountedPrice: fields[5] as int?,
      bathrooms: fields[6] as int,
      bedrooms: fields[7] as int,
      furnished: fields[8] as bool,
      parking: fields[9] as bool,
      type: fields[10] as String,
      offer: fields[11] as bool,
      imageUrls: (fields[12] as List).cast<String>(),
      userRef: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ListingHiveModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.listingId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.regularPrice)
      ..writeByte(5)
      ..write(obj.discountedPrice)
      ..writeByte(6)
      ..write(obj.bathrooms)
      ..writeByte(7)
      ..write(obj.bedrooms)
      ..writeByte(8)
      ..write(obj.furnished)
      ..writeByte(9)
      ..write(obj.parking)
      ..writeByte(10)
      ..write(obj.type)
      ..writeByte(11)
      ..write(obj.offer)
      ..writeByte(12)
      ..write(obj.imageUrls)
      ..writeByte(13)
      ..write(obj.userRef);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListingHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
