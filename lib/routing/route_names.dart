/// Centralised route name constants.
abstract final class RouteNames {
  static const String catalog = '/';
  static const String productDetail = '/products/:id';
  static const String showcase = '/showcase';

  static String productDetailPath(int id) => '/products/$id';
}
