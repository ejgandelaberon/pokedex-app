import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dark_mode.g.dart';

@riverpod
class DarkMode extends _$DarkMode {
  @override
  bool build() {
    final darkModeBox = Hive.box<bool>('darkModeBox');
    var darkMode = darkModeBox.get('darkMode', defaultValue: false);
    return darkMode ?? true;
  }

  void toggle() {
    state = !state;
    final darkModeBox = Hive.box<bool>('darkModeBox');
    darkModeBox.put('darkMode', state);
  }
}