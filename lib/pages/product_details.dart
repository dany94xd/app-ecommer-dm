import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/pages/base_page.dart';
import 'package:ecommerce/widgets/widget_product_details.dart';
import 'package:flutter/material.dart';

class ProductDetails extends BasePage {
  const ProductDetails({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends BasePageState<ProductDetails> {
  @override
  Widget pageUI() {
    return ProductDetailsWidget(data: widget.product);
  }
}
