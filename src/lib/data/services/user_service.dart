import 'package:salvando_vidas/domain/local_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final SupabaseClient _supabase;
  LocalUser? localUser;

  UserService(this._supabase);

  Future<bool> login(String email, String password) async {
    try {
      final res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user != null) {
        localUser = await getLocalUser(res.user!);
        return localUser != null;
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }

  void logout() async {
    await _supabase.auth.signOut();
  }

  Future<bool> isLoggedIn() async {
    User? user = _supabase.auth.currentUser;

    if (user != null) {
      localUser = await getLocalUser(user);
      return localUser != null;
    }

    return false;
  }

  Future<LocalUser?> getLocalUser(User user) async {
    final data = await _supabase.from('users').select().eq('id', user.id);
    if (data.isNotEmpty) {
      return LocalUser(
        data[0]["nome"],
        data[0]["role"] == "admin" ? Role.admin : Role.voluntario,
      );
    }

    return null;
  }

  Future<bool> registerUser(
    String email,
    String password,
    String nome,
    String telefone,
    String cpf,
  ) async {
    try {
      final data = await _supabase.rpc(
        'admin_create_user',
        params: {
          'new_email': email,
          'new_password': password,
          'new_role': 'voluntario',
          'new_name': nome,
          'new_telefone': telefone,
          'new_cpf': cpf,
        },
      );

      return data != null ? true : false;
    } catch (e) {
      rethrow;
    }
  }

  bool get isAdmin => localUser != null ? localUser!.role == Role.admin : false;
}
