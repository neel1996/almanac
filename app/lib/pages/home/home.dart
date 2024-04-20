import 'package:almanac/widgets/home/feeds/feed_list.dart';
import 'package:almanac/widgets/home/search_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.list,
      Icons.home,
      Icons.person,
    ];

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        items: [
          for (var icon in icons)
            circleWrapper(
              Icon(
                icon,
                size: 30,
                color: Colors.blueGrey,
              ),
            ),
        ],
        height: 60,
        color: Colors.blueGrey,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white10,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          //Handle button tap
        },
      ),
      body: Container(
        color: Colors.blueGrey[50],
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Searchbar(),
                Expanded(
                  child: SizedBox(
                    child: FeedList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circleWrapper(Widget child) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: child,
    );
  }
}
