part of 'search_locations_cubit.dart';

/// State for the SearchLocationsCubit.
class SearchLocationsState extends Equatable {
  final List<DiabRutaLocation> myPlaces;
  final List<DiabRutaLocation> myDefaultPlaces;
  final List<DiabRutaLocation> historyPlaces;
  final List<DiabRutaLocation> favoritePlaces;
  final List<SearchLocation> searchResult;
  final bool isLoading;

  const SearchLocationsState({
    this.myPlaces = const [],
    this.myDefaultPlaces = const [],
    this.historyPlaces = const [],
    this.favoritePlaces = const [],
    this.searchResult = const [],
    this.isLoading = false,
  });

  SearchLocationsState copyWith({
    List<DiabRutaLocation>? myPlaces,
    List<DiabRutaLocation>? myDefaultPlaces,
    List<DiabRutaLocation>? historyPlaces,
    List<DiabRutaLocation>? favoritePlaces,
    List<SearchLocation>? searchResult,
    bool? isLoading,
  }) {
    return SearchLocationsState(
      myPlaces: myPlaces ?? this.myPlaces,
      myDefaultPlaces: myDefaultPlaces ?? this.myDefaultPlaces,
      historyPlaces: historyPlaces ?? this.historyPlaces,
      favoritePlaces: favoritePlaces ?? this.favoritePlaces,
      searchResult: searchResult ?? this.searchResult,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
    myPlaces,
    myDefaultPlaces,
    historyPlaces,
    favoritePlaces,
    searchResult,
    isLoading,
  ];
}


