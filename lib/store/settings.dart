import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
  return SettingsController();
});

class SettingsState with EquatableMixin {
  SettingsState({required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}

class SettingsController extends StateNotifier<SettingsState> {
  SettingsController() : super(SettingsState(themeMode: ThemeMode.system));

  late final SharedPreferences _preferences;
  bool isInit = false;

  void setPreference(SharedPreferences preferences) {
    if (isInit) {
      return;
    }
    _preferences = preferences;
    isInit = true;
    final index = _preferences.getInt('notebox:theme_mode') ?? 0;
    state = SettingsState(
      themeMode: ThemeMode.values[index],
    );
  }

  void setThemeMode(ThemeMode themeMode) {
    _preferences.setInt('nodebox:theme_mode', themeMode.index);
    state = SettingsState(themeMode: themeMode);
  }
}
