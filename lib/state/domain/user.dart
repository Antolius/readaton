import 'package:flutter/foundation.dart';
import 'package:readaton/state/utils/image_data.dart';

enum Platform { GOODREADS }

class UserState {
  final Map<Platform, UserCredentials> credentials;
  final Map<Platform, UserProfile> profiles;

  const UserState({
    this.credentials = const {},
    this.profiles = const {},
  })
      : assert(credentials != null),
        assert(profiles != null);
}

class UserCredentials {
  final String token;
  final String secret;

  UserCredentials({
    @required this.token,
    @required this.secret,
  })
      : assert(token != null && token.isNotEmpty),
        assert(secret != null && secret.isNotEmpty);
}

class UserProfile {
  final String platformId;
  final String name;
  final ImageData profileImage;

  UserProfile({
    @required this.platformId,
    @required this.name,
    String profileImageUrl,
  })
      : assert(platformId != null && platformId.isNotEmpty),
        assert(name != null && name.isNotEmpty),
        profileImage = profileImageUrl != null && profileImageUrl.isNotEmpty
            ? new UrlImageData(imageUrl: profileImageUrl)
            : const LocalImageData(
                imageName: 'assets/images/avatar_placeholder.png',
              );
}
