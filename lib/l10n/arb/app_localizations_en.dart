// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get counterAppBarTitle => 'Codika App';

  @override
  String get youHavePushedTheButtonThisManyTimes =>
      'You have pushed the button this many times:';

  @override
  String hello(String userName) {
    return 'Hello $userName';
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
      zero: 'no wombats',
    );
    return '$_temp0';
  }

  @override
  String pronoun(String gender) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': 'he',
      'female': 'she',
      'other': 'they',
    });
    return '$_temp0';
  }

  @override
  String numberOfDataPoints(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.compactCurrency(locale: localeName, decimalDigits: 2);
    final String valueString = valueNumberFormat.format(value);

    return 'Number of data points: $valueString';
  }

  @override
  String helloWorldOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Hello World on $dateString';
  }

  @override
  String get escapedExample => 'Hello! {Isn\'t} this a wonderful day?';

  @override
  String get appTitle => 'Product Catalog';

  @override
  String get searchHint => 'Search products…';

  @override
  String get allCategories => 'All';

  @override
  String get priceUnavailable => 'Price unavailable';

  @override
  String get unknownBrand => 'Unknown Brand';

  @override
  String get uncategorized => 'Uncategorized';

  @override
  String get unknownProduct => 'Unknown Product';

  @override
  String get retryButton => 'Try Again';

  @override
  String get noResults => 'No products found';

  @override
  String get noResultsSubtitle => 'Try adjusting your search or filters.';

  @override
  String get cachedDataBanner => 'Showing cached data';

  @override
  String get offlineBanner => 'You are offline';

  @override
  String stockLabel(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count in stock',
      one: '1 item left',
      zero: 'Out of stock',
    );
    return '$_temp0';
  }

  @override
  String ratingLabel(String value) {
    return 'Rating: $value';
  }

  @override
  String brandLabel(String brand) {
    return 'Brand: $brand';
  }

  @override
  String categoryLabel(String category) {
    return 'Category: $category';
  }

  @override
  String discountLabel(String percent) {
    return '$percent% off';
  }

  @override
  String get imageGalleryLabel => 'Product images';

  @override
  String get backButton => 'Back';

  @override
  String get showcaseTitle => 'Design System Showcase';

  @override
  String get productDetailTitle => 'Product Detail';

  @override
  String get productListTitle => 'Products';

  @override
  String get noProductSelected => 'Select a product to view details';

  @override
  String get loadingLabel => 'Loading…';
}
