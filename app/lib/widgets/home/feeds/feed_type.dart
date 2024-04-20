enum FeedType {
  popular('Popular Right Now'),
  recommended('Recommended for You'),
  readingList('Your Reading List');

  const FeedType(this.title);

  final String title;
}
