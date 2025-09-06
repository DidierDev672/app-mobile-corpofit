import 'package:hive/hive.dart';

import '../../domain/domain.dart';

class BasicDataDatasourceImpl implements DataBasicDatasource {
  final Box<BasicData> _boxDataBasic;

  BasicDataDatasourceImpl(this._boxDataBasic);

  @override
  Future<void> addDataBasic(BasicData basicData) async {
    await _boxDataBasic.add(basicData);
  }

  @override
  Future<BasicData> basicData() async {
    final basicData = await _boxDataBasic.get(0);
    return basicData ??
        BasicData(
          id: 0,
          name: '',
          height: 0,
          weight: 0,
          gender: '',
          birthDate: DateTime.now(),
          country: '',
          city: '',
          address: '',
          region: '',
          createdAt: DateTime.now(),
        );
  }

  @override
  Future<void> deleteDataBasic(int id) async {
    await _boxDataBasic.delete(id);
  }
}
