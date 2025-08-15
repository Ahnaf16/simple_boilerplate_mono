import 'package:resta_dash/main.export.dart';

class Pagination extends Model {
  const Pagination({
    required this.totalPage,
    required this.parPage,
    required this.currentPage,
    required this.lastPage,
    required this.from,
    required this.to,
    required this.prevURL,
    required this.nextURL,
    required this.currentURL,
  });

  final String? prevURL, nextURL;
  final String currentURL;
  final int totalPage, parPage, currentPage, lastPage, from, to;

  static Pagination? fromMap(dynamic value) {
    if (value case final Map map) {
      return Pagination(
        totalPage: map.parseInt('total'),
        parPage: map.parseInt('per_page'),
        currentPage: map.parseInt('current_page'),
        lastPage: map.parseInt('last_page'),
        from: map.parseInt('from'),
        to: map.parseInt('to'),
        prevURL: map['prev_page_url'],
        nextURL: map['next_page_url'],
        currentURL: map['path'] ?? '',
      );
    }
    if (value case final Pagination p) return p;
    return null;
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': totalPage,
      'per_page': parPage,
      'current_page': currentPage,
      'last_page': lastPage,
      'from': from,
      'to': to,
      'prev_page_url': prevURL,
      'next_page_url': nextURL,
      'path': currentURL,
    };
  }
}
