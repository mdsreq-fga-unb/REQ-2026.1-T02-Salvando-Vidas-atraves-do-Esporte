import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:salvando_vidas/data/services/user_service.dart';
import 'package:salvando_vidas/data/stores/login/login_form.dart';

@GenerateNiceMocks([MockSpec<UserService>(), MockSpec<LoginFormStore>()])
void main() {}
