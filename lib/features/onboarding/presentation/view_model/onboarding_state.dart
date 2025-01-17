abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingPageState extends OnboardingState {
  final int currentPage;

  OnboardingPageState(this.currentPage);
}

class OnboardingComplete extends OnboardingState {}
