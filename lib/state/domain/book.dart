import 'package:flutter/foundation.dart';
import 'package:readaton/state/state.dart';
import 'package:readaton/state/utils/image_data.dart';

class Book {
  final String title;
  final String subtitle;
  final String synopsis;
  final int numberOfPages;
  final ImageData coverImage;
  final List<String> authors;
  final String language;
  final Map<Platform, String> platformIds;

  Book({
    @required this.title,
    this.subtitle = '',
    this.synopsis = '',
    final String coverImageUrl,
    @required this.numberOfPages,
    @required this.authors,
    this.language = 'unknown',
    this.platformIds = const {},
  })
      : assert(title != null),
        assert(subtitle != null),
        assert(synopsis != null),
        assert(numberOfPages != null),
        assert(authors != null),
        this.coverImage = coverImageUrl != null && coverImageUrl.isNotEmpty
            ? new UrlImageData(imageUrl: coverImageUrl)
            : const LocalImageData(
                imageName: 'assets/images/book_cover_placeholder.jpg',
              );
}
