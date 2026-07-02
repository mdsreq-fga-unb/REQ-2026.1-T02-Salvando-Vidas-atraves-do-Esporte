// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'cadastro_voluntario_form.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CadastroVoluntario)
final cadastroVoluntarioProvider = CadastroVoluntarioProvider._();

final class CadastroVoluntarioProvider
    extends $NotifierProvider<CadastroVoluntario, CadastroVoluntarioState> {
  CadastroVoluntarioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cadastroVoluntarioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cadastroVoluntarioHash();

  @$internal
  @override
  CadastroVoluntario create() => CadastroVoluntario();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CadastroVoluntarioState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CadastroVoluntarioState>(value),
    );
  }
}

String _$cadastroVoluntarioHash() =>
    r'3b6bf4d16fe5eae41f559bce08f7a0ee6231d4c5';

abstract class _$CadastroVoluntario extends $Notifier<CadastroVoluntarioState> {
  CadastroVoluntarioState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<CadastroVoluntarioState, CadastroVoluntarioState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CadastroVoluntarioState, CadastroVoluntarioState>,
              CadastroVoluntarioState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
