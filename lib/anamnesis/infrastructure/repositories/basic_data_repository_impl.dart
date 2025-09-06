import '../../domain/domain.dart';

class BasicDataRepositoryImpl implements DataBasicRepository {
  final DataBasicDatasource _basicDataDatasource;

  BasicDataRepositoryImpl(this._basicDataDatasource);

  @override
  Future<void> addDataBasic(BasicData basicData) async {
    await _basicDataDatasource.addDataBasic(basicData);
  }

  @override
  Future<BasicData> basicData() async {
    return await _basicDataDatasource.basicData();
  }

  @override
  Future<void> deleteDataBasic(int id) async {
    await _basicDataDatasource.deleteDataBasic(id);
  }
}
