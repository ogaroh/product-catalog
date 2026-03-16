import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// Text shown in the AppBar of the Counter Page
  ///
  /// In en, this message translates to:
  /// **'Codika App'**
  String get counterAppBarTitle;

  /// Text shown in the Counter Page
  ///
  /// In en, this message translates to:
  /// **'You have pushed the button this many times:'**
  String get youHavePushedTheButtonThisManyTimes;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Hello {userName}'**
  String hello(String userName);

  /// A plural message
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no wombats} =1{1 wombat} other{{count} wombats}}'**
  String nWombats(num count);

  /// A gendered message
  ///
  /// In en, this message translates to:
  /// **'{gender, select, male{he} female{she} other{they}}'**
  String pronoun(String gender);

  /// A message with a formatted int parameter
  ///
  /// In en, this message translates to:
  /// **'Number of data points: {value}'**
  String numberOfDataPoints(int value);

  /// A message with a date parameter
  ///
  /// In en, this message translates to:
  /// **'Hello World on {date}'**
  String helloWorldOn(DateTime date);

  /// An example of escaped text with single quotes
  ///
  /// In en, this message translates to:
  /// **'Hello! \'{Isn\'\'t}\' this a wonderful day?'**
  String get escapedExample;

  /// Main app title
  ///
  /// In en, this message translates to:
  /// **'Product Catalog'**
  String get appTitle;

  /// Hint text in the search bar
  ///
  /// In en, this message translates to:
  /// **'Search products…'**
  String get searchHint;

  /// Label for the 'All categories' chip
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allCategories;

  /// Shown when a product has no valid price
  ///
  /// In en, this message translates to:
  /// **'Price unavailable'**
  String get priceUnavailable;

  /// Fallback brand name
  ///
  /// In en, this message translates to:
  /// **'Unknown Brand'**
  String get unknownBrand;

  /// Fallback category name
  ///
  /// In en, this message translates to:
  /// **'Uncategorized'**
  String get uncategorized;

  /// Fallback product title
  ///
  /// In en, this message translates to:
  /// **'Unknown Product'**
  String get unknownProduct;

  /// Label on error retry button
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get retryButton;

  /// Heading for empty state
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noResults;

  /// Subtitle for empty state
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search or filters.'**
  String get noResultsSubtitle;

  /// Banner shown when serving local cache
  ///
  /// In en, this message translates to:
  /// **'Showing cached data'**
  String get cachedDataBanner;

  /// Shown when device has no network
  ///
  /// In en, this message translates to:
  /// **'You are offline'**
  String get offlineBanner;

  /// Stock availability label
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Out of stock} =1{1 item left} other{{count} in stock}}'**
  String stockLabel(num count);

  /// Accessibility label for ratings
  ///
  /// In en, this message translates to:
  /// **'Rating: {value}'**
  String ratingLabel(String value);

  /// Product brand label
  ///
  /// In en, this message translates to:
  /// **'Brand: {brand}'**
  String brandLabel(String brand);

  /// Product category label
  ///
  /// In en, this message translates to:
  /// **'Category: {category}'**
  String categoryLabel(String category);

  /// Discount badge label
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String discountLabel(String percent);

  /// Accessibility label for image gallery
  ///
  /// In en, this message translates to:
  /// **'Product images'**
  String get imageGalleryLabel;

  /// Back navigation button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// Title for the component showcase screen (dev only)
  ///
  /// In en, this message translates to:
  /// **'Design System Showcase'**
  String get showcaseTitle;

  /// AppBar title for product detail
  ///
  /// In en, this message translates to:
  /// **'Product Detail'**
  String get productDetailTitle;

  /// AppBar title for product list
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get productListTitle;

  /// Right panel prompt on tablet when nothing is selected
  ///
  /// In en, this message translates to:
  /// **'Select a product to view details'**
  String get noProductSelected;

  /// Generic loading message
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loadingLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
