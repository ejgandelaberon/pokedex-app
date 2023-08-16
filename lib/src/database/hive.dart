import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_app/src/database/hive_records.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  await Hive.openBox<bool>(darkMode.box);
}
