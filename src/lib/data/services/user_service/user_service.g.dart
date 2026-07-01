// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'user_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalUserNotifier)
final localUserProvider = LocalUserNotifierProvider._();

final class LocalUserNotifierProvider
    extends $NotifierProvider<LocalUserNotifier, LocalUser?> {
  LocalUserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localUserNotifierHash();

  @$internal
  @override
  LocalUserNotifier create() => LocalUserNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalUser? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalUser?>(value),
    );
  }
}

String _$localUserNotifierHash() => r'e968582e8fe16062c2c87c5c79647357f10ede2b';

abstract class _$LocalUserNotifier extends $Notifier<LocalUser?> {
  LocalUser? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<LocalUser?, LocalUser?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LocalUser?, LocalUser?>,
              LocalUser?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(userService)
final userServiceProvider = UserServiceProvider._();

final class UserServiceProvider
    extends $FunctionalProvider<UserService, UserService, UserService>
    with $Provider<UserService> {
  UserServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userServiceHash();

  @$internal
  @override
  $ProviderElement<UserService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserService create(Ref ref) {
    return userService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserService>(value),
    );
  }
}

String _$userServiceHash() => r'd1fcd37777fa5759f69f7ba3ab1dfdf0e36f40e0';
