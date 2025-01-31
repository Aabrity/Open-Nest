
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class CategoryChangedState extends HomeState {
  final int activeIndex;
  final double? saleOffset;
  final double? rentOffset;
  final double? trendingOffset;

  CategoryChangedState({
    required this.activeIndex,
    this.saleOffset,
    this.rentOffset,
    this.trendingOffset,
  });
}
