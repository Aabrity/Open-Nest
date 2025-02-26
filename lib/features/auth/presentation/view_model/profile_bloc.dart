import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/auth/domain/use_case/get_Current_user.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_event.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchCurrentUserUseCase fetchCurrentUserUseCase;

  ProfileBloc({required this.fetchCurrentUserUseCase}) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchUserProfile) {
      yield ProfileLoading();
      final Either<Failure, AuthEntity> result = await fetchCurrentUserUseCase(event.token);
      yield result.fold(
        (failure) => ProfileError(failure),
        (user) => ProfileLoaded(user),
      );
    }
  }
}

