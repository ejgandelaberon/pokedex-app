import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef PageRequestListener<PageKeyType> = Future<void> Function(
  PageKeyType pageKey,
  PagingController pagingController,
);

PagingController<PageKeyType, ItemType>
    useInfiniteScrollPagingController<PageKeyType, ItemType>({
  required PageKeyType firstPageKey,
  int? invisibleItemsThreshold,
}) {
  return use(
    _InfiniteScrollPaginationHook<PageKeyType, ItemType>(
      firstPageKey: firstPageKey,
      invisibleItemsThreshold: invisibleItemsThreshold,
    ),
  );
}

class _InfiniteScrollPaginationHook<PageKeyType, ItemType>
    extends Hook<PagingController<PageKeyType, ItemType>> {
  const _InfiniteScrollPaginationHook({
    required this.firstPageKey,
    this.invisibleItemsThreshold,
  });

  final PageKeyType firstPageKey;
  final int? invisibleItemsThreshold;

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

  final controller = useTextEditingController();

  @override
  PagingController<PageKeyType, ItemType> build(BuildContext context) =>
      _pagingController;

  @override
  String? get debugLabel => 'useInfiniteScrollPagingController';
}
