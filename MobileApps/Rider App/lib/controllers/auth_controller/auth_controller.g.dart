// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginHash() => r'c3a2e69cdc14b35bed8b90a8bafa183ed1a1a24d';

/// See also [Login].
@ProviderFor(Login)
final loginProvider = AutoDisposeNotifierProvider<Login, bool>.internal(
  Login.new,
  name: r'loginProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Login = AutoDisposeNotifier<bool>;
String _$sendOTPHash() => r'2625bd1459f6b9ba594a12297fda0d4d51966533';

/// See also [SendOTP].
@ProviderFor(SendOTP)
final sendOTPProvider = AutoDisposeNotifierProvider<SendOTP, bool>.internal(
  SendOTP.new,
  name: r'sendOTPProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sendOTPHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SendOTP = AutoDisposeNotifier<bool>;
String _$verifyOTPHash() => r'6418bad986aa5fa479cbb0432dedd440ac1f2b9e';

/// See also [VerifyOTP].
@ProviderFor(VerifyOTP)
final verifyOTPProvider = AutoDisposeNotifierProvider<VerifyOTP, bool>.internal(
  VerifyOTP.new,
  name: r'verifyOTPProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$verifyOTPHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VerifyOTP = AutoDisposeNotifier<bool>;
String _$registrationHash() => r'2c320fa250df456c07a282a1c719c936b042f82e';

/// See also [Registration].
@ProviderFor(Registration)
final registrationProvider =
    AutoDisposeNotifierProvider<Registration, bool>.internal(
  Registration.new,
  name: r'registrationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$registrationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Registration = AutoDisposeNotifier<bool>;
String _$checkUserStatusHash() => r'a58b5095f498cd6f1e22b22acc03d0f11abb150d';

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

abstract class _$CheckUserStatus extends BuildlessAutoDisposeNotifier<void> {
  late final String arg;

  void build(
    String arg,
  );
}

/// See also [CheckUserStatus].
@ProviderFor(CheckUserStatus)
const checkUserStatusProvider = CheckUserStatusFamily();

/// See also [CheckUserStatus].
class CheckUserStatusFamily extends Family<void> {
  /// See also [CheckUserStatus].
  const CheckUserStatusFamily();

  /// See also [CheckUserStatus].
  CheckUserStatusProvider call(
    String arg,
  ) {
    return CheckUserStatusProvider(
      arg,
    );
  }

  @override
  CheckUserStatusProvider getProviderOverride(
    covariant CheckUserStatusProvider provider,
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
  String? get name => r'checkUserStatusProvider';
}

/// See also [CheckUserStatus].
class CheckUserStatusProvider
    extends AutoDisposeNotifierProviderImpl<CheckUserStatus, void> {
  /// See also [CheckUserStatus].
  CheckUserStatusProvider(
    String arg,
  ) : this._internal(
          () => CheckUserStatus()..arg = arg,
          from: checkUserStatusProvider,
          name: r'checkUserStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkUserStatusHash,
          dependencies: CheckUserStatusFamily._dependencies,
          allTransitiveDependencies:
              CheckUserStatusFamily._allTransitiveDependencies,
          arg: arg,
        );

  CheckUserStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final String arg;

  @override
  void runNotifierBuild(
    covariant CheckUserStatus notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(CheckUserStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: CheckUserStatusProvider._internal(
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
  AutoDisposeNotifierProviderElement<CheckUserStatus, void> createElement() {
    return _CheckUserStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckUserStatusProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CheckUserStatusRef on AutoDisposeNotifierProviderRef<void> {
  /// The parameter `arg` of this provider.
  String get arg;
}

class _CheckUserStatusProviderElement
    extends AutoDisposeNotifierProviderElement<CheckUserStatus, void>
    with CheckUserStatusRef {
  _CheckUserStatusProviderElement(super.provider);

  @override
  String get arg => (origin as CheckUserStatusProvider).arg;
}

String _$logOutHash() => r'78947f71741b1218b91facaa879b6e3399b7feeb';

/// See also [LogOut].
@ProviderFor(LogOut)
final logOutProvider = AutoDisposeNotifierProvider<LogOut, bool>.internal(
  LogOut.new,
  name: r'logOutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logOutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LogOut = AutoDisposeNotifier<bool>;
String _$createPasswordHash() => r'98bec77cc1dbd7bc85f3e7484b163c3f8e7e0195';

/// See also [CreatePassword].
@ProviderFor(CreatePassword)
final createPasswordProvider =
    AutoDisposeNotifierProvider<CreatePassword, bool>.internal(
  CreatePassword.new,
  name: r'createPasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createPasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreatePassword = AutoDisposeNotifier<bool>;
String _$userDetilsHash() => r'8f3beefbec4b99448bfb055f46a83cfdb0b46d1e';

/// See also [UserDetils].
@ProviderFor(UserDetils)
final userDetilsProvider = AsyncNotifierProvider<UserDetils, void>.internal(
  UserDetils.new,
  name: r'userDetilsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userDetilsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserDetils = AsyncNotifier<void>;
String _$changePasswordHash() => r'6b029fb0df845c6299c8dd52a71dc52b169f3846';

/// See also [ChangePassword].
@ProviderFor(ChangePassword)
final changePasswordProvider =
    AutoDisposeNotifierProvider<ChangePassword, bool>.internal(
  ChangePassword.new,
  name: r'changePasswordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$changePasswordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChangePassword = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
