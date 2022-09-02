import 'package:ecommerce/pages/home_page.dart';
import 'package:ecommerce/pages/product_page.dart';
import 'package:ecommerce/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: const ProductPage(),
        )
      ],
      child: MaterialApp(
        title: 'Bueno Bonito Barato', //titulo de la app
        debugShowCheckedModeBanner: false, //desabilitar la barra de debug
        home: HomePage(),
      ),
    );
  }
}
