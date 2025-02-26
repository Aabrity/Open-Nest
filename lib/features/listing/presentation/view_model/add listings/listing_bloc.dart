import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/domain/use_case/create_listing_usecase.dart';
import 'package:open_nest/features/listing/domain/use_case/delete_listing_usecase.dart';
import 'package:open_nest/features/listing/domain/use_case/get_all_listing_usecase.dart';
import 'package:open_nest/features/listing/domain/use_case/get_listing_by_id_usecase.dart';
import 'package:open_nest/features/listing/domain/use_case/update_Usecase.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final GetAllListingUsecase _getAllListingUsecase;
  final CreateListingUsecase _createListingUsecase;
  final DeleteListingUsecase _deleteListingUsecase;
  final UpdateListingUsecase _updateListingUsecase;
  final GetUserListingUsecase _getUserListingUsecase;
  ListingBloc({
    required GetAllListingUsecase getAllListingUsecase,
    required CreateListingUsecase createListingUsecase,
    required DeleteListingUsecase deleteListingUsecase,
    required UpdateListingUsecase updateListingUsecase,
    required GetUserListingUsecase getUserListingUsecase,
  })  : _getAllListingUsecase = getAllListingUsecase,
        _createListingUsecase = createListingUsecase,
        _deleteListingUsecase = deleteListingUsecase,
        _updateListingUsecase = updateListingUsecase,
        _getUserListingUsecase = getUserListingUsecase,
        super(ListingState.initial()) 
        {
    on<ListingLoad>(_onListingLoad);
    on<CreateListing>(_onCreateListing);
    on<DeleteListing>(_onDeleteListing);
    on<UpdateListing>(_onUpdateListing);
    on<ListingLoadAll>(_onListingLoadAll);

    add(ListingLoadAll());
  }
 Future<void> _onListingLoadAll(
    ListingLoadAll event,
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

  Future<void> _onListingLoad(
    ListingLoad event,
    Emitter<ListingState> emit,
  ) async {
    // debugPrint(event.listing)
    
    emit(state.copyWith(isLoading: true));
    final result = await _getUserListingUsecase();
    
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (listings)  {debugPrint("bloc data: $listings");
        emit(state.copyWith(isLoading: false, listings: listings));},
       
    );
  }

  // Future<void> _onCreateListing(
  //   CreateListing event,
  //   Emitter<ListingState> emit,
  // ) async {
  //   emit(state.copyWith(isLoading: true));
  //   final result = await _createListingUsecase(CreateListingParams(
  //     name: event.name,
  //     description: event.description,
  //     address: event.address,
  //     regularPrice: event.regularPrice,
  //     discountedPrice: event.discountedPrice,
  //     bathrooms: event.bathrooms,
  //     bedrooms: event.bedrooms,
  //     furnished: event.furnished,
  //     parking: event.parking,
  //     type: event.type,
  //     offer: event.offer,
  //     imageUrls: event.imageUrls,
  //   ));
  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, error: failure.message)),
  //     (_) {
  //       emit(state.copyWith(isLoading: false));
  //       add(ListingLoad());
  //     },
  //   );
  // }

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
    discountedPrice: event.discountedPrice,
    bathrooms: event.bathrooms,
    bedrooms: event.bedrooms,
    furnished: event.furnished,
    parking: event.parking,
    type: event.type,
    offer: event.offer,
    imageUrls: event.imageUrls,
  ));

  result.fold(
    (failure) {
      emit(state.copyWith(isLoading: false, error: failure.message));
      // Show failure pop-up
      showDialog(
        context: event.context, // Use context from the event
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Creating listing failed: ${failure.message}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    },
    (_) {
      emit(state.copyWith(isLoading: false));
      // Show success pop-up
      showDialog(
        context: event.context, // Use context from the event
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Listing created successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      add(ListingLoad()); // Reload the listings after creation
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
        add(ListingLoad());
      },
    );
  }

//   Future<void> _onUpdateListing(
//   UpdateListing event,
//   Emitter<ListingState> emit,
// ) async {
//   emit(state.copyWith(isLoading: true));
//   final result = await _updateListingUsecase(UpdateListingParams(
//     id: event.id,
//     name: event.name,
//     description: event.description,
//     address: event.address,
//     regularPrice: event.regularPrice,
//     discountedPrice: event.discountedPrice,
//     bathrooms: event.bathrooms,
//     bedrooms: event.bedrooms,
//     furnished: event.furnished,
//     parking: event.parking,
//     type: event.type,
//     offer: event.offer,
//     imageUrls: event.imageUrls,
//   ));
  
//   result.fold(
//     (failure) =>
//         emit(state.copyWith(isLoading: false, error: failure.message)),
//     (_) {
//       emit(state.copyWith(isLoading: false));
//       add(ListingLoad()); // Reload the updated listings after update
//     },
//   );
// }
Future<void> _onUpdateListing(
  UpdateListing event,
  Emitter<ListingState> emit,
) async {
  emit(state.copyWith(isLoading: true));

  final result = await _updateListingUsecase(UpdateListingParams(
    id: event.id,
    name: event.name,
    description: event.description,
    address: event.address,
    regularPrice: event.regularPrice,
    discountedPrice: event.discountedPrice,
    bathrooms: event.bathrooms,
    bedrooms: event.bedrooms,
    furnished: event.furnished,
    parking: event.parking,
    type: event.type,
    offer: event.offer,
    imageUrls: event.imageUrls,
  ));

  result.fold(
    (failure) {
      emit(state.copyWith(isLoading: false, error: failure.message));
      // Show failure pop-up
      showDialog(
        context: event.context, // Use context from the event
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Updating failed: ${failure.message}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    },
    (_) {
      emit(state.copyWith(isLoading: false));
      // Show success pop-up
      showDialog(
        context: event.context, // Use context from the event
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Listing updated successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      add(ListingLoad()); // Reload the updated listings after update
    },
  );
}
}



