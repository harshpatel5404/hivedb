// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormModelAdapter extends TypeAdapter<FormModel> {
  @override
  final int typeId = 0;

  @override
  FormModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FormModel(
      name: fields[0] as dynamic,
      logindate: fields[1] as dynamic,
      loginamt: fields[2] as dynamic,
      status: fields[3] as dynamic,
      sanctionamt: fields[4] as dynamic,
      sanctiondate: fields[5] as dynamic,
      disburdeddate: fields[6] as dynamic,
      disburdedamt: fields[7] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, FormModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.logindate)
      ..writeByte(2)
      ..write(obj.loginamt)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.sanctionamt)
      ..writeByte(5)
      ..write(obj.sanctiondate)
      ..writeByte(6)
      ..write(obj.disburdeddate)
      ..writeByte(7)
      ..write(obj.disburdedamt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
