import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  //const CategoryItem({ Key? key }) : super(key: key);
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.title, this.color, this.id);

  void onTouch(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMeals.routName,
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTouch(context),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.7), color],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
