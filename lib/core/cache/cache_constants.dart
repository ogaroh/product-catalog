/// Hive box names and cache TTL constants.
abstract final class CacheConstants {
  static const String productsBox = 'products_cache';
  static const String timestampsBox = 'cache_timestamps';
  static const String settingsBox = 'app_settings';

  /// How long cached product data is considered fresh (30 minutes).
  static const Duration cacheTtl = Duration(minutes: 30);

  // Settings keys
  static const String themeKey = 'theme_mode';

  // Cache entry key builders
  static String listKey(int skip, int limit) => 'list_${skip}_$limit';
  static String searchKey(String query) => 'search_$query';
  static String categoryKey(String name) => 'category_$name';
  static String productKey(int id) => 'product_$id';
}
