import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cache/cache_constants.dart';
import '../../../../../core/cache/hive_service.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(const ThemeState(themeMode: ThemeMode.system)) {
    _loadPersistedTheme();
  }

  void _loadPersistedTheme() {
    final stored =
        HiveService.instance.settings.get(CacheConstants.themeKey) as int?;
    if (stored != null && stored >= 0 && stored < ThemeMode.values.length) {
      emit(ThemeState(themeMode: ThemeMode.values[stored]));
    }
  }

  void setTheme(ThemeMode mode) {
    HiveService.instance.settings.put(CacheConstants.themeKey, mode.index);
    emit(ThemeState(themeMode: mode));
  }

  void toggleTheme() {
    final next = switch (state.themeMode) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light,
    };
    setTheme(next);
  }
}
