import 'package:ecommerce/api_service.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/pages/base_page.dart';
import 'package:ecommerce/widgets/widget_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';

class ProductPage extends BasePage {
  ProductPage({Key key, this.categoryId}) : super(key: key);

  int categoryId;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  //APISeervice apiSeervice;

  int page = 1;

  final _sortByOptions = [
    SortBy("popularity", "Popularity", "asc"),
    SortBy("modified", "Latest", "asc"),
    SortBy("price", "Price: High to Low", "desc"),
    SortBy("price", "price: Low to High", "asc")
  ];

  @override
  void initState() {
    // apiSeervice = APISeervice();

    var productList = Provider.of<ProductProvider>(context, listen: false);
    productList.resetStreams();
    productList.setLoadingState(LoadMoreStatus.INITIAL);
    productList.fetchProducts(page);
    super.initState();
  }

  @override
  Widget pageUI() {
    return productsList();
  }

  Widget productsList() {
    return Consumer<ProductProvider>(
      builder: (context, productsModel, child) {
        if (productsModel.allProducts != null &&
            productsModel.allProducts.isNotEmpty &&
            productsModel.getLoadMoreStatus() != LoadMoreStatus.INITIAL) {
          return buildList(productsModel.allProducts);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildList(List<Product> items) {
    return Column(
      children: [
        productFilters(),
        Flexible(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: items.map((Product item) {
              return ProductCard(data: item);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget productFilters() {
    return Container(
      height: 51,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none),
                fillColor: const Color(0xffe6e6ec),
                filled: true,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffe6e6ec),
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: PopupMenuButton(
              onSelected: (sortBy) {},
              itemBuilder: (BuildContext context) {
                return _sortByOptions.map((item) {
                  return PopupMenuItem(
                    value: item,
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Text(item.text),
                    ),
                  );
                }).toList();
              },
              icon: const Icon(Icons.tune),
            ),
          )
        ],
      ),
    );
  }
}
