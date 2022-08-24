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
          HttpHeaders.contentTypeHeader: "application/json",
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

  Future<List<Product>> getProducts(String tagId) async {
    List<Product> data = <Product>[];

    try {
      String url =
          "${Config.url}${Config.categoriesURL}?consumer_key=${Config.key}&consumer_secret=${Config.secret}&tag=$tagId";
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
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e.response);
    }

    return data;
  }
}
