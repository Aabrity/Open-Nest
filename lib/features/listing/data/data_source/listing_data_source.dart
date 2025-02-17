import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';


abstract interface class IListingDataSource {
  Future<List<ListingEntity>> getListing();
  Future<void> createListing(ListingEntity listing);
  Future<void> deleteListing(String id, String?token);
}
