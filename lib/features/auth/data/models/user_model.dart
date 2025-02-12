import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({required super.uid, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(uid: json['uid'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email};
  }
}
