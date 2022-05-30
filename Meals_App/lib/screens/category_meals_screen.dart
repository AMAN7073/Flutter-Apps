import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meals.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMeals extends StatefulWidget {
  //const CategoryMeals({ Key? key }) : super(key: key);
  // final String id;
  // final String title;
  // CategoryMeals(this.id, this.title);

  static const routName = '/categories-meals';

  @override
  State<CategoryMeals> createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  String title;
  List<Meal> displayMeals;
  var didInitChange = false;
  @override
  void initState() {
    //....
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!didInitChange) {
      final routearg =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      title = routearg['title'];
      final categoryid = routearg['id'];
      displayMeals = DUMMY_MEALS
          .where((meals) => meals.categories.contains(categoryid))
          .toList();
      didInitChange = true;
    }

    super.didChangeDependencies();
  }

  void _removeItem(String mealId) {
    setState(() {
      displayMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals[index].id,
            title: displayMeals[index].title,
            imageUrl: displayMeals[index].imageUrl,
            affordable: displayMeals[index].affordability,
            complexity: displayMeals[index].complexity,
            duration: displayMeals[index].duration,
            removeItem: _removeItem,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}
