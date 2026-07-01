import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_store.g.dart';

const _kThemeKey = 'dark_mode';

@Riverpod(keepAlive: true)
class ThemeStore extends _$ThemeStore {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kThemeKey) ?? false;
  }

  Future<void> toggle() async {
    final current = state.when(
      data: (v) => v,
      loading: () => false,
      error: (_, _) => false,
    );
    final next = !current;
    state = AsyncData(next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kThemeKey, next);
  }
}
