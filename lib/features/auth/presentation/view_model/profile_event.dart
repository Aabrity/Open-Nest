

import 'package:equatable/equatable.dart';
import 'package:open_nest/features/auth/domain/use_case/update_user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserEvent extends UserEvent {
  const FetchUserEvent();
}

class UpdateUserEvent extends UserEvent {
  final UpdateUserParams params;

  const UpdateUserEvent(this.params);

  @override
  List<Object?> get props => [params];
}