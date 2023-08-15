import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef PageRequestListener<PageKeyType> = Future<void> Function(
  PageKeyType pageKey,
  PagingController pagingController,
);

PagingController<PageKeyType, ItemType>
    useInfinitePaginationScroller<PageKeyType, ItemType>({
  required PageKeyType firstPageKey,
  int? invisibleItemsThreshold,
  required PageRequestListener<PageKeyType> fetchPage,
}) {
  final pagingController = PagingController<PageKeyType, ItemType>(
    firstPageKey: firstPageKey,
  );

  useEffect(() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey, pagingController);
    });

    return () {
      pagingController.dispose();
    };
  }, []);

  return pagingController;
}
