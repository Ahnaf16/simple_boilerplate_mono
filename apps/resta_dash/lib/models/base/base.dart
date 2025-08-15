import 'package:equatable/equatable.dart';
import 'package:resta_dash/main.export.dart';

typedef BaseReport<T> = FutureReport<Base<T>>;

T baseSingle<T>(Base<T> b) => b.data.single;
List<T> baseList<T>(Base<T> b) => b.data.list;

PagedItem<T> basePage<T>(Base<T> b) => PagedItem.fromPagination(b.data.list, b.extra);

class Base<T> {
  const Base({
    required this.statusCode,
    required this.message,
    required this.isSuccess,
    required this.data,
    this.extra = const {},
  });

  factory Base.fromMap(Map<String, dynamic> map, T Function(QMap map) mapper, [String? key]) {
    final rawData = map[key ?? 'data'];
    final data = (rawData is List)
        ? ListData<T>(rawData.map((item) => mapper(item)).toList())
        : SingleData<T>(mapper(rawData));

    final base = Base<T>(
      data: data,
      message: map['message']?.toString() ?? '',
      statusCode: map.parseInt('code'),
      isSuccess: map.parseBool('success'),
      extra: Map<String, dynamic>.of(map)
        ..removeWhere((k, v) => k == 'data' || k == 'success' || k == 'message' || k == 'code'),
    );

    return base;
  }

  Base.single(T data, [this.extra = const {}])
    : data = SingleData(data),
      isSuccess = true,
      message = 'Success',
      statusCode = 200;

  Base.list(List<T> data, [this.extra = const {}])
    : data = ListData(data),
      isSuccess = true,
      message = 'Success',
      statusCode = 200;

  final DataUnion<T> data;
  final QMap extra;
  final bool isSuccess;
  final String message;
  final int statusCode;

  String? get eventKey => extra.get('event');

  Option<R> mapExtra<R>(String path, R Function(QMap m) extraMap) {
    if (extra.isEmpty) return none();
    final v = extra.get(path);
    return some(extraMap(v));
  }

  Map<String, dynamic> toMap(ToMapT<T> mapper) {
    return {
      'success': isSuccess,
      'code': statusCode,
      'message': message,
      'data': data.toMap(mapper),
      for (final e in extra.entries)
        if (e.value is Model) e.key: (e.value as Model).toMap() else e.key: e.value.toString(),
    };
  }
}

abstract class Model extends Equatable {
  const Model();

  Map<String, dynamic> toMap();

  @override
  List<Object?> get props => toMap().values.toList();

  @override
  String toString() => toMap().toString();
}
