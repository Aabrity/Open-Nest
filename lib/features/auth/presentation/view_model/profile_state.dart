

import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final AuthEntity user;

  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final Failure failure;

  ProfileError(this.failure);
}