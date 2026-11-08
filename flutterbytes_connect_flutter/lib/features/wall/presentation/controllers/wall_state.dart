import 'package:flutterbytes_connect_client/flutterbytes_connect_client.dart';

class WallState {
  final bool isLoading;
  final String? errorMessage;
  final List<AttendeeProfile> allProfiles;
  final String searchQuery;
  final String selectedFilter;

  const WallState({
    this.isLoading = true,
    this.errorMessage,
    this.allProfiles = const [],
    this.searchQuery = '',
    this.selectedFilter = 'All',
  });

  WallState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<AttendeeProfile>? allProfiles,
    String? searchQuery,
    String? selectedFilter,
  }) {
    return WallState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      allProfiles: allProfiles ?? this.allProfiles,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  /// Evaluates profiles based on active search keyword and skill chip filters
  List<AttendeeProfile> get filteredProfiles {
    return allProfiles.where((p) {
      final matchesFilter = selectedFilter == 'All' ||
          p.skills.any((s) => s.toLowerCase().contains(selectedFilter.toLowerCase())) ||
          p.role.toLowerCase().contains(selectedFilter.toLowerCase());

      if (!matchesFilter) return false;

      if (searchQuery.trim().isEmpty) return true;

      final query = searchQuery.toLowerCase();
      final nameMatches = p.name.toLowerCase().contains(query);
      final roleMatches = p.role.toLowerCase().contains(query);
      final personaMatches = p.personaTitle.toLowerCase().contains(query);
      final skillMatches = p.skills.any((s) => s.toLowerCase().contains(query));

      return nameMatches || roleMatches || personaMatches || skillMatches;
    }).toList();
  }

  int get totalCount => allProfiles.length;
}
