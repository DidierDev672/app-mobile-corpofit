import 'package:corpofit_mobile/anamnesis/domain/domain.dart';
import 'package:flutter/widgets.dart';

class BasicDataProvider with ChangeNotifier {
  final DataBasicRepository _dataBasicRepository;

  BasicDataProvider(this._dataBasicRepository);

  BasicData? _basicData;
  bool _isLoading = false;

  BasicData? get basicData => _basicData;

  bool get isLoading => _isLoading;

  Future<void> loadBasicData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _basicData = await _dataBasicRepository.basicData();
    } catch (e) {
      debugPrint('Error loading basic data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addBasicData(BasicData basicData) async {
    try {
      await _dataBasicRepository.addDataBasic(basicData);
      await loadBasicData();
    } catch (e) {
      debugPrint('Error adding basic data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeBasicData(int id) async {
    try {
      await _dataBasicRepository.deleteDataBasic(id);
      await loadBasicData();
    } catch (e) {
      debugPrint('Error removing basic data: $e');
    }
  }
}
