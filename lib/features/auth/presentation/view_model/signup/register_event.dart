part of 'register_bloc.dart';
sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;
  final String username;
  final String email;
  final String password;


  const RegisterUserEvent({
    required this.context,
    required this.username,
    required this.email,
    required this.password,

  });
}
