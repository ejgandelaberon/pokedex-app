import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

PagingController<PageKeyType, ItemType>
    useInfiniteScroller<PageKeyType, ItemType>({
  required PageKeyType firstPageKey,
  int? invisibleItemsThreshold,
  required Future<List<ItemType>> Function(PageKeyType pageKey) dataFetcher,
  required int pageLimit,
}) {
  return use(
    _InfiniteScrollPaginationHook<PageKeyType, ItemType>(
      firstPageKey: firstPageKey,
      invisibleItemsThreshold: invisibleItemsThreshold,
      dataFetcher: dataFetcher,
      pageLimit: pageLimit,
    ),
  );
}

class _InfiniteScrollPaginationHook<PageKeyType, ItemType>
    extends Hook<PagingController<PageKeyType, ItemType>> {
  const _InfiniteScrollPaginationHook({
    required this.firstPageKey,
    this.invisibleItemsThreshold,
    required this.dataFetcher,
    required this.pageLimit,
  });

  final PageKeyType firstPageKey;
  final int? invisibleItemsThreshold;
  final Future<List<ItemType>> Function(PageKeyType pageKey) dataFetcher;
  final int pageLimit;

  @override
  _InfiniteScrollPaginationStateHook<PageKeyType, ItemType> createState() =>
      _InfiniteScrollPaginationStateHook();
}

class _InfiniteScrollPaginationStateHook<PageKeyType, ItemType>
    extends HookState<PagingController<PageKeyType, ItemType>,
        _InfiniteScrollPaginationHook<PageKeyType, ItemType>> {
  late final PagingController<PageKeyType, ItemType> _pagingController =
      PagingController(
    firstPageKey: hook.firstPageKey,
    invisibleItemsThreshold: hook.invisibleItemsThreshold,
  );

  @override
  void initHook() async {
    _pagingController.addPageRequestListener((pageKey) async {
      final newItems = await hook.dataFetcher(pageKey);
      final isLastPage = newItems.length < hook.pageLimit;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        dynamic nextPageKey;

        if (pageKey is int) {
          nextPageKey = pageKey + newItems.length;
        } else {
          nextPageKey = pageKey.toString() + newItems.length.toString();
        }

        _pagingController.appendPage(newItems, nextPageKey);
      }
    });
    super.initHook();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  PagingController<PageKeyType, ItemType> build(BuildContext context) =>
      _pagingController;

  @override
  String? get debugLabel => 'useInfiniteScroller';
}
