// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'theme_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeStore)
final themeStoreProvider = ThemeStoreProvider._();

final class ThemeStoreProvider
    extends $AsyncNotifierProvider<ThemeStore, bool> {
  ThemeStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeStoreHash();

  @$internal
  @override
  ThemeStore create() => ThemeStore();
}

String _$themeStoreHash() => r'0af5ff1a4873d2494fc8f25d54569329ae18610e';

abstract class _$ThemeStore extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
