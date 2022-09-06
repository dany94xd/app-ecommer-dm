//import 'package:ecommerce/api_service.dart';
import 'package:ecommerce/pages/base_page.dart';
import 'package:ecommerce/widgets/widget_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../provider/products_provider.dart';

//import '../provider/products_provider.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}

class ProductPage extends BasePage {
  const ProductPage({Key key, this.categoryId}) : super(key: key);

  final int categoryId;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  // APISeervice apiSeervice;
  int _page = 1;
  final ScrollController _scrollController = ScrollController();

  final sortByOptions = [
    SortBy("popularity", "Popularity", "asc"),
    SortBy("modified", "Latest", "asc"),
    SortBy("price", "Price. High to Low", "desc"),
    SortBy("price", "Price: Low to High", "asc"),
  ];

  @override
  void initState() {
    //apiSeervice = APISeervice();

    var productList = Provider.of<ProductProvider>(context, listen: false);
    productList.resetStreams();
    productList.setLoadingState(LoadMoreStatus.initial);
    productList.fetchProducts(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        productList.setLoadingState(LoadMoreStatus.loading);
        productList.fetchProducts(++_page);
      }
    });

    super.initState();
  }

  @override
  Widget pageUI() {
    // Product product = Product();
    // product.name = "Tea Bags";
    // product.regularPrice = "100";
    // product.salePrice = "50";
    // product.images = <Images>[];

    //return ProductCard(data: product);

    return productsList();
  }

  Widget productsList() {
    return Consumer<ProductProvider>(builder: (context, productsModel, child) {
      if (productsModel.allProducts != null &&
          productsModel.allProducts.isNotEmpty &&
          productsModel.getLoadMoreStatus() != LoadMoreStatus.initial) {
        return buildList(productsModel.allProducts,
            productsModel.getLoadMoreStatus() == LoadMoreStatus.loading);
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    // return FutureBuilder(
    //   future: apiSeervice.getProducts(),
    //   builder: (BuildContext context, AsyncSnapshot<List<Product>> model) {
    //     if (model.hasData) {
    //       return buildList(model.data);
    //     }

    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }

  Widget buildList(List<Product> items, bool isLoadMore) {
    return Column(
      children: [
        productFilters(),
        Flexible(
          child: GridView.count(
            shrinkWrap: true,
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            children: items.map((Product item) {
              return ProductCard(
                data: item,
              );
            }).toList(),
          ),
        ),
        Visibility(
          visible: isLoadMore,
          child: Container(
            padding: const EdgeInsets.all(5),
            height: 35.0,
            width: 35.0,
            child: const CircularProgressIndicator(),
          ),
        )
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
          const SizedBox(
            width: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffe6e6ec),
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                var productsList =
                    Provider.of<ProductProvider>(context, listen: false);
                productsList.resetStreams();
                productsList.setSortOrder(sortBy);
                productsList.fetchProducts(_page);
              },
              itemBuilder: (BuildContext context) {
                return sortByOptions.map((item) {
                  return PopupMenuItem(
                    value: item,
                    child: Text(item.text),
                  );
                }).toList();
              },
              icon: const Icon(Icons.tune),
            ),
          ),
        ],
      ),
    );
  }
}
