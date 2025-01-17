import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingInitial());

  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    if (event is OnboardingPageChanged) {
      yield OnboardingPageState(event.pageIndex);
    } else if (event is OnboardingCompleteEvent) {
      yield OnboardingComplete();
    }
  }
}
