sealed class DataUnion<T> {
  const DataUnion();

  dynamic toMap(Object Function(T) mapper);

  R when<R>({required R Function(T single) single, required R Function(List<T> list) list});

  T get single;
  List<T> get list;
}

class SingleData<T> extends DataUnion<T> {
  const SingleData(this.value);

  final T value;

  @override
  List<T> get list => [value];

  @override
  T get single => value;

  @override
  dynamic toMap(Object Function(T) mapper) {
    return mapper(value);
  }

  @override
  R when<R>({required R Function(T single) single, required R Function(List<T> list) list}) {
    return single(value);
  }
}

class ListData<T> extends DataUnion<T> {
  const ListData(this.values);

  final List<T> values;

  @override
  List<T> get list => values;

  @override
  T get single => values.first;

  @override
  dynamic toMap(Object Function(T) mapper) {
    return values.map(mapper).toList();
  }

  @override
  R when<R>({required R Function(T single) single, required R Function(List<T> list) list}) {
    return list(values);
  }
}
