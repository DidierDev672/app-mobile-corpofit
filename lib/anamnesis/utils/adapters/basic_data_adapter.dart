import 'package:hive/hive.dart';
import 'package:corpofit_mobile/anamnesis/domain/entities/basic_data.dart';

class BasicDataAdapter extends TypeAdapter<BasicData> {
  @override
  final int typeId = 0;

  @override
  BasicData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BasicData(
      id: fields[0] as int,
      name: fields[1] as String,
      height: fields[2] as double,
      weight: fields[3] as double,
      gender: fields[4] as String,
      birthDate: fields[5] as DateTime,
      country: fields[6] as String,
      city: fields[7] as String,
      address: fields[8] as String,
      region: fields[9] as String,
      createdAt: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BasicData obj) {
    writer
      ..writeByte(9) // Número de campos
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.birthDate)
      ..writeByte(6)
      ..write(obj.country)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.address);
  }
}
