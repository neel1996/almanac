import 'package:almanac/widgets/home/feeds/feed.dart';
import 'package:almanac/widgets/home/feeds/feed_type.dart';
import 'package:flutter/material.dart';

class FeedList extends StatelessWidget {
  const FeedList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FeedType> feeds = [
      FeedType.popular,
      FeedType.recommended,
      FeedType.readingList,
    ];

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 30),
      itemBuilder: (context, index) {
        return Feed(feedType: feeds[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: feeds.length,
    );
  }
}
