part of 'user_listing_bloc.dart';

abstract class UserListingEvent extends Equatable {
  const UserListingEvent();

  @override
  List<Object> get props => [];
}

class LoadUserListing extends UserListingEvent {
  final String userId;

  const LoadUserListing(this.userId);

  @override
  List<Object> get props => [userId];
}