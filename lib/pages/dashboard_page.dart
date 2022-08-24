import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce/widgets/widget_home_categories.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(children: [
          imageCarousel(context),
          WidgetCategories(),
        ]),
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: Carousel(
        overlayShadow: false,
        borderRadius: true,
        boxFit: BoxFit.none,
        autoplay: true,
        dotSize: 4.0,
        images: [
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://tacticalstore.ec/wp-content/uploads/2022/03/navajabrowing22.webp"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://tacticalstore.ec/wp-content/uploads/2022/03/fondo11.webp"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://tacticalstore.ec/wp-content/uploads/2022/03/fondo333.webp"),
          ),
          // FittedBox(
          //   fit: BoxFit.fill,
          //   child: Image.network("URL1"),
          // ),
        ],
      ),
    );
  }
}
