import 'package:salvando_vidas/domain/local_user/local_user.dart';

import '../supabase_call.dart';

class UserService {
  final SupabaseClient _supabase;
  LocalUser? localUser;

  UserService(this._supabase);

  Future<Result<bool>> login(String email, String password) async {
    final call = await safeSupabaseCall(() async {
      return _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    });

    final User user;

    switch (call) {
      case Failure(message: final m, error: final e):
        return Failure(m, e);
      case Success(value: final v):
        if (v.user == null) return Success(false);
        user = v.user!;
    }

    switch (await getLocalUser(user)) {
      case Failure(message: final m, error: final e):
        return Failure(m, e);
      case Success(value: final v):
        localUser = v;
        return Success(localUser != null);
    }
  }

  Future<Result<void>> logout() async {
    return safeSupabaseCall(() async {
      await _supabase.auth.signOut().withDefaultTimeout();
      localUser = null;
    });
  }

  Future<Result<bool>> isLoggedIn() async {
    User? user = _supabase.auth.currentUser;
    if (user == null) return Success(false);

    switch (await getLocalUser(user)) {
      case Failure(message: final m, error: final e):
        return Failure(m, e);
      case Success(value: final v):
        localUser = v;
        return Success(localUser != null);
    }
  }

  Future<Result<LocalUser?>> getLocalUser(User user) async {
    return safeSupabaseCall(() async {
      final data = await _supabase.from('users').select().eq('id', user.id);

      if (data.isNotEmpty) {
        return LocalUser.fromJson(data.first);
      }

      return null;
    });
  }

  Future<Result<List<LocalUser>>> listUsers() async {
    return safeSupabaseCall(() async {
      final res = await _supabase.from('users').select();

      final users = List<LocalUser>.empty(growable: true);

      for (final data in res) {
        final user = LocalUser.fromJson(data);
        users.add(user);
      }

      return users;
    });
  }

  Future<Result<void>> registerUser(
    String email,
    String password,
    String nome,
    String telefone,
    String cpf,
  ) async {
    return safeSupabaseCall(() async {
      await _supabase.rpc(
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
    });
  }

  Future<Result<void>> deleteUser(String id) async {
    return safeSupabaseCall(() async {
      await _supabase.rpc('admin_delete_user', params: {'target_user_id': id});
    });
  }

  Future<Result<void>> updateUser({
    required String id,
    String? email,
    String? password,
    String? nome,
    String? telefone,
    String? cpf,
  }) async {
    return safeSupabaseCall(() async {
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
