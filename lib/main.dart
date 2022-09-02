import 'package:ecommerce/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bueno Bonito Barato', //titulo de la app
      debugShowCheckedModeBanner: false, //desabilitar la barra de debug
      home: HomePage(),
    );
  }
}
