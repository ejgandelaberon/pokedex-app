import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_link.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_list_response.dart';
import 'package:pokedex_app/src/hooks/infinite_scroll_pagination.dart';
import 'package:pokedex_app/src/repositories/pokemon_repository.dart';

import 'pokemon_service.dart';

const int _kPageLimit = 20;

class PokemonListHookScreen extends HookConsumerWidget {
  const PokemonListHookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController =
        useInfiniteScrollPagingController<int, PokemonLink>(firstPageKey: 0);

    Future<void> fetchPage(int pageKey) async {
      try {
        final cacheNotifier = ref.read(pokemonCacheProvider.notifier);
        final cache = cacheNotifier.all;

        PokemonListResponse? newItems;

        if (!cache.containsKey(pageKey.toString())) {
          log('Fetching pokemons from api...', name: 'PokemonListScreen::fetchPage');
          final newItems = await ref.watch(pokemonRepositoryProvider).fetchPokemons(
            offset: pageKey,
            limit: _kPageLimit,
          );

          log('Caching response...', name: 'PokemonListScreen::fetchPage');
          cacheNotifier.save(pageKey.toString(), newItems);
        }

        log('Fetching cached response...', name: 'PokemonListScreen::fetchPage');
        newItems = cacheNotifier.get(pageKey.toString());

        if (newItems != null) {
          final isLastPage = newItems.results.length < _kPageLimit;

          if (isLastPage) {
            pagingController.appendLastPage(newItems.results);
          } else {
            final nextPageKey = pageKey + newItems.results.length;
            pagingController.appendPage(newItems.results, nextPageKey);
          }
        }
      } catch (e) {
        log(e.toString(), name: 'PokemonListScreen::fetchPage');
      }
    }

    pagingController.addPageRequestListener(fetchPage);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('List'),
            floating: true,
          ),
          PagedSliverList<int, PokemonLink>(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, index) {
                return ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${item.name.toUpperCase()}',
                              ),
                              Text(
                                'URL: ${item.url}',
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  leading: Text(
                    '${index + 1}',
                  ),
                  title: Text(
                    item.name,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
