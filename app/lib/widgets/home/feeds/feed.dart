import 'package:almanac/widgets/home/feeds/feed_item.dart';
import 'package:almanac/widgets/home/feeds/feed_type.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  const Feed({super.key, required this.feedType});

  final FeedType feedType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feedType.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          const FeedItem(),
        ],
      ),
    );
  }
}
