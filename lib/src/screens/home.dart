import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/src/screens/pokemon/pokemon_list.dart';
import 'package:pokedex_app/src/screens/pokemon/pokemon_list_hook.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  static const List<Widget> menus = [
    PokemonListScreen(),
    PokemonListHookScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: GridView.builder(
        itemCount: menus.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => menus[index],
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pokemon ${index + 1}',
                    style: Theme.of(ref.context).textTheme.headlineSmall,
                  ),
                  const Icon(Icons.pets),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
