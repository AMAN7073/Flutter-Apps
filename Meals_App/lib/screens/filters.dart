import 'package:flutter/material.dart';
import '../widgets/drawer.dart';

class FiltersScreen extends StatelessWidget {
  //const Filters({ Key? key }) : super(key: key);
  static const routName = '/filters';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      drawer: Drawer_Screen(),
      body: Center(
        child: Text('Hello Boys!'),
      ),
    );
  }
}
