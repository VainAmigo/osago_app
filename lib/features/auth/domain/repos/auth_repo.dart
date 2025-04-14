import 'package:osago_bloc_app/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassword(String inn, String email, String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}