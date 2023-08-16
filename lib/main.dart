import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/src/providers/theme/dark_mode.dart';
import 'package:pokedex_app/src/screens/home.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<bool>('darkModeBox');

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    return MaterialApp(
      title: 'Pokedex App',
      theme: ThemeData(
        useMaterial3: true,
        brightness: darkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokedex App'),
        ),
        body: const Home(),
        floatingActionButton: IntrinsicWidth(
          child: Row(
            children: [
              const Text('Dark Mode'),
              Switch.adaptive(
                value: darkMode,
                onChanged: (value) {
                  ref.read(darkModeProvider.notifier).toggle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
