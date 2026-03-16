// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get counterAppBarTitle => 'Application Codika';

  @override
  String get youHavePushedTheButtonThisManyTimes =>
      'Vous avez appuyé sur le bouton ce nombre de fois :';

  @override
  String hello(String userName) {
    return 'Bonjour $userName';
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
      zero: 'aucun wombat',
    );
    return '$_temp0';
  }

  @override
  String pronoun(String gender) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': 'il',
      'female': 'elle',
      'other': 'iel',
    });
    return '$_temp0';
  }

  @override
  String numberOfDataPoints(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.compactCurrency(locale: localeName, decimalDigits: 2);
    final String valueString = valueNumberFormat.format(value);

    return 'Nombre de points de données : $valueString';
  }

  @override
  String helloWorldOn(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Bonjour le monde le $dateString';
  }

  @override
  String get escapedExample => 'Bonjour ! {N\'est-ce pas} une belle journée ?';

  @override
  String get appTitle => 'Catalogue de Produits';

  @override
  String get searchHint => 'Rechercher des produits…';

  @override
  String get allCategories => 'Tous';

  @override
  String get priceUnavailable => 'Prix indisponible';

  @override
  String get unknownBrand => 'Marque inconnue';

  @override
  String get uncategorized => 'Non catégorisé';

  @override
  String get unknownProduct => 'Produit inconnu';

  @override
  String get retryButton => 'Réessayer';

  @override
  String get noResults => 'Aucun produit trouvé';

  @override
  String get noResultsSubtitle =>
      'Essayez d\'ajuster votre recherche ou vos filtres.';

  @override
  String get cachedDataBanner => 'Affichage des données en cache';

  @override
  String get offlineBanner => 'Vous êtes hors ligne';

  @override
  String stockLabel(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count en stock',
      one: '1 article restant',
      zero: 'Rupture de stock',
    );
    return '$_temp0';
  }

  @override
  String ratingLabel(String value) {
    return 'Note : $value';
  }

  @override
  String brandLabel(String brand) {
    return 'Marque : $brand';
  }

  @override
  String categoryLabel(String category) {
    return 'Catégorie : $category';
  }

  @override
  String discountLabel(String percent) {
    return '$percent% de réduction';
  }

  @override
  String get imageGalleryLabel => 'Images du produit';

  @override
  String get backButton => 'Retour';

  @override
  String get showcaseTitle => 'Vitrine du système de conception';

  @override
  String get productDetailTitle => 'Détail du produit';

  @override
  String get productListTitle => 'Produits';

  @override
  String get noProductSelected =>
      'Sélectionnez un produit pour afficher les détails';

  @override
  String get loadingLabel => 'Chargement…';
}
