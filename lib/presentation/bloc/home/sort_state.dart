enum SortWeatherList { sortDownToTop,sortTopToDown }

abstract class SortState {}

class SortResponseState extends SortState {
  SortWeatherList sortState;
  SortResponseState(this.sortState);
}
