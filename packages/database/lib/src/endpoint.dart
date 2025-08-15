extension type const EndPoint(String value) implements String {
  String queryParams(Map<String, String> query) {
    return '$this?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}';
  }

  String get name => replaceAll('/', '');
}
