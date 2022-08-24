import 'package:ecommerce/api_service.dart';
import 'package:ecommerce/models/category.dart' as categorymodel;
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class WidgetCategories extends StatefulWidget {
  @override
  State<WidgetCategories> createState() => _WidgetCategoriesState();
}

class _WidgetCategoriesState extends State<WidgetCategories> {
  APISeervice apiSeervice;

  void initSate() {
    apiSeervice = APISeervice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  'All Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4, right: 10),
                child: Text(
                  'View All',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
          categoriesList(),
        ],
      ),
    );
  }

  Widget categoriesList() {
    return FutureBuilder(
      future: apiSeervice.getCategories(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<categorymodel.Category>> model,
      ) {
        if (model.hasData) {
          return buildCategoryList(model.data);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildCategoryList(List<categorymodel.Category> categories) {
    return Container(
      height: 150,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 5),
                        blurRadius: 15),
                  ],
                ),
                child: Image.network(data.image.url, height: 80),
              ),
              Row(
                children: [
                  Text(data.categoryName.toString()),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    size: 14,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
