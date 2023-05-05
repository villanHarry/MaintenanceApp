// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User()
      ..accessToken = fields[0] as String
      ..id = fields[1] as String
      ..username = fields[2] as String
      ..email = fields[3] as String
      ..usertype = fields[4] as String
      ..image = fields[5] as String
      ..contactNumber = fields[6] as int
      ..floorNumber = fields[7] as int
      ..address = fields[8] as String
      ..unitNumber = fields[9] as int;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.usertype)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.contactNumber)
      ..writeByte(7)
      ..write(obj.floorNumber)
      ..writeByte(8)
      ..write(obj.address)
      ..writeByte(9)
      ..write(obj.unitNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
