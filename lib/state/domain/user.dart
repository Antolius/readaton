import 'package:flutter/foundation.dart';

class UserState {
  final GoodreadsCredentials goodreadsCredentials;

  const UserState({
    this.goodreadsCredentials,
  });
}

class GoodreadsCredentials {
  final String token;
  final String secret;

  const GoodreadsCredentials({
    @required this.token,
    @required this.secret,
  });
}
