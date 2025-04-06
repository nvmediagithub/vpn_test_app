// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vpn_connection_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VpnConnectionModelAdapter extends TypeAdapter<VpnConnectionModel> {
  @override
  final int typeId = 0;

  @override
  VpnConnectionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VpnConnectionModel(
      isConnected: fields[0] as bool,
      connectedAt: fields[1] as DateTime?,
      durationSeconds: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, VpnConnectionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isConnected)
      ..writeByte(1)
      ..write(obj.connectedAt)
      ..writeByte(2)
      ..write(obj.durationSeconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VpnConnectionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
