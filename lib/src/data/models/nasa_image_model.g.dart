// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nasa_image_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NasaImageModelAdapter extends TypeAdapter<NasaImageModel> {
  @override
  final int typeId = 0;

  @override
  NasaImageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NasaImageModel(
      id: fields[0] as String,
      title: fields[1] as String,
      url: fields[2] as String,
      date: fields[3] as DateTime,
      explanation: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NasaImageModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.explanation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NasaImageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
