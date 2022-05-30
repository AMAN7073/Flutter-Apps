import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/filters.dart';
import '../screens/meals_detail_screen.dart';
import '../screens/tabs_screen.dart';
import '../widgets/category_item.dart';
import './screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Man',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(21, 51, 55, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(21, 51, 55, 1),
              ),
              subtitle1: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontStyle: FontStyle.italic,
                fontSize: 20,
                //fontWeight: FontWeight.bold,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMeals.routName: (ctx) => CategoryMeals(),
        MealDetailScreen.routName: (ctx) => MealDetailScreen(),
        FiltersScreen.routName: (ctx) => FiltersScreen()
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (ctx) => CategoriesScreen()),
    );
  }
}
