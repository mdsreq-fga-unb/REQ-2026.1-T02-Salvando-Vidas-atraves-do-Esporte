// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'update_voluntario_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UpdateVoluntario)
final updateVoluntarioProvider = UpdateVoluntarioProvider._();

final class UpdateVoluntarioProvider
    extends $NotifierProvider<UpdateVoluntario, UpdateVoluntarioState> {
  UpdateVoluntarioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateVoluntarioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateVoluntarioHash();

  @$internal
  @override
  UpdateVoluntario create() => UpdateVoluntario();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateVoluntarioState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateVoluntarioState>(value),
    );
  }
}

String _$updateVoluntarioHash() => r'de42dbe4247a8690294638e53ba2466a16325412';

abstract class _$UpdateVoluntario extends $Notifier<UpdateVoluntarioState> {
  UpdateVoluntarioState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UpdateVoluntarioState, UpdateVoluntarioState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UpdateVoluntarioState, UpdateVoluntarioState>,
              UpdateVoluntarioState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
