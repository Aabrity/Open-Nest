part of 'register_bloc.dart';
class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String avatarName;

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    required this.avatarName,
  });

  const RegisterState.initial()
      : isLoading = false,
        isSuccess = false,
        avatarName = '';

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? avatarName,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      avatarName: avatarName ?? this.avatarName,
    );
  }
  
  @override
  List<Object?> get props => [isLoading, isSuccess, avatarName];
}



