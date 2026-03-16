import 'package:hive_flutter/hive_flutter.dart';
import 'cache_constants.dart';

/// Manages Hive initialisation and provides typed box accessors.
class HiveService {
  HiveService._();
  static final HiveService instance = HiveService._();

  late final Box<String> _productsBox;
  late final Box<int> _timestampsBox;
  late final Box<dynamic> _settingsBox;

  Box<String> get products => _productsBox;
  Box<int> get timestamps => _timestampsBox;
  Box<dynamic> get settings => _settingsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    _productsBox = await Hive.openBox<String>(CacheConstants.productsBox);
    _timestampsBox = await Hive.openBox<int>(CacheConstants.timestampsBox);
    _settingsBox = await Hive.openBox<dynamic>(CacheConstants.settingsBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
