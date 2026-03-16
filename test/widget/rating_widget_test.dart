import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/core/design_system/widgets/rating_widget.dart';
import 'package:product_catalog/core/theme/app_theme.dart';
import 'package:product_catalog/l10n/arb/app_localizations.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: AppTheme.light,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('RatingWidget — stars mode', () {
    testWidgets('renders exactly 5 icons for any rating', (tester) async {
      await tester.pumpWidget(_wrap(
        const RatingWidget(rating: 4.0, mode: RatingDisplayMode.stars),
      ));
      expect(find.byType(Icon), findsNWidgets(5));
    });

    testWidgets('all icons are filled at rating 5', (tester) async {
      await tester.pumpWidget(_wrap(
        const RatingWidget(rating: 5, mode: RatingDisplayMode.stars),
      ));
      final icons = tester
          .widgetList<Icon>(find.byType(Icon))
          .map((i) => i.icon)
          .toList();
      expect(icons.every((i) => i == Icons.star_rounded), isTrue);
    });

    testWidgets('all icons are outline at rating 0', (tester) async {
      await tester.pumpWidget(_wrap(
        const RatingWidget(rating: 0, mode: RatingDisplayMode.stars),
      ));
      final icons = tester
          .widgetList<Icon>(find.byType(Icon))
          .map((i) => i.icon)
          .toList();
      expect(icons.every((i) => i == Icons.star_outline_rounded), isTrue);
    });

    testWidgets('half star present at rating 3.5', (tester) async {
      await tester.pumpWidget(_wrap(
        const RatingWidget(rating: 3.5, mode: RatingDisplayMode.stars),
      ));
      final icons = tester
          .widgetList<Icon>(find.byType(Icon))
          .map((i) => i.icon)
          .toList();
      expect(icons.contains(Icons.star_half_rounded), isTrue);
    });

    testWidgets('rating is clamped to 5 for values above 5', (tester) async {
      await tester.pumpWidget(_wrap(
        const RatingWidget(rating: 10.0, mode: RatingDisplayMode.stars),
      ));
      // Should render 5 filled stars (clamped to 5)
      final icons = tester
          .widgetList<Icon>(find.byType(Icon))
          .map((i) => i.icon)
          .toList();
      expect(icons.every((i) => i == Icons.star_rounded), isTrue);
    });
  });

  group('RatingWidget — numeric mode', () {
    testWidgets('renders the rating as text', (tester) async {
      await tester.pumpWidget(_wrap(
        const RatingWidget(rating: 4.2, mode: RatingDisplayMode.numeric),
      ));
      expect(find.text('4.2'), findsOneWidget);
    });

    testWidgets('renders single icon (star icon) in numeric mode', (tester) async {
      await tester.pumpWidget(_wrap(
        const RatingWidget(rating: 4.2, mode: RatingDisplayMode.numeric),
      ));
      // numeric mode: 1 star icon + text
      expect(find.byType(Icon), findsOneWidget);
    });
  });
}
