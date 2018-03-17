import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

Future<String> getApiKey() async {
  String configFIleContents = await rootBundle.loadString('assets/config.yaml');
  var config = loadYaml(configFIleContents);
  var apiKey = config['google.api.key'];
  return apiKey;
}
