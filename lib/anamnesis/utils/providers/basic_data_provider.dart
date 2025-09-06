import 'package:corpofit_mobile/anamnesis/domain/basic_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'dart:async';

class BasicDataNotifier extends AutoDisposeAsyncNotifier<List<BasicData>> {
  Box<BasicData>? _box;
  AsyncValue<List<BasicData>>? _currentState;

  @override
  FutureOr<void> init() async {
    try {
      _box = await Hive.openBox<BasicData>('basic_data');
      _currentState = AsyncValue.data(_box!.values.toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt)));
      state = _currentState!;
    } catch (e) {
      _currentState = AsyncValue.error('Failed to initialize box: $e', StackTrace.current);
      state = _currentState!;
    }
  }

  @override
  Future<List<BasicData>> build() async {
    if (_box == null) {
      return [];
    }
    return _box!.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
  
  Future<void> addBasicData(BasicData basicData) async {
    if (_box == null) {
      state = AsyncValue.error('Box not initialized', StackTrace.current);
      return;
    }

    final newBasicData = BasicData(
      id: basicData.id,
      name: basicData.name,
      height: basicData.height,
      weight: basicData.weight,
      gender: basicData.gender,
      birthDate: basicData.birthDate,
      country: basicData.country,
      city: basicData.city,
      address: basicData.address,
      region: basicData.region,
      createdAt: DateTime.now(),
    );

    try {
      await _box!.add(newBasicData);
      _currentState = AsyncValue.data(
        _box!.values.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
      );
      state = _currentState!;
    } catch (e) {
      state = AsyncValue.error('Error adding data: $e', StackTrace.current);
    }
  }

  Future<void> deleteBasicData(int id) async {
    if (_box == null) {
      state = AsyncValue.error('Box not initialized', StackTrace.current);
      return;
    }

    try {
      await _box!.delete(id);
      _currentState = AsyncValue.data(
        _box!.values.toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
      );
      state = _currentState!;
    } catch (e) {
      state = AsyncValue.error('Error deleting data: $e', StackTrace.current);
    }
  }
}

final basicDataProvider =
    AsyncNotifierProvider.autoDispose<BasicDataNotifier, List<BasicData>>(
      () => BasicDataNotifier(),
    );
