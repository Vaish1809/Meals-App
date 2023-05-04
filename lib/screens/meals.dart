//all screens should have scaffold
import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.meals, required this.title});
  final String title;
  final List<Meal> meals;
  void selectMeal(BuildContext context ,Meal meal)
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MealDetailsScreen(meal: meal),),);
  }
  @override
  Widget build(BuildContext context) {
    //default 
   Widget content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("uh no.. nothing here...",style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),),
            const SizedBox(
              height: 16,
            ),
            Text("Try Selecting a different category",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),),
          ],
        ),
      );

      //if meals is not empty
    if (meals.isNotEmpty) {
       content = ListView.builder(
        itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
            meal: meals[index],
            onSelectMeal: (meal) {
            selectMeal(context, meal);
            
          },

        ), );
       
   //used when list is too big and we want it scrollable
      
    }
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body:content 
        );
  }
}
