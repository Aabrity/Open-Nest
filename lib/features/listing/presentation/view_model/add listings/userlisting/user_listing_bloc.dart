import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/domain/use_case/get_listing_by_id_usecase.dart';

part 'user_listing_event.dart';
part 'user_listing_state.dart';

class UserListingBloc extends Bloc<UserListingEvent, UserListingState> {
  final GetUserListingUsecase _getUserListingUsecase;

  UserListingBloc({required GetUserListingUsecase getUserListingUsecase})
      : _getUserListingUsecase = getUserListingUsecase,
        super(UserListingState.initial()) {
    on<LoadUserListing>(_onLoadUserListing);
  }

  Future<void> _onLoadUserListing(
    LoadUserListing event,
    Emitter<UserListingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Start loading
    final result = await _getUserListingUsecase();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        error: failure.message,
      )), // Emit error state
      (listings) => emit(state.copyWith(
        isLoading: false,
        listings: listings,
        currentUserId: event.userId,
      )), // Emit loaded state
    );
  }
}