class DashboardState {
  final int selectedNavIndex;

  DashboardState({required this.selectedNavIndex});

  // A copy method to easily change specific properties while keeping others intact.
  DashboardState copyWith({int? selectedNavIndex}) {
    return DashboardState(
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
    );
  }
}
