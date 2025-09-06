import 'package:corpofit_mobile/anamnesis/domain/entities/basic_data.dart';

abstract class DataBasicDatasource {
  Future<void> addDataBasic(BasicData basicData);
  Future<BasicData> basicData();
  Future<void> deleteDataBasic(int id);
}
