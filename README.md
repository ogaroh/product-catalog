# Product Catalog — Flutter App

A product catalog app that fetches data from the [DummyJSON API](https://dummyjson.com/products), displays it through a custom design system, and adapts its layout for phone and tablet screens.

---

## Setup & Run Instructions

### Requirements
- Flutter **3.41.1** (stable) — Dart SDK `^3.8.0`
- `fvm` optional; set the channel to `stable`
- Xcode 15+ (iOS), Android Studio / Gradle 8+ (Android)

### First-time setup

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### Run (choose flavor)

```sh
# Development
flutter run --flavor dev -t lib/main_dev.dart

# Staging
flutter run --flavor stag -t lib/main_stag.dart

# Production
flutter run --flavor prod -t lib/main_prod.dart
```

### Tests

```sh
flutter test
```

### Deep links

```
/products/:id   — Product detail
/showcase       — Component showcase
```

---

## Architecture Overview

### Folder structure

```
lib/
├── core/
│   ├── cache/          # Hive service, TTL constants
│   ├── design_system/  # 8 reusable components + barrel export
│   ├── error/          # AppException hierarchy, ErrorMapper
│   ├── network/        # DioClient, ApiEndpoints
│   ├── theme/          # AppColors, AppTextStyles, AppSpacing, AppTheme
│   └── utils/          # Debouncer, ImageUtils
├── features/
│   ├── catalog/
│   │   ├── data/
│   │   │   ├── datasources/   # remote (Dio) + local (Hive)
│   │   │   ├── models/        # Product, ProductsResponse + .g.dart
│   │   │   └── repository/    # ProductsRepository (remote-first)
│   │   └── presentation/
│   │       ├── blocs/         # category/, product_list/, product_detail/, theme/
│   │       ├── screens/       # list, detail, responsive shell
│   │       └── widgets/       # list view, filter bar, detail content, gallery
│   └── showcase/              # showcase screen
├── l10n/                      # ARB files (en / es / fr) + generated code
├── routing/                   # GoRouter config + route name constants
└── app.dart / main*.dart      # App entry points per flavor
```

### State management
**Bloc/Cubit** (flutter_bloc). All business logic is in cubits; UI only calls cubit methods and reacts to emitted states. Four cubits:
- `ProductListCubit` — pagination, search, category filter, tablet product selection
- `ProductDetailCubit` — single product load
- `CategoryCubit` — category list, selected chip
- `ThemeCubit` — light/dark/system, persisted to Hive

### Navigation
**GoRouter** with a `ShellRoute` wrapping both the list and detail routes. `ProductCatalogShell` reads `MediaQuery` width:
- **≥ 768 px (tablet):** renders a fixed-width (380 px) list panel + flex detail panel side-by-side; selecting a product updates the right panel, no push navigation
- **< 768 px (phone):** standard push navigation

### Data flow
```
UI → Cubit → Repository → RemoteSource (Dio) → DummyJSON API
                       ↑                    ↓
                  LocalSource (Hive)  ← cache response
```
`ProductsRepository` is remote-first: checks Hive TTL first (30 min), falls back to stale cache on network failure, and sets `isFromCache = true` so the UI can show a banner.

### Key packages
| Package | Purpose |
|---|---|
| `dio` | HTTP with interceptors, timeout |
| `flutter_bloc` | Cubit state management |
| `go_router` | Routing + deep links |
| `cached_network_image` | Lazy image loading + disk cache |
| `hive_flutter` | Lightweight offline cache (no SQL) |
| `shimmer` | Skeleton loading animation |
| `flutter_staggered_animations` | Staggered list entry animations |
| `json_annotation` + `json_serializable` | Code-gen JSON parsing |
| `bloc_test` + `mocktail` | Cubit unit tests |

---

## Design System Rationale

### Component API choices
- **ProductCard** takes a plain `Product` value object and exposes an `isSelected` flag (for tablet highlight) and `onTap` callback — no bloc inside the card itself, keeping it purely presentational.
- **AppSearchBar** owns its `TextEditingController` and `Debouncer` internally to keep call sites simple; an optional external controller is supported for testing.
- **CategoryChip** wraps Flutter's `FilterChip` directly — avoids reinventing an accessible chip.
- **PriceWidget** / **RatingWidget** are leaf widgets with no bloc dependency, making them testable without a bloc wrapper.
- **LoadingShimmer** uses the `shimmer` package with theme-adaptive colours (separate light/dark shimmer tokens in `AppColors`).

### Theming approach
`AppTheme.light` and `AppTheme.dark` produce full `ThemeData` objects from `AppColors`, `AppTextStyles`, and `AppSpacing` constants. Components read `Theme.of(context)` rather than hardcoded colours. `ThemeCubit` drives `MaterialApp.router`'s `themeMode`.

### Deviations
- `hive_generator` was dropped (incompatible with `json_serializable >=6.9`); Hive stores raw JSON strings instead of typed adapters, which is equally fast for this data size.
- The `ProductCard` hero tag (`'product-hero-${id}'`) is set even when no image is present — Flutter handles this silently.

---

## Limitations

- **No auth / cart** — out of scope.
- **Offline banner** shows stale data but does not yet expose real connectivity status (no `connectivity_plus`); it uses the `isFromCache` flag from the repository.
- **Animations (optional C)** — `flutter_staggered_animations` for list entry and `Hero` for detail transition are implemented; pull-to-refresh uses the stock `RefreshIndicator` without a custom animation.
- **Tablet deep link** — when navigating directly to `/products/:id` on a tablet-sized screen, the URL resolves but the master panel doesn't highlight the card (would require seeding the list cubit with the id before the list loads).
- **Pagination + search/category** — searching or filtering resets pagination (by design); infinite scroll is disabled in search/filter mode since the DummyJSON search endpoint returns all results in one page.

---

## AI Tools Usage

GitHub Copilot, Claude & Codex were used throughout this project for different purposes:
- **Planning phase** — generated the full architecture plan (folder structure, component APIs, state classes, phased implementation order)
- **Scaffolding** — generated boilerplate for cubits, repository, data sources, and design system components
- **Test generation** — generated unit test skeletons; two tests caught a real bug (null `brand`/`category` in `_$ProductFromJson`) that required adding `@JsonKey(defaultValue: '')` annotations and regenerating code
- **All generated output** was thoroughly reviewed, potential issues identified and fixed manually in a well-supervised manner


