//category screen
import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
//we generally created a function like this in stateful widget where the ui changes
//but here we dont change the ui but we add a scren or navigate to another screen
  void _selectCategory(BuildContext context, Category category) {
//to navigate screen use Navigator.push its just like screens in stack push will add screen and pop will remove the screen
// Navigator.push(context, route)//here it wants context which is available when we use stateful widget but here its not available therefore we pass a buildcontext
    //to fetch all meals belonging to certain category which is clicked and disply tht dynamically
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) =>  MealsScreen(meals: filteredMeals, title: category.title),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick A Meal"),
      ),
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // creates a grid with fixed no of columns
          crossAxisCount: 2, //no of columns
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20, //within the column spacing
          mainAxisSpacing: 20, //row spacing
        ),
        children: [
          //  availableCategories.map((category) => CategoryGridItem(category: category))
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
    );
  }
}
