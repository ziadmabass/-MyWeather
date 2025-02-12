import '../entities/user.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp(String email, String password);
  Future<UserEntity> login(String email, String password); // New method
}
