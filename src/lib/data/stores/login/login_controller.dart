import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../services/user_service/user_service.dart';
import 'login_form.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  AsyncValue<bool> build() {
    return const AsyncData(false);
  }

  Future<void> submitLogin() async {
    final formState = ref.read(loginFormProvider);

    if (!formState.canLogin) return;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final userService = ref.read(userServiceProvider);
      return await userService.login(formState.email, formState.senha);
    });
  }
}
