import 'package:flutter_riverpod/flutter_riverpod.dart';
enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,

}
class FiltersNotifier extends StateNotifier<Map<Filter,bool>>{
FiltersNotifier() :super({
  Filter.glutenFree: false,
   Filter.lactoseFree: false, 
   Filter.vegan: false,
    Filter.vegetarian: false,
});
void setFilters(Map<Filter,bool> chosenFIlters){
state = chosenFIlters;
}
//method 
void setFilter(Filter filter, bool isActive){
  //state[filter]=isActive; //not allowed =>mutaing state
  state={
    ...state,//copy all states ass it is in the new state
    filter: isActive//change the filter of the selected state as isActive
  };
}
}
final filtersProvider = StateNotifierProvider<FiltersNotifier,Map<Filter,bool>>((ref) => FiltersNotifier());