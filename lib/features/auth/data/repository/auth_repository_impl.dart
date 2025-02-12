import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/features/auth/domain/repository/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<UserModel> signUp(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel(uid: userCredential.user!.uid, email: userCredential.user!.email!);
  }

  @override
  Future<UserModel> login(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel(uid: userCredential.user!.uid, email: userCredential.user!.email!);
  }
}
