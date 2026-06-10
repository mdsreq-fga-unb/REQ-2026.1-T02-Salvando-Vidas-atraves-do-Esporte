// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'cadastro_voluntario_form.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CadastroVoluntarioForm)
final cadastroVoluntarioFormProvider = CadastroVoluntarioFormProvider._();

final class CadastroVoluntarioFormProvider
    extends
        $NotifierProvider<CadastroVoluntarioForm, CadastroVoluntarioFormState> {
  CadastroVoluntarioFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cadastroVoluntarioFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cadastroVoluntarioFormHash();

  @$internal
  @override
  CadastroVoluntarioForm create() => CadastroVoluntarioForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CadastroVoluntarioFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CadastroVoluntarioFormState>(value),
    );
  }
}

String _$cadastroVoluntarioFormHash() =>
    r'825b51389a29a875186d52424f86698a9b1e7610';

abstract class _$CadastroVoluntarioForm
    extends $Notifier<CadastroVoluntarioFormState> {
  CadastroVoluntarioFormState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<CadastroVoluntarioFormState, CadastroVoluntarioFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                CadastroVoluntarioFormState,
                CadastroVoluntarioFormState
              >,
              CadastroVoluntarioFormState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
