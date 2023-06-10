import 'package:flutter/material.dart';
//import 'package:meals_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favourites_provider.dart';

//here we trigger the provider 
class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, 
  required this.meal,
  //required this.onToggleFavourite
  });

  final Meal meal;
 // final void Function(Meal meal) onToggleFavourite;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            //the method is called here beciase we want the value of meals if it was added or not and based on tht we need to hsow snackbars
            IconButton(onPressed: (){
         final wasAdded = ref.read(favouriteMealsProvider.notifier)
          .toggleMealFavouriteStatus(meal);
          ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(wasAdded ? "Meal Added as favourite" : 'Meal Removed as Favourite'),
    ));
//onToggleFavourite(meal);
            }, icon:const Icon(Icons.star))
          ],
          title: Text(meal.title),
        ),
       // body: ListView(//listview used hre to make it scrollable not using list view builder cauz not a very big list but hrer all hte contnets shift to left therefre single vhild scroll view
         body: SingleChildScrollView(
           child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const SizedBox(height: 20),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
            ],
                 ),
         ));
  }
}
