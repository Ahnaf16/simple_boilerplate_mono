import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:resta_dash/main.export.dart';

extension type Mock<T>(T _v) {
  T get(T d) => kDebugMode ? _v : d;
  T? getOrNull() => kDebugMode ? _v : null;
}

class MockData {
  MockData._();

  static final _rnd = faker.randomGenerator;

  static Mock<List<Branch>> get branches => Mock<List<Branch>>(
    List.generate(5, (index) {
      final fk = Faker(seed: index);
      return Branch(
        name: fk.food.restaurant(),
        image: fk.image.loremPicsum(random: index),
        available: _rnd.boolean(),
        address: fk.address.streetAddress(),
      );
    }),
  );

  static Mock<User> get user => Mock<User>(
    User(name: faker.person.name(), photo: faker.image.loremPicsum(), email: faker.internet.email(), id: 1),
  );

  static Mock<List<Dish>> get dishes {
    final dishes = [
      Dish(
        id: 1,
        name: 'Banana Pancake',
        shortDescription: 'Nutritious, fiber-rich, and wholesome loaves.',
        description:
            'Imagine a delightful soft blue donut, perfectly baked to achieve that fluffy texture, and generously adorned with vibrant pink sprinkles that catch the eye.',
        price: 9.50,
        discountPrice: 0,
        haveDiscount: false,
        imageUrl: _foods[0],
        cuisine: cuisine._v[0 % cuisine._v.length],
        note: 'Customer is allergic to nuts. Ensure no cross-contamination.',
        isPopular: true,
        variations: variations._v.getRandomList(_rnd.integer(3, min: 1)),
      ),
      Dish(
        id: 2,
        name: 'Classic Cheeseburger',
        shortDescription: 'Juicy beef patty with melted cheddar cheese.',
        description:
            'A freshly grilled beef patty topped with melted cheddar, crisp lettuce, ripe tomatoes, and a toasted sesame bun.',
        price: 12.00,
        discountPrice: 10.00,
        haveDiscount: true,
        imageUrl: _foods[1],
        cuisine: cuisine._v[1 % cuisine._v.length],
        note: 'Cook medium-well unless otherwise requested.',
        isPopular: true,
        variations: variations._v.getRandomList(_rnd.integer(3, min: 1)),
      ),
      Dish(
        id: 3,
        name: 'Spaghetti Carbonara',
        shortDescription: 'Creamy pasta with parmesan and pancetta.',
        description:
            'Rich, creamy spaghetti made with fresh eggs, grated parmesan, crispy pancetta, and a hint of black pepper.',
        price: 14.50,
        discountPrice: 0,
        haveDiscount: false,
        imageUrl: _foods[2],
        cuisine: cuisine._v[2 % cuisine._v.length],
        note: 'Contains dairy and pork.',
        variations: variations._v.getRandomList(_rnd.integer(3, min: 1)),
      ),
      Dish(
        id: 4,
        name: 'Grilled Salmon',
        shortDescription: 'Tender salmon fillet with lemon butter sauce.',
        description:
            'Perfectly grilled salmon served with a tangy lemon butter sauce and a side of steamed vegetables.',
        price: 18.75,
        discountPrice: 16.50,
        haveDiscount: true,
        imageUrl: _foods[3],
        cuisine: cuisine._v[3 % cuisine._v.length],
        note: 'Remove lemon for citrus allergies.',
        isPopular: true,
        variations: variations._v.getRandomList(_rnd.integer(3, min: 1)),
      ),
      Dish(
        id: 5,
        name: 'Margherita Pizza',
        shortDescription: 'Fresh mozzarella, basil, and tomato sauce.',
        description:
            'A classic Italian pizza with fresh mozzarella cheese, ripe tomatoes, basil leaves, and a crispy thin crust.',
        price: 11.00,
        discountPrice: 0,
        haveDiscount: false,
        imageUrl: _foods[4],
        cuisine: cuisine._v[4 % cuisine._v.length],
        note: 'Vegetarian-friendly.',
        variations: variations._v.getRandomList(_rnd.integer(3, min: 1)),
      ),
      Dish(
        id: 6,
        name: 'Caesar Salad',
        shortDescription: 'Crisp romaine lettuce with creamy dressing.',
        description: 'Fresh romaine lettuce, crunchy croutons, parmesan cheese, and a creamy Caesar dressing.',
        price: 8.50,
        discountPrice: 7.00,
        haveDiscount: true,
        imageUrl: _foods[5],
        cuisine: cuisine._v[5 % cuisine._v.length],
        note: 'Contains anchovies.',
        variations: variations._v.getRandomList(_rnd.integer(3, min: 1)),
      ),
      Dish(
        id: 7,
        name: 'Beef Tacos',
        shortDescription: 'Seasoned beef with fresh toppings.',
        description: 'Crispy taco shells filled with seasoned beef, fresh lettuce, diced tomatoes, cheese, and salsa.',
        price: 10.00,
        discountPrice: 0,
        haveDiscount: false,
        imageUrl: _foods[6],
        cuisine: cuisine._v[6 % cuisine._v.length],
        note: 'Mild spice by default, can be made extra spicy.',
        isPopular: true,
        variations: variations._v.getRandomList(_rnd.integer(3, min: 1)),
      ),
      Dish(
        id: 8,
        name: 'Chicken Biryani',
        shortDescription: 'Fragrant rice with spiced chicken.',
        description: 'Aromatic basmati rice layered with tender chicken, saffron, and a blend of spices.',
        price: 13.25,
        discountPrice: 11.00,
        haveDiscount: true,
        imageUrl: _foods[7],
        cuisine: cuisine._v[7 % cuisine._v.length],
        note: 'Contains whole spices.',
        isPopular: true,
        variations: variations._v.getRandomList(_rnd.integer(3, min: 1)),
      ),
      Dish(
        id: 9,
        name: 'Vegetable Stir Fry',
        shortDescription: 'Mixed vegetables in savory soy sauce.',
        description: 'Fresh seasonal vegetables stir-fried with garlic, ginger, and a savory soy sauce glaze.',
        price: 9.00,
        discountPrice: 0,
        haveDiscount: false,
        imageUrl: _foods[8],
        cuisine: cuisine._v[8 % cuisine._v.length],
        note: 'Vegan-friendly.',
        variations: variations._v.getRandomList(_rnd.integer(3, min: 1)),
      ),
      Dish(
        id: 10,
        name: 'Butter Chicken',
        shortDescription: 'Rich and creamy Indian curry.',
        description: 'Tender chicken pieces cooked in a creamy tomato-based sauce with aromatic spices.',
        price: 15.00,
        discountPrice: 13.00,
        haveDiscount: true,
        imageUrl: _foods[9],
        cuisine: cuisine._v[9 % cuisine._v.length],
        note: 'Pairs well with naan bread.',
        isPopular: true,
        variations: variations._v.getRandomList(_rnd.integer(3, min: 1)),
      ),
    ];

    final randomDishes = dishes.map((e) {
      return _rnd.boolean()
          ? e.copyWith(boughTogether: dishes.where((x) => x.id != e.id).takeFirst(_rnd.integer(3, min: 1)))
          : e;
    }).toList();

    return Mock<List<Dish>>(randomDishes);
  }

  static Mock<List<Variation>> get variations => Mock<List<Variation>>([
    Variation(id: 1, name: 'Extra cheese', price: _rnd.integer(40, min: 1).toDouble()),
    Variation(id: 2, name: 'Cheese Dumpling', price: _rnd.integer(40, min: 1).toDouble()),
    Variation(id: 3, name: 'Spicy', price: _rnd.integer(40, min: 1).toDouble()),
    Variation(id: 4, name: 'Extra Spicy', price: _rnd.integer(40, min: 1).toDouble()),
  ]);

  static Mock<List<Cuisine>> get cuisine => Mock<List<Cuisine>>([
    Cuisine(id: 1, name: 'Sushi', image: _cuisine[0]),
    Cuisine(id: 2, name: 'Wagyu', image: _cuisine[1]),
    Cuisine(id: 3, name: 'Sashimi', image: _cuisine[2]),
    Cuisine(id: 4, name: 'BBQ', image: _cuisine[3]),
    Cuisine(id: 5, name: 'Noodle', image: _cuisine[4]),
  ]);

  static Mock<List<PromoBanner>> get banners => Mock<List<PromoBanner>>([PromoBanner(imageUrl: _banner[0])]);

  static Mock<HomeData> get homeData =>
      Mock<HomeData>(HomeData(cuisines: cuisine._v, banners: banners._v, popularDishes: dishes._v.takeFirst(5)));

  static Mock<Config> get config => Mock<Config>(
    Config(
      onboarding: [
        OnboardingData(
          title: 'Join now and launch your sales quickly',
          description: 'With just a few simple steps, you can reach new customers and begin selling almost immediately',
          image: _onboards[0],
        ),
        OnboardingData(
          title: 'Join now and launch your sales quickly',
          description: 'With just a few simple steps, you can reach new customers and begin selling almost immediately',
          image: _onboards[1],
        ),
        OnboardingData(
          title: 'Join now and launch your sales quickly',
          description: 'With just a few simple steps, you can reach new customers and begin selling almost immediately',
          image: _onboards[2],
        ),
      ],
      tables: const [
        TableModel(id: 0, name: 'Table 1', size: TableSize.medium, position: 1, isAvailable: true),
        TableModel(id: 1, name: 'Table 2', size: TableSize.medium, position: 1, isAvailable: false),
        TableModel(id: 2, name: 'Table 3', size: TableSize.large, position: 2, isAvailable: true),
        TableModel(id: 3, name: 'Table 4', size: TableSize.large, position: 2, isAvailable: true),
        TableModel(id: 4, name: 'Table 5', size: TableSize.small, position: 3, isAvailable: false),
        TableModel(id: 5, name: 'Table 6', size: TableSize.small, position: 3, isAvailable: false),
        TableModel(id: 6, name: 'Table 7', size: TableSize.small, position: 3, isAvailable: true),
        TableModel(id: 7, name: 'Table 8', size: TableSize.medium, position: 4, isAvailable: true),
        TableModel(id: 8, name: 'Table 9', size: TableSize.small, position: 4, isAvailable: false),
        TableModel(id: 9, name: 'Table 10', size: TableSize.medium, position: 4, isAvailable: true),
      ],
    ),
  );
}

final _onboards = [
  'https://i.ibb.co.com/jvtW8LVp/oneboard3.png',
  'https://i.ibb.co.com/NdCsL5jH/oneboard2.png',
  'https://i.ibb.co.com/99FYhcvx/oneboard1.png',
];
final _banner = ['https://i.ibb.co.com/fYKVK1yT/banner1.png'];
final _cuisine = [
  'https://i.ibb.co.com/fY4SpBjh/wagyu.png',
  'https://i.ibb.co.com/1fwKg7gF/sushi.png',
  'https://i.ibb.co.com/zhcKtZxz/sashimi.png',
  'https://i.ibb.co.com/JWChPZdj/bbq.png',
  'https://i.ibb.co.com/wN1txYVk/noodle.png',
];
final _foods = [
  'https://i.ibb.co.com/xtYtQpwp/banana-Pancake.png',
  'https://i.ibb.co.com/Sw32RnyS/sweet-Berry.png',
  'https://i.ibb.co.com/MkK9x43m/food3.jpg',
  'https://i.ibb.co.com/1YpwmpVt/food4.png',
  'https://i.ibb.co.com/TMQb5tXp/food5.png',
  'https://i.ibb.co.com/yn1kpkpm/food6.png',
  'https://i.ibb.co.com/GvtVpND9/food7.png',
  'https://i.ibb.co.com/DHKq6wXx/food8.png',
  'https://i.ibb.co.com/s9xPzr53/food9.jpg',
  'https://i.ibb.co.com/jvtW8LVp/oneboard3.png',
];
