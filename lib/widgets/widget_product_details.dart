import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/utils/custom_stepper.dart';
import 'package:ecommerce/utils/expand_text.dart';
import 'package:flutter/material.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({Key key, this.data}) : super(key: key);

  Product data;
  final CarouselController _controller = CarouselController();
  int qty = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              productImages(data.images, context),
              const SizedBox(
                height: 10,
              ),
              Visibility(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                data.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    data.attributes != null && data.attributes.isNotEmpty
                        ? ("${data.attributes[0].options.join("-").toString()}${data.attributes[0].name}")
                        : "",
                  ),
                  Text(
                    ('\$ ${data.regularPrice}'),
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomStepper(
                    lowerLimit: 0,
                    upperLimit: 20,
                    stepValue: 1,
                    iconSize: 22.0,
                    value: qty,
                    onChange: (value) {
                      // ignore: avoid_print
                      print(value);
                    },
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {},
                    child: const Text('Añadir al carrito'),
                  )
                ],
              ),
              const SizedBox(height: 5),
              ExpandText(
                  labelHeader: "Detalle de Producto",
                  desc: data.description,
                  shortDesc: data.shortDescription)
            ],
          )
        ]),
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
