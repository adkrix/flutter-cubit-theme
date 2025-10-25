import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings.dart';

const _settingsStoreName = 'app_settings';

class SettingsCubit extends Cubit<AppSettings> {
  SettingsCubit() : super(AppSettings.fromJson({})) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_settingsStoreName);
    emit(AppSettings.fromString(saved));
  }

  Future<void> toggleTheme() async {
    _update(
      AppSettings(
        theme: state.theme == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light,
        lang: state.lang,
      ),
    );
  }

  Future<void> setLang(String? value) async {
    if (value == null || !appLangs.contains(value.toLowerCase())) {
      return;
    }
    final newValue = value.toLowerCase();
    if (!appLangs.contains(newValue)) {
      return;
    }
    _update(AppSettings(theme: state.theme, lang: newValue));
  }

  Future<void> _update(AppSettings newState) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsStoreName, newState.toString());
    emit(newState);
  }
}
