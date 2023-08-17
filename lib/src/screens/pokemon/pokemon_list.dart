import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex_app/src/entities/pokemon/pokemon_link.dart';
import 'package:pokedex_app/src/repositories/pokemon_repository.dart';

const int _kPageLimit = 20;

class PokemonListScreen extends ConsumerStatefulWidget {
  const PokemonListScreen({super.key});

  @override
  ConsumerState<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final _pagingController = PagingController<int, PokemonLink>(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener(fetchPage);
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('List'),
            floating: true,
          ),
          PagedSliverList<int, PokemonLink>(
            pagingController: _pagingController,
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
                                'Name: ${item.name}',
                              ),
                              Text(
                                'URL ${item.url}',
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

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems = await ref.watch(pokemonRepositoryProvider).fetchPokemons(
            offset: pageKey,
            limit: _kPageLimit,
          );

      final isLastPage = newItems.results.length < _kPageLimit;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems.results);
      } else {
        final nextPageKey = pageKey + newItems.results.length;
        _pagingController.appendPage(newItems.results, nextPageKey);
      }
    } catch (e) {
      log(e.toString(), name: 'PokemonListScreen::fetchPage');
    }
  }
}
