import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokedex_app/src/screens/pokemon/pokemon_list.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  static const List<Widget> _menus = [
    PokemonListScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: GridView.builder(
        itemCount: _menus.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => _menus[index],
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.pets),
                  const SizedBox(width: 10),
                  Text(
                    'View Pokemon List',
                    style: Theme.of(ref.context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 10),
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
