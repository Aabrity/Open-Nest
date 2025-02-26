import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/features/like/domain/entity/like_entity.dart';
import 'package:open_nest/features/like/domain/use_case/create_like_usecase.dart';

import 'package:open_nest/features/like/domain/use_case/delete_like_usecase.dart';
import 'package:open_nest/features/like/domain/use_case/get_all_course_usecase.dart';


part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final GetAllLikeUsecase _getAllLikeUsecase;
  final CreateLikeUsecase _createLikeUsecase;
  final DeleteLikeUsecase _deleteLikeUsecase;
  LikeBloc({
    required GetAllLikeUsecase getAllLikeUsecase,
    required CreateLikeUsecase createLikeUsecase,
    required DeleteLikeUsecase deleteLikeUsecase,
  })  : _getAllLikeUsecase = getAllLikeUsecase,
        _createLikeUsecase = createLikeUsecase,
        _deleteLikeUsecase = deleteLikeUsecase,
        super(LikeState.initial()) {
    on<LikeLoad>(_onLikeLoad);
    on<CreateLike>(_onCreateLike);
    on<DeleteLike>(_onDeleteLike);

    add(LikeLoad());
  }

  Future<void> _onLikeLoad(
    LikeLoad event,
    Emitter<LikeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllLikeUsecase();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (likes) => emit(state.copyWith(isLoading: false, likes: likes)),
    );
  }

  Future<void> _onCreateLike(
    CreateLike event,
    Emitter<LikeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await _createLikeUsecase(CreateLikeParams(listing: event.listing));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(LikeLoad());
      },
    );
  }

  Future<void> _onDeleteLike(
    DeleteLike event,
    Emitter<LikeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _deleteLikeUsecase(DeleteLikeParams(id: event.id));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        add(LikeLoad());
      },
    );
  }
}
