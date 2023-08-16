import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/src/database/hive.dart';
import 'package:pokedex_app/src/database/hives.dart';
import 'package:pokedex_app/src/screens/home.dart';

Future<void> main() async {
  await initHive();

  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final box = useValueListenable(Hive.box<bool>(darkMode.box).listenable());
    final isDark = box.get(darkMode.key, defaultValue: false) as bool;

    return MaterialApp(
      title: 'Pokedex App',
      theme: ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light,
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
                value: isDark,
                onChanged: (value) => box.put(darkMode.key, value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Non-Hooks implementation of the Value Listenable Builder
///
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: Hive.box<bool>(darkMode.box).listenable(),
//       builder: (context, box, child) {
//         final isDarkMode = box.get(darkMode.key, defaultValue: false) as bool;
//         return MaterialApp(
//           title: 'Pokedex App',
//           theme: ThemeData(
//             useMaterial3: true,
//             brightness: isDarkMode ? Brightness.dark : Brightness.light,
//           ),
//           home: Scaffold(
//             appBar: AppBar(
//               title: const Text('Pokedex App'),
//             ),
//             body: const Home(),
//             floatingActionButton: IntrinsicWidth(
//               child: Row(
//                 children: [
//                   const Text('Dark Mode'),
//                   Switch.adaptive(
//                     value: isDarkMode,
//                     onChanged: (value) => box.put(darkMode.key, value),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
