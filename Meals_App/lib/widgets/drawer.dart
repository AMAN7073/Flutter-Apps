import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/filters.dart';

class Drawer_Screen extends StatelessWidget {
  //const Drawer_Screen({ Key? key }) : super(key: key);

  Widget buildTile(String title, IconData icon, Function onPressed) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.greenAccent,
      elevation: 20,
      //backgroundColor: Colors.amberAccent,
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 30),
          buildTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routName);
          }),
        ],
      ),
    );
  }
}
