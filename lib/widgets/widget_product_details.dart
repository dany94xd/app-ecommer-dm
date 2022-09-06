import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({Key key, this.data}) : super(key: key);

  Product data;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Stack(
          children: [
            productImages(data.images, context),
            Visibility(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(padding: const EdgeInsets.all(5)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget productImages(List<Images> images, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                return Center(
                  child: Image.network(
                    images[index].src,
                    fit: BoxFit.fill,
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 1.0,
              ),
              carouselController: _controller,
            ),
          ),
          Positioned(
            top: 100,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                _controller.previousPage();
              },
            ),
          ),
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width - 80,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _controller.nextPage();
              },
            ),
          )
        ],
      ),
    );
  }
}
