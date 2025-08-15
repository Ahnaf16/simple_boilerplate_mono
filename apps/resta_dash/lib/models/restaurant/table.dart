import 'package:resta_dash/main.export.dart';

enum TableSize {
  small,
  medium,
  large;

  int get capacity => switch (this) {
    TableSize.small => 2,
    TableSize.medium => 4,
    TableSize.large => 6,
  };
  double get width => switch (this) {
    TableSize.small => 60,
    TableSize.medium => 110,
    TableSize.large => 160,
  };
  double get radius => switch (this) {
    TableSize.small => Corners.circle,
    TableSize.medium => Corners.lg,
    TableSize.large => Corners.lg,
  };
}

class TableModel extends Model {
  const TableModel({
    required this.id,
    required this.name,
    // required this.capacity,
    required this.size,
    required this.position,
    required this.isAvailable,
  });
  final int id;
  final String name;
  final TableSize size;
  // final int capacity;
  final int position;
  final bool isAvailable;

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map.parseInt('id'),
      name: map['name'],
      size: TableSize.values.byName(map['size']),
      // capacity: map.parseInt('capacity'),
      position: map.parseInt('position'),
      isAvailable: map.parseBool('is_available'),
    );
  }

  static TableModel? tryParse(dynamic value) {
    try {
      if (value case final TableModel d) return d;
      if (value case final Map map) return TableModel.fromMap(map.toStringKey());
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'position': position,
    'size': size.name,
    // 'capacity': capacity,
    'is_available': isAvailable,
  };
}
