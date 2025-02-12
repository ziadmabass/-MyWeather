import 'package:weather_app/features/auth/domain/repository/auth_repository.dart';

import '../entities/user.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.signUp(email, password);
  }
}
