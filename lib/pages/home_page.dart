import 'package:ecommerce/pages/dashboard_page.dart';
import 'package:ecommerce/utils/cart_icons.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _widgetList = [
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
    DashboardPage(),
  ];

  int nindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _builAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CartIcons.home,
            ),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CartIcons.cart,
            ),
            label: 'My cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CartIcons.favourites,
            ),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CartIcons.account,
            ),
            label: 'My Account',
          )
        ],
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: nindex,
        onTap: (index) {
          setState(() {
            nindex = index;
          });
        },
      ),
      body: _widgetList[nindex],
    );
  }

  Widget _builAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.redAccent,
      automaticallyImplyLeading: false,
      title: const Text(
        "Tactical Store",
        style: TextStyle(color: Colors.white),
      ),
      actions: const [
        Icon(
          Icons.notifications_none,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
