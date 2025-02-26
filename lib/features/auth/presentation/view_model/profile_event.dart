
abstract class ProfileEvent {}

class FetchUserProfile extends ProfileEvent {
  final String token;

  FetchUserProfile(this.token);
}

