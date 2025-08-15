import 'package:hive_ce/hive.dart';

// part 'hive_db.g.dart';

class BoxName<T> {
  const BoxName(this.name);
  final String name;

  Future<Box<T>> safeBox() async {
    if (Hive.isBoxOpen(name)) return box;
    return Hive.openBox<T>(name);
  }

  Box<T> get box => Hive.box<T>(name);
}

@GenerateAdapters([
  // AdapterSpec<User>(),
  // AdapterSpec<Cuisine>(),
  // AdapterSpec<DailySpecial>(),
  // AdapterSpec<Dish>(),
  // AdapterSpec<HomeData>(),
])
class HiveDB {
  // static const users = BoxName<User>('users');
  // static const homeData = BoxName<HomeData>('home');
}
