import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/user_service/user_service.dart';
import 'login_form.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  AsyncValue<bool> build() {
    // Começa sem fazer nada (não está carregando, não tem erro)
    return const AsyncData(false);
  }

  Future<void> submitLogin() async {
    // Lê o estado atual do formulário
    final formState = ref.read(loginFormProvider);

    if (!formState.canLogin) return;

    // Coloca a UI em estado de loading
    state = const AsyncLoading();

    // Executa a chamada. Se der erro (AppApiException), o AsyncValue.guard
    // converte magicamente o estado para AsyncError.
    state = await AsyncValue.guard(() async {
      final userService = ref.read(userServiceProvider);
      return await userService.login(formState.email, formState.senha);
    });
  }
}
