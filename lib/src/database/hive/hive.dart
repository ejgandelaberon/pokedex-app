import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_app/src/database/hive/hive_records.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  _registerHiveAdapters();

  await _openHiveBoxes();
}

void _registerHiveAdapters() {}

Future<void> _openHiveBoxes() async {
  await Hive.openBox<bool>(darkMode.box);
}
