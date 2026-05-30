import 'package:salvando_vidas/domain/local_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../supabase_call.dart';

class UserService {
  final SupabaseClient _supabase;
  LocalUser? localUser;

  UserService(this._supabase);

  Future<Result<bool>> login(String email, String password) async {
    final call = await safeSupabaseCall(() async {
      return await _supabase.auth.signInWithPassword(
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
    return await safeSupabaseCall(() async {
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
    final call = await safeSupabaseCall(
      () async => await _supabase.from('users').select().eq('id', user.id),
    );

    final Response data;

    switch (call) {
      case Failure(message: final m, error: final e):
        return Failure(m, e);
      case Success(value: final v):
        data = v;
    }

    if (data.isNotEmpty) {
      return Success(
        LocalUser(
          data[0]["nome"],
          data[0]["role"] == "admin" ? Role.admin : Role.voluntario,
        ),
      );
    }

    return Success(null);
  }

  Future<Result<bool>> registerUser(
    String email,
    String password,
    String nome,
    String telefone,
    String cpf,
  ) async {
    return safeSupabaseCall(() async {
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
    });
  }

  bool get isAdmin => localUser != null ? localUser!.role == Role.admin : false;
}
