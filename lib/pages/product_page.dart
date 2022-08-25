import 'package:ecommerce/api_service.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/pages/base_page.dart';
import 'package:flutter/material.dart';

class ProductPage extends BasePage {
  const ProductPage({Key key, this.categoryId}) : super(key: key);

  final int categoryId;

  @override
  // ignore: library_private_types_in_public_api
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  APISeervice apiSeervice;

  @override
  Widget pageUI() {
    return productsList();
  }

  Widget productsList() {
    return FutureBuilder(
      // future: apiSeervice.getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> model) {
        if (model.hasData) {
          return buildList(model.data);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildList(List<Product> items) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: items.map((Product item) {
          //  return ProductCard(data: item);
        }).toList(),
      ),
    );
  }
}
