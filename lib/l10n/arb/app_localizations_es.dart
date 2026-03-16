// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get counterAppBarTitle => 'Codika App';

  @override
  String get youHavePushedTheButtonThisManyTimes =>
      'Has pulsado el botón este número de veces:';

  @override
  String hello(String userName) {
    return 'Hola $userName';
  }

  @override
  String nWombats(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString wombats',
      one: '1 wombat',
      zero: 'ningún wombat',
    );
    return '$_temp0';
  }

  @override
  String pronoun(String gender) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': 'él',
      'female': 'ella',
      'other': 'elle',
    });
    return '$_temp0';
  }

  @override
  String numberOfDataPoints(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.compactCurrency(locale: localeName, decimalDigits: 2);
    final String valueString = valueNumberFormat.format(value);

    return 'Número de puntos de datos: $valueString';
  }

  @override
  String helloWorldOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Hola Mundo el $dateString';
  }

  @override
  String get escapedExample => '¡Hola! {¿No es} un día maravilloso?';

  @override
  String get appTitle => 'Catálogo de Productos';

  @override
  String get searchHint => 'Buscar productos…';

  @override
  String get allCategories => 'Todos';

  @override
  String get priceUnavailable => 'Precio no disponible';

  @override
  String get unknownBrand => 'Marca desconocida';

  @override
  String get uncategorized => 'Sin categoría';

  @override
  String get unknownProduct => 'Producto desconocido';

  @override
  String get retryButton => 'Intentar de nuevo';

  @override
  String get noResults => 'No se encontraron productos';

  @override
  String get noResultsSubtitle => 'Intenta ajustar tu búsqueda o filtros.';

  @override
  String get cachedDataBanner => 'Mostrando datos en caché';

  @override
  String get offlineBanner => 'Estás sin conexión';

  @override
  String stockLabel(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count en stock',
      one: '1 artículo restante',
      zero: 'Sin stock',
    );
    return '$_temp0';
  }

  @override
  String ratingLabel(String value) {
    return 'Calificación: $value';
  }

  @override
  String brandLabel(String brand) {
    return 'Marca: $brand';
  }

  @override
  String categoryLabel(String category) {
    return 'Categoría: $category';
  }

  @override
  String discountLabel(String percent) {
    return '$percent% de descuento';
  }

  @override
  String get imageGalleryLabel => 'Imágenes del producto';

  @override
  String get backButton => 'Atrás';

  @override
  String get showcaseTitle => 'Exhibición del sistema de diseño';

  @override
  String get productDetailTitle => 'Detalle del producto';

  @override
  String get productListTitle => 'Productos';

  @override
  String get noProductSelected => 'Selecciona un producto para ver detalles';

  @override
  String get loadingLabel => 'Cargando…';
}
