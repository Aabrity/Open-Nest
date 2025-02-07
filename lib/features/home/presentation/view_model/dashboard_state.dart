class DashboardState {
  final int selectedNavIndex;
  final bool navigateToProfile; // Add this for navigation

  DashboardState({required this.selectedNavIndex, this.navigateToProfile = false});

  DashboardState copyWith({int? selectedNavIndex, bool? navigateToProfile}) {
    return DashboardState(
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
      navigateToProfile: navigateToProfile ?? this.navigateToProfile,
    );
  }
}