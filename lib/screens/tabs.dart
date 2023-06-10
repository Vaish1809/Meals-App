//this is for the navbar
//it loads screens as other  screens in embedded screens
//used to update screen
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/filters.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  //here we say tht the categroies index is 0 and the favourites index is 1
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  //get the list of favourite meals
 // final List<Meal> _favouriteMeals = [];
  //whenever any filter is choosen we need to update these paramaeters
 
  //Map<Filter, bool> _selectedFilters = kInitialFilters;

//to show a snackbar if the meal is added or not
  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(message),
  //   ));
  // }

  // void _toggleMealFavouriteStatus(Meal meal) {
  //   final isExisting = _favouriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favouriteMeals.add(meal);
  //       _showInfoMessage('Meal is no longer a favourite ');
  //     });
  //   } else {
  //     setState(() {
  //       _favouriteMeals.remove(meal);
  //       _showInfoMessage('meal is favourite');
  //     });
  //   }
  // }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      // final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => const FiltersScreen(
                   // currentFilters: _selectedFilters,
                  )));
      //_selectedFilters = result;
      //this will just store the values but we also wantt to upate or run the build method again so tht the selected filters are applied on the categories
    //   setState(() {
    //     _selectedFilters = result ?? kInitialFilters;
    //   });
    }

    /// else{//we r already in the tabs screen so we jsut want to close
    // Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where((meal) {
      //chk if the my filter for gluten free is false then shpw all meals which doesnt contain gluten thereofre return false
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true; //if any of the conditions not met return all meals
    }).toList();
    Widget activePage = CategoriesScreen(
     // onToggleFavourite: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals =ref.watch(favouriteMealsProvider);
      activePage = MealsScreen(
        meals:favouriteMeals ,
       // onToggleFavourite: _toggleMealFavouriteStatus,
      );
      activePageTitle = "your favourites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        //to highlight which tab is  selected
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites"),
        ],
      ),
    );
  }
}
