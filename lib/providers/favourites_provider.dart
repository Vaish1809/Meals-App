import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';


class FavouriteMealsNotifier extends StateNotifier<List<Meal>>{
//constructor which consists of an empty list cauz we initially have an empty list
FavouriteMealsNotifier() : super([]);//super to reach to parent clss
bool toggleMealFavouriteStatus(Meal meal){
  //here we cannot overridede the list in notifier hence we chk it using state state is like a copy list 
  final mealIsFavourite = state.contains(meal);//chk if the passed meal is in the favourites list or not 
  //it reutrns true here if it is else false

  if(mealIsFavourite)//if it is already there we need to remove
  {
state = state.where((m) => m.id != meal.id ).toList();
//we update the state
//.where reutrns an itterable but state is a list therefore toList
//to remove we want false in the where condition
//to get tht flase we put up the conditon of id since we already know tht the meal already exist therefore always the meal in the state and the meal we are passing will have the same id
//therfore it will always return false
//to remove object we create a new state and convert it to a list where we include only those meals whose meal id is not the same as which we want to remove therefore 
//existing list contain abcd and we want to remove c then create a new list where the id doesnt match with c
 return false;
  }
  else{//now if the meals are different we add the meals to the list
state = [...state,meal];//...pulls out all ememets of the state and puts them into the new list State as individual elements ,mela mmeans we add the new meal
 return true;
  }
}


}

final favouriteMealsProvider = StateNotifierProvider<FavouriteMealsNotifier,List<Meal>>((ref) {
  //we use StateNotifier instead of provider cauz here the data dynamically changes and just like stateful widget comes with state objects they come with StateNotifier classs 
 return FavouriteMealsNotifier(); //flutter doesnt knoww wht type the FavouriteMealsNotifier() will return theefpre we add it meanually 
},);