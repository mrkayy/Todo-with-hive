// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      hId: fields[0] as String,
      hTitle: fields[1] as String,
      hSubtitle: fields[2] as String,
      hCreatedAtTime: fields[3] as DateTime,
      hCreatedAtDate: fields[4] as DateTime,
      hIsCompleted: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hId)
      ..writeByte(1)
      ..write(obj.hTitle)
      ..writeByte(2)
      ..write(obj.hSubtitle)
      ..writeByte(3)
      ..write(obj.hCreatedAtTime)
      ..writeByte(4)
      ..write(obj.hCreatedAtDate)
      ..writeByte(5)
      ..write(obj.hIsCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
