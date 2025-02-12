import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:weather_app/features/auth/domain/usecase/signup_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final LoginUseCase loginUseCase;

  AuthCubit(this.signUpUseCase, this.loginUseCase) : super(AuthInitial());

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase.call(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.call(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
