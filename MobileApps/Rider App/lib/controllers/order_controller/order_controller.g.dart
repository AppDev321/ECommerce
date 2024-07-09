// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderListHash() => r'68f4396e23ede8b0d8d6401e3e718f3602a16d53';

/// See also [OrderList].
@ProviderFor(OrderList)
final orderListProvider =
    AutoDisposeAsyncNotifierProvider<OrderList, OrderState>.internal(
  OrderList.new,
  name: r'orderListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderList = AutoDisposeAsyncNotifier<OrderState>;
String _$orderDetailsHash() => r'2591bd39f0f7854a45b1a2ef874b8544c0eae13f';

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

abstract class _$OrderDetails
    extends BuildlessAutoDisposeAsyncNotifier<OrderDetailsModel> {
  late final int arg;

  FutureOr<OrderDetailsModel> build(
    int arg,
  );
}

/// See also [OrderDetails].
@ProviderFor(OrderDetails)
const orderDetailsProvider = OrderDetailsFamily();

/// See also [OrderDetails].
class OrderDetailsFamily extends Family<AsyncValue<OrderDetailsModel>> {
  /// See also [OrderDetails].
  const OrderDetailsFamily();

  /// See also [OrderDetails].
  OrderDetailsProvider call(
    int arg,
  ) {
    return OrderDetailsProvider(
      arg,
    );
  }

  @override
  OrderDetailsProvider getProviderOverride(
    covariant OrderDetailsProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'orderDetailsProvider';
}

/// See also [OrderDetails].
class OrderDetailsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    OrderDetails, OrderDetailsModel> {
  /// See also [OrderDetails].
  OrderDetailsProvider(
    int arg,
  ) : this._internal(
          () => OrderDetails()..arg = arg,
          from: orderDetailsProvider,
          name: r'orderDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderDetailsHash,
          dependencies: OrderDetailsFamily._dependencies,
          allTransitiveDependencies:
              OrderDetailsFamily._allTransitiveDependencies,
          arg: arg,
        );

  OrderDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final int arg;

  @override
  FutureOr<OrderDetailsModel> runNotifierBuild(
    covariant OrderDetails notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(OrderDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: OrderDetailsProvider._internal(
        () => create()..arg = arg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<OrderDetails, OrderDetailsModel>
      createElement() {
    return _OrderDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderDetailsProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrderDetailsRef
    on AutoDisposeAsyncNotifierProviderRef<OrderDetailsModel> {
  /// The parameter `arg` of this provider.
  int get arg;
}

class _OrderDetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OrderDetails,
        OrderDetailsModel> with OrderDetailsRef {
  _OrderDetailsProviderElement(super.provider);

  @override
  int get arg => (origin as OrderDetailsProvider).arg;
}

String _$orderStatusUpdateHash() => r'a1b442877797384238454d04ce245260aaac076d';

/// See also [OrderStatusUpdate].
@ProviderFor(OrderStatusUpdate)
final orderStatusUpdateProvider =
    AutoDisposeNotifierProvider<OrderStatusUpdate, bool>.internal(
  OrderStatusUpdate.new,
  name: r'orderStatusUpdateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderStatusUpdateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderStatusUpdate = AutoDisposeNotifier<bool>;
String _$orderHistoryHash() => r'b01cf7206805b9eee56a13aa46a060a4bc7727d3';

/// See also [OrderHistory].
@ProviderFor(OrderHistory)
final orderHistoryProvider =
    AutoDisposeAsyncNotifierProvider<OrderHistory, OrderHistoryState>.internal(
  OrderHistory.new,
  name: r'orderHistoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderHistory = AutoDisposeAsyncNotifier<OrderHistoryState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
