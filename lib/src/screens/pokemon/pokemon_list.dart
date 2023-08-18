import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_link.dart';
import 'package:pokedex_app/src/hooks/infinite_scroller.dart';
import 'package:pokedex_app/src/repositories/pokemon_repository.dart';

class PokemonListScreen extends HookConsumerWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController = useInfiniteScroller<int, PokemonLink>(
      firstPageKey: 0,
      dataFetcher: (pageKey) {
        return ref
            .watch(pokemonRepositoryProvider)
            .fetchPokemons(
              offset: pageKey,
              limit: 20,
            )
            .then((value) => value.results);
      },
      pageLimit: 20,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('List'),
            floating: true,
          ),
          PagedSliverList<int, PokemonLink>.separated(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, index) {
                return ListTile(
                  onTap: () => _show(ref, item.name),
                  leading: Text('${index + 1}'),
                  title: Text(item.name),
                  trailing: IconButton(
                    onPressed: () => _show(ref, item.name),
                    icon: const Icon(Icons.pets),
                  ),
                );
              },
            ),
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(indent: 16, endIndent: 16);
            },
          ),
        ],
      ),
    );
  }

  void _show(WidgetRef ref, String pokemonName) {
    final pokemon =
        ref.watch(pokemonRepositoryProvider).fetchPokemon(pokemonName);

    showDialog(
      context: ref.context,
      builder: (_) {
        return FutureBuilder(
          future: pokemon,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                title: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError) {
              return AlertDialog(
                title: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData) {
              return const AlertDialog(
                content: Text('Pokemon not found', textAlign: TextAlign.center),
              );
            }

            final pokemon = snapshot.data as Pokemon;

            return AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${pokemon.id}'),
                  Text('Name: ${pokemon.name.toUpperCase()}'),
                  Text('Base Exp: ${pokemon.baseExperience}'),
                  Text('Height: ${pokemon.height}'),
                  Text('Weight: ${pokemon.weight}'),
                  Text('Order: ${pokemon.order}'),
                  Text('Is Default: ${pokemon.isDefault}'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
