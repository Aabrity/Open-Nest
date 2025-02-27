// import 'package:equatable/equatable.dart';

// abstract class UserState extends Equatable {
//   const UserState();

//   @override
//   List<Object?> get props => [];
// }

// class UserInitial extends UserState {}

// class UserLoading extends UserState {}

// class UserLoaded extends UserState {
//   final String username;
//   final String email;
//   final String userId;
//   final String avatarBase64;
//   final bool isAdmin;
//   final bool subscription;

//   const UserLoaded({
//     required this.username,
//     required this.email,
//     required this.userId,
//     required this.avatarBase64,
//     required this.isAdmin,
//     required this.subscription,
//   });

//   @override
//   List<Object?> get props => [username, email, userId, avatarBase64, isAdmin, subscription];
// }

// class UserError extends UserState {
//   final String message;

//   const UserError(this.message);

//   @override
//   List<Object?> get props => [message];
// }


import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final String username;
  final String email;
  final String userId;
  final String avatarBase64;
  final bool isAdmin;
  final bool subscription;

  const UserLoaded({
    required this.username,
    required this.email,
    required this.userId,
    required this.avatarBase64,
    required this.isAdmin,
    required this.subscription,
  });

  @override
  List<Object?> get props => [username, email, userId, avatarBase64, isAdmin, subscription];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserUpdated extends UserState {}