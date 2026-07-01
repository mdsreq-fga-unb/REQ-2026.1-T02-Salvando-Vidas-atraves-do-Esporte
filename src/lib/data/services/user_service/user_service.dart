import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';

import '../../supabase_call.dart';
import '../global/global_service.dart';

part 'user_service.g.dart';

@Riverpod(keepAlive: true)
class LocalUserNotifier extends _$LocalUserNotifier {
  @override
  LocalUser? build() => null;

  void set(LocalUser? user) => state = user;
}

@Riverpod(keepAlive: true)
UserService userService(Ref ref) {
  return UserService(ref.watch(supabaseClientProvider), ref);
}

class UserService {
  final SupabaseClient _supabase;
  final Ref _ref;

  UserService(this._supabase, this._ref);

  LocalUser? get localUser => _ref.read(localUserProvider);

  set localUser(LocalUser? user) {
    _ref.read(localUserProvider.notifier).set(user);
  }

  void _setLocalUser(LocalUser? user) {
    localUser = user;
  }

  Future<bool> login(String email, String password) async {
    final authResponse = await runSupabaseCall(() async {
      return _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    });

    if (authResponse.user == null) return false;

    final user = await getLocalUser(authResponse.user!);
    _setLocalUser(user);
    return user != null;
  }

  Future<void> logout() async {
    await runSupabaseCall(() async {
      await _supabase.auth.signOut().withDefaultTimeout();
      _setLocalUser(null);
    });
  }

  Future<bool> isLoggedIn() async {
    User? user = _supabase.auth.currentUser;
    if (user == null) return false;

    final localUser = await getLocalUser(user);
    _setLocalUser(localUser);
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
      final novo = user.toMap();
      novo.remove('id');
      await _supabase.rpc('admin_create_user', params: novo);
    });
  }

  Future<void> deleteUser(String id) async {
    return runSupabaseCall(() async {
      await _supabase.rpc('admin_delete_user', params: {'target_user_id': id});
    });
  }

  Future<void> updateUser(Map<String, dynamic> diff) async {
    return runSupabaseCall(() async {
      await _supabase.rpc('admin_update_user', params: diff);
    });
  }

  Future<void> inactivateUser(String id) async {
    return runSupabaseCall(() async {
      try {
        await _supabase.rpc('admin_update_user', params: {'p_id': id, 'p_ativo': false});
      } catch (_) {
        await _supabase.from('users').update({'ativo': false}).eq('id', id);
      }
    });
  }

  Future<void> reactivateUser(String id) async {
    return runSupabaseCall(() async {
      try {
        await _supabase.rpc('admin_update_user', params: {'p_id': id, 'p_ativo': true});
      } catch (_) {
        await _supabase.from('users').update({'ativo': true}).eq('id', id);
      }
    });
  }

  bool get isAdmin => localUser?.role == Role.admin;
}
