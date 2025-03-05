import 'package:equatable/equatable.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';

class LikeEntity extends Equatable {
  final String? likeId;
  final String listing;
  final String user;
  

  const LikeEntity({
    this.likeId,
    required this.listing,
    required this.user, 
  
  });

  @override
  List<Object?> get props => [likeId, listing, user];
}
