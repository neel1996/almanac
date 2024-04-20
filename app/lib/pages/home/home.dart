import 'package:auto_route/annotations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.fastOutSlowIn,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        height: 12,
        onTap: (value) {},
        items: const [
          Icon(
            Icons.home,
            color: Colors.blueGrey,
          ),
          Icon(
            Icons.search,
            color: Colors.blueGrey,
          )
        ],
      ),
    );
  }
}
