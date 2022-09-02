import 'package:ecommerce/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}

enum LoadMoreStatus {
  initial,
  loading,
  stable,
}

class ProductProvider with ChangeNotifier {
  APISeervice apiSeervice;
  List<Product> productList;
  SortBy _sortBy;

  int pageSize = 10;

  List<Product> get allProducts => productList;
  double get totalRecords => productList.length.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.stable;
  getLoadMoreStatus() => _loadMoreStatus;

  ProductProvider() {
    _sortBy = SortBy("modified", "Latest", "asc");
  }

  void resetStreams() {
    apiSeervice = APISeervice();
    productList = <Product>[];
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    //notifyListeners();
    _loadMoreStatus = loadMoreStatus;
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  fetchProducts(
    pageNumber, {
    String strSearch,
    String tagName,
    String categoryId,
    String sortBy,
    String sortOrder = "asc",
  }) async {
    List<Product> itemModel = await apiSeervice.getProducts(
      strSearch: strSearch,
      tagName: tagName,
      pageNumber: pageNumber,
      pageSize: pageSize,
      categoryId: categoryId,
      sortBy: _sortBy.value,
      sortOrder: _sortBy.sortOrder,
    );
    if (itemModel.isNotEmpty) {
      productList.addAll(itemModel);
    }

    setLoadingState(LoadMoreStatus.stable);
    notifyListeners();
  }
}
