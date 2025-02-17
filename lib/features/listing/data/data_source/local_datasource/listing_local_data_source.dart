import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/core/network/hive_service.dart';
import 'package:open_nest/features/listing/data/data_source/listing_data_source.dart';
import 'package:open_nest/features/listing/data/model/listing_hive_model.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';

class ListingLocalDataSource implements IListingDataSource {
  final HiveService _hiveService;

  ListingLocalDataSource({required HiveService hiveService})
      : _hiveService = hiveService;

  @override
  Future<void> createListing(ListingEntity listing) async {
    try {
      // Convert listing entity to listing model
      final listingHiveModel = ListingHiveModel.fromEntity(listing);
      _hiveService.addListing(listingHiveModel);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<void> deleteListing(String id, String? token) async {
    try {
      _hiveService.deleteListing(id);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<List<ListingEntity>> getListing() async {
    try {
      final listingHiveModelList = await _hiveService.getListing();
      return ListingHiveModel.toEntityList(listingHiveModelList);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }
}
