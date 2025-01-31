
abstract class HomeEvent {}

class CategoryChangedEvent extends HomeEvent {
  final int index;
  final double? offset;

  CategoryChangedEvent({required this.index, this.offset});
}
