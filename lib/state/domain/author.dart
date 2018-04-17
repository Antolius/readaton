import 'package:flutter/foundation.dart';
import 'package:readaton/state/state.dart';
import 'package:readaton/state/utils/image_data.dart';

class Author {
  final String name;
  final ImageData profileImage;
  final Map<Platform, String> platformIds;

  Author({
    String profileImageUrl,
    @required this.name,
    this.platformIds = const {},
  })
      : assert(name != null),
        this.profileImage =
            profileImageUrl != null && profileImageUrl.isNotEmpty
                ? new UrlImageData(imageUrl: profileImageUrl)
                : const LocalImageData(
                    imageName: 'assets/images/avatar_placeholder.png',
                  );
}
