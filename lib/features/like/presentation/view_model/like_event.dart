part of 'like_bloc.dart';

sealed class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class LikeLoad extends LikeEvent {
   final String listingId; // Optional listingId

  const LikeLoad({required this.listingId});

  @override
  List<Object> get props => [listingId];
}

class CreateLike extends LikeEvent {
  final String listing;

  const CreateLike({required this.listing});

  @override
  List<Object> get props => [listing];
}

class DeleteLike extends LikeEvent {
  final String id;
  final String listingId;

  const DeleteLike({required this.listingId, required this.id});

  @override
  List<Object> get props => [id];
}

class GetLikesByListing extends LikeEvent {
  final String listingId;

  const GetLikesByListing({required this.listingId});

  @override
  List<Object> get props => [listingId];
}

