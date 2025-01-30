part of 'register_bloc.dart';
sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}


class UploadImage extends RegisterEvent {
  final File file;

  const UploadImage({
    required this.file,
  });
}

class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;
  final String username;
  final String email;
  final String password;
  final String? image;


  const RegisterUserEvent({
    required this.context,
    required this.username,
    required this.email,
    required this.password,
    this.image,
  });
}
