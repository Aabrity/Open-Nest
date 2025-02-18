import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/domain/use_case/create_listing_usecase.dart';
import 'package:open_nest/features/listing/domain/use_case/delete_listing_usecase.dart';
import 'package:open_nest/features/listing/domain/use_case/get_all_listing_usecase.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final GetAllListingUsecase _getAllListingUsecase;
  final CreateListingUsecase _createListingUsecase;
  final DeleteListingUsecase _deleteListingUsecase;
  ListingBloc({
    required GetAllListingUsecase getAllListingUsecase,
    required CreateListingUsecase createListingUsecase,
    required DeleteListingUsecase deleteListingUsecase,
  })  : _getAllListingUsecase = getAllListingUsecase,
        _createListingUsecase = createListingUsecase,
        _deleteListingUsecase = deleteListingUsecase,
        super(ListingState.initial()) 
        {
    on<ListingLoad>(_onListingLoad);
    on<CreateListing>(_onCreateListing);
    on<DeleteListing>(_onDeleteListing);

    // add(ListingLoad());
  }

  Future<void> _onListingLoad(
    ListingLoad event,
    Emitter<ListingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllListingUsecase();
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (listings) => emit(state.copyWith(isLoading: false, listings: listings)),
    );
  }

  Future<void> _onCreateListing(
    CreateListing event,
    Emitter<ListingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createListingUsecase(CreateListingParams(
      name: event.name,
      description: event.description,
      address: event.address,
      regularPrice: event.regularPrice,
      discountPrice: event.discountPrice,
      bathrooms: event.bathrooms,
      bedrooms: event.bedrooms,
      furnished: event.furnished,
      parking: event.parking,
      type: event.type,
      offer: event.offer,
      imageUrls: event.imageUrls,
    ));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        // add(ListingLoad());
      },
    );
  }

  Future<void> _onDeleteListing(
    DeleteListing event,
    Emitter<ListingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await _deleteListingUsecase(DeleteListingParams(id: event.id));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
        // add(ListingLoad());
      },
    );
  }
}
