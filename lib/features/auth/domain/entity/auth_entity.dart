import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String username;
  final String email;
  final String password;
  final String avatar;
  final bool isAdmin;
  final bool subscription;

  const AuthEntity({
    this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.avatar,
    this.isAdmin = false,
    this.subscription = false, String? image,
  });

    const AuthEntity.empty()
      : userId = '',
        username = '',
        email = '',
        password = '',
        avatar = '',
        isAdmin = false,
        subscription = false;
       



  @override
  List<Object?> get props =>
      [userId, username, email, password, avatar, isAdmin, subscription];
}
