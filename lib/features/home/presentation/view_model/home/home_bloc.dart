
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/features/home/presentation/view_model/home/home_event.dart';
import 'package:open_nest/features/home/presentation/view_model/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState());

  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is CategoryChangedEvent) {
      yield* _mapCategoryChangedToState(event);
    }
  }

  Stream<HomeState> _mapCategoryChangedToState(CategoryChangedEvent event) async* {
    // Your logic to handle the category change
    yield CategoryChangedState(
      activeIndex: event.index,
      saleOffset: event.index == 0 ? 100.0 : null, // Example offsets for sale
      rentOffset: event.index == 1 ? 200.0 : null, // Example offsets for rent
      trendingOffset: event.index == 2 ? 300.0 : null, // Example offsets for trending
    );
  }
}


