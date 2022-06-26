import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/screens/product_overview_screen.dart';
import 'package:state_management/screens/splash_screen.dart';

import './providers/auth.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/users_products_screen.dart';
import './providers/order.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(null, null, []),
          update: (ctx, auth, previous) => Products(
              auth.token, auth.userId, previous != null ? previous.items : []),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(null, null, []),
          update: (ctx, auth, previous) => Orders(
              auth.token, auth.userId, previous != null ? previous.orders : []),
        ),
      ],
      child: Consumer<Auth>(
        builder: ((context, auth, _) => MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
                accentColor: Colors.lightGreen,
                fontFamily: 'Lato',
              ),
              home: auth.isAuth
                  ? ProductOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authresultSnapshot) =>
                          authresultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
              routes: {
                ProductDetailScreen.routName: (ctx) {
                  return ProductDetailScreen();
                },
                CartScreen.routename: (context) {
                  return CartScreen();
                },
                OrdersScreen.routeName: (context) {
                  return OrdersScreen();
                },
                UserProductsScreen.routeName: (context) {
                  return UserProductsScreen();
                },
                EditUserProduct.routeName: (context) {
                  return EditUserProduct();
                },
              },
            )),
      ),
    );
  }
}
