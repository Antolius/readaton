import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

Future<GoodreadsApiKey> getApiKey() async {
  String configFIleContents = await rootBundle.loadString('assets/config.yaml');
  var config = loadYaml(configFIleContents);
  config = config['goodreads.api'];
  return new GoodreadsApiKey(
    key: config['key'],
    secret: config['secret'],
  );
}

class GoodreadsApiKey {
  final String key;
  final String secret;

  GoodreadsApiKey({
    @required this.key,
    @required this.secret,
  })
      : assert(key != null && key.isNotEmpty),
        assert(secret != null && secret.isNotEmpty);
}
