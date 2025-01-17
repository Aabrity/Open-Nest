abstract class OnboardingEvent {}

class OnboardingPageChanged extends OnboardingEvent {
  final int pageIndex;

  OnboardingPageChanged(this.pageIndex);
}

class OnboardingCompleteEvent extends OnboardingEvent {}
