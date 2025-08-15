// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeDataCtrlHash() => r'b4056725d7b1afe5ff3a2b847f5a49646570f924';

/// See also [HomeDataCtrl].
@ProviderFor(HomeDataCtrl)
final homeDataCtrlProvider =
    AutoDisposeStreamNotifierProvider<HomeDataCtrl, HomeData>.internal(
      HomeDataCtrl.new,
      name: r'homeDataCtrlProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$homeDataCtrlHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HomeDataCtrl = AutoDisposeStreamNotifier<HomeData>;
String _$dishesCtrlHash() => r'71ac5221c84e0c93ec55a6a27b854caf227ac5f1';

/// See also [DishesCtrl].
@ProviderFor(DishesCtrl)
final dishesCtrlProvider =
    AutoDisposeAsyncNotifierProvider<DishesCtrl, List<Dish>>.internal(
      DishesCtrl.new,
      name: r'dishesCtrlProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$dishesCtrlHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DishesCtrl = AutoDisposeAsyncNotifier<List<Dish>>;
String _$dishDetailsCtrlHash() => r'7f8bae81b2a5dbe6d8ac7c9abb8c99058bb1a22c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DishDetailsCtrl
    extends BuildlessAutoDisposeAsyncNotifier<Dish?> {
  late final int id;

  FutureOr<Dish?> build(int id);
}

/// See also [DishDetailsCtrl].
@ProviderFor(DishDetailsCtrl)
const dishDetailsCtrlProvider = DishDetailsCtrlFamily();

/// See also [DishDetailsCtrl].
class DishDetailsCtrlFamily extends Family<AsyncValue<Dish?>> {
  /// See also [DishDetailsCtrl].
  const DishDetailsCtrlFamily();

  /// See also [DishDetailsCtrl].
  DishDetailsCtrlProvider call(int id) {
    return DishDetailsCtrlProvider(id);
  }

  @override
  DishDetailsCtrlProvider getProviderOverride(
    covariant DishDetailsCtrlProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dishDetailsCtrlProvider';
}

/// See also [DishDetailsCtrl].
class DishDetailsCtrlProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DishDetailsCtrl, Dish?> {
  /// See also [DishDetailsCtrl].
  DishDetailsCtrlProvider(int id)
    : this._internal(
        () => DishDetailsCtrl()..id = id,
        from: dishDetailsCtrlProvider,
        name: r'dishDetailsCtrlProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$dishDetailsCtrlHash,
        dependencies: DishDetailsCtrlFamily._dependencies,
        allTransitiveDependencies:
            DishDetailsCtrlFamily._allTransitiveDependencies,
        id: id,
      );

  DishDetailsCtrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<Dish?> runNotifierBuild(covariant DishDetailsCtrl notifier) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(DishDetailsCtrl Function() create) {
    return ProviderOverride(
      origin: this,
      override: DishDetailsCtrlProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DishDetailsCtrl, Dish?>
  createElement() {
    return _DishDetailsCtrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DishDetailsCtrlProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DishDetailsCtrlRef on AutoDisposeAsyncNotifierProviderRef<Dish?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _DishDetailsCtrlProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DishDetailsCtrl, Dish?>
    with DishDetailsCtrlRef {
  _DishDetailsCtrlProviderElement(super.provider);

  @override
  int get id => (origin as DishDetailsCtrlProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
