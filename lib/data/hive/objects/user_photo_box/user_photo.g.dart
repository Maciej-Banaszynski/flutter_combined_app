// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_photo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserPhotoAdapter extends TypeAdapter<UserPhoto> {
  @override
  final int typeId = 1;

  @override
  UserPhoto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserPhoto(
      userId: fields[0] as int,
      photoData: fields[1] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, UserPhoto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.photoData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserPhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
