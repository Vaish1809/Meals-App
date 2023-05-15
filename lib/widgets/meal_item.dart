import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
MealItem({super.key, required this.meal,required this.onSelectMeal});
  final Meal meal;

  void Function(Meal meal) onSelectMeal;
//how to make the first letter of a word capital adn the rest lower case 
  String get complexityText{
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

  String get affordibilityText{
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }
  @override
  Widget build(BuildContext context) {
    //container always padding
    //row or column use sized box
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip
          .hardEdge, //this is necessary because stack ignores the shapse so we wantt o force shape on it
      elevation: 2, //to have it come 3d to eelevate it
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            //bottommost or bg first
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit
                  .cover, //use this so tht only the image as per the size of box is used and the other is cut off ot avoid distortion
              height: 200,
              width: double.infinity,
            ),
            //to position on on top of other
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                child: Column(children: [
                  Text(
                    meal.title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    softWrap: true, //if it needs wrapping
                    overflow: TextOverflow
                        .ellipsis, //extra text cut off by adding ...dots
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(),
                  //here we want to show affordability time etc we want icon and text near it
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MealItemTrait(
                          icon: Icons.schedule,
                          label:
                              '${meal.duration}min'), //meal.duration.toString()
                    
                    const SizedBox(width: 12,),
                    MealItemTrait(
                          icon: Icons.work,
                          label: complexityText),
                          const SizedBox(width: 12,),
                    MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordibilityText),


                    
                    ],
                  )
                ]),
              ),
            )
          ],
        ), //when we wantt to position thing one on top of each other
      ),
    );
  }
}
