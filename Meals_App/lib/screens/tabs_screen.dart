import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import '../screens/categories_screen.dart';
import '../screens/favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  //const TabsScreen({ Key? key }) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'pages': CategoriesScreen(), 'title': 'Category'},
    {'pages': FavouriteScreen(), 'title': 'Favourite'},
  ];

  int _selected_Index = 0;

  void _selected(int index) {
    setState(() {
      _selected_Index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selected_Index]['title']),
      ),
      drawer: Drawer_Screen(),
      body: _pages[_selected_Index]['pages'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selected,
        elevation: 10,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selected_Index,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        selectedFontSize: 15,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
        ],
      ),
    );
  }
}
