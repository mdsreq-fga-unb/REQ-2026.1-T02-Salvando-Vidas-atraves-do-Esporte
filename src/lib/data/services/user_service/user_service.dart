import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';

import '../../supabase_call.dart';
import '../global/global_service.dart';

part 'user_service.g.dart';

@Riverpod(keepAlive: true)
UserService userService(Ref ref) {
  return UserService(ref.watch(supabaseClientProvider));
}

class UserService {
  final SupabaseClient _supabase;
  LocalUser? localUser;

  UserService(this._supabase);

  Future<bool> login(String email, String password) async {
    final authResponse = await runSupabaseCall(() async {
      return _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    });

    if (authResponse.user == null) return false;

    localUser = await getLocalUser(authResponse.user!);
    return localUser != null;
  }

  Future<void> logout() async {
    await runSupabaseCall(() async {
      await _supabase.auth.signOut().withDefaultTimeout();
      localUser = null;
    });
  }

  Future<bool> isLoggedIn() async {
    User? user = _supabase.auth.currentUser;
    if (user == null) return false;

    localUser = await getLocalUser(user);
    return localUser != null;
  }

  Future<LocalUser?> getLocalUser(User user) async {
    return runSupabaseCall(() async {
      final data = await _supabase.from('users').select().eq('id', user.id);

      if (data.isNotEmpty) {
        return LocalUser.fromMap(data.first);
      }
      return null;
    });
  }

  Future<List<LocalUser>> listUsers() async {
    return runSupabaseCall(() async {
      final res = await _supabase.from('users').select();
      return res.map((data) => LocalUser.fromMap(data)).toList();
    });
  }

  Future<void> registerUser(LocalUser user) async {
    return runSupabaseCall(() async {
      await _supabase.rpc('admin_create_user', params: user.toMap());
    });
  }

  Future<void> deleteUser(String id) async {
    return runSupabaseCall(() async {
      await _supabase.rpc('admin_delete_user', params: {'target_user_id': id});
    });
  }

  Future<void> updateUser({
    required String id,
    String? email,
    String? password,
    String? nome,
    String? telefone,
    String? cpf,
  }) async {
    return runSupabaseCall(() async {
      await _supabase.rpc(
        'admin_update_user',
        params: {
          'target_user_id': id,
          'new_email': email,
          'new_password': password,
          'new_name': nome,
          'new_telefone': telefone,
          'new_cpf': cpf,
        },
      );
    });
  }

  bool get isAdmin => localUser != null ? localUser!.role == Role.admin : false;
}
