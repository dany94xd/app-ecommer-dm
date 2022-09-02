import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerce/config.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/models/customer.dart';
import 'package:ecommerce/models/login_model.dart';
import 'package:ecommerce/models/product.dart';

class APISeervice {
  //Registro de cliente
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode("${Config.key}:${Config.secret}"),
    );

    bool ret = false;
    try {
      var response = await Dio().post(Config.url + Config.customerURL,
          data: model.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }

  ///Login /////

  Future<LoginResponseModel> loginCustomer(
    String username,
    String password,
  ) async {
    LoginResponseModel model;
    try {
      var response = await Dio().post(
        Config.tokenURL,
        data: {
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          },
        ),
      );
      if (response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.message);
    }
    return model;
  }

  ///Categorias //

  Future<List<Category>> getCategories() async {
    List<Category> data = <Category>[];

    try {
      String url =
          "${Config.url}${Config.categoriesURL}?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      var response = await Dio().get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=utf-8  ",
        }),
      );

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Category.fromJson(i),
            )
            .toList();
      }
      // ignore: avoid_print
      print(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.response);
    }

    return data;
  }

  /////Productos/////

  Future<List<Product>> getProducts({
    int pageNumber,
    int pageSize,
    String strSearch,
    String tagName,
    String categoryId,
    String sortBy,
    String sortOrder = "asc",
  }) async {
    // Future<List<Product>> getProducts(String tagId) async {
    List<Product> data = <Product>[];

    try {
      String parameter = "";
      if (strSearch != null) {
        parameter += "&search=$strSearch";
      }

      if (pageSize != null) {
        parameter += "&per_page=$pageSize";
      }
      if (pageNumber != null) {
        parameter += "&page=$pageNumber";
      }
      if (tagName != null) {
        parameter += "&tag=$tagName";
      }
      if (categoryId != null) {
        parameter += "&category=$categoryId";
      }
      if (sortBy != null) {
        parameter += "&orderby=$sortBy";
      }
      if (sortOrder != null) {
        parameter += "&order=$sortOrder";
      }

      String url =
          "${Config.url}${Config.productsURL}?consumer_key=${Config.key}&consumer_secret=${Config.secret}${parameter.toString()}";
      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Product.fromJson(i),
            )
            .toList();
      }
      // ignore: avoid_print
      print(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.response);
    }

    return data;
  }
}
