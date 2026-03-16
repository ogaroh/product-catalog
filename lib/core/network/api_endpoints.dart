/// Centralised API endpoint constants for the DummyJSON products API.
abstract final class ApiEndpoints {
  static const String baseUrl = 'https://dummyjson.com';

  static const String products = '/products';
  static const String productSearch = '/products/search';
  static const String productCategories = '/products/categories';

  static String productById(int id) => '/products/$id';
  static String productsByCategory(String category) =>
      '/products/category/$category';
}
