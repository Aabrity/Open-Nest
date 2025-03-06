import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/app/usecase/usecase.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/listing/domain/repository/listing_repository.dart';


class DeleteListingParams extends Equatable {
  final String id;

  const DeleteListingParams({required this.id});

  const DeleteListingParams.empty() : id = '_empty.string';

  @override
  List<Object?> get props => [id];
}

// Use case
class DeleteListingUsecase
    implements UsecaseWithParams<void, DeleteListingParams> {
  final IListingRepository _listingRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteListingUsecase({required IListingRepository listingRepository, required this.tokenSharedPrefs,})
      : _listingRepository = listingRepository;

  @override
  Future<Either<Failure, void>> call(DeleteListingParams params) async {
     final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
    return _listingRepository.deleteListing(params.id, r);
  });
  }
}
