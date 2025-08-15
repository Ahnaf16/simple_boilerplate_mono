import 'package:resta_dash/main.export.dart';

class PagedItem<T> {
  const PagedItem({required this.items, this.meta, this.prefix});

  const PagedItem.empty() : items = const [], meta = null, prefix = null;

  factory PagedItem.fromPagination(List<T> items, QMap meta, [String? prefix]) {
    final String metaKey = prefix != null ? '${prefix}_pagination_meta' : 'pagination_meta';

    final map = meta.get(metaKey);
    final metaData = Pagination.fromMap(map);
    return PagedItem(items: items, meta: metaData, prefix: prefix);
  }

  final List<T> items;
  final Pagination? meta;
  final String? prefix;

  T operator [](int index) => items[index];

  PagedItem<T> addWithPrevious(PagedItem<T> newData) {
    return PagedItem(items: [...items, ...newData.items], meta: newData.meta, prefix: prefix);
  }

  PagedItem<T> sortWith<A>(A Function(T) extract, Order<A> order) {
    return PagedItem(items: items.sortWith(extract, order), meta: meta, prefix: prefix);
  }

  int get length => items.length;

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  Map<String, dynamic> toMap(ToMapT<T> mapT, [String? itemsKey]) {
    final metaKey = prefix != null ? '${prefix}_pagination_meta' : 'pagination_meta';

    return <String, dynamic>{itemsKey ?? 'data': items.map(mapT).toList(), metaKey: meta?.toMap()};
  }
}
