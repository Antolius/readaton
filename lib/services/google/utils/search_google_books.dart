import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:readaton/services/google/utils/api_key_provider.dart';

final _httpClient = new HttpClient();

Future<Map<String, dynamic>> searchFor(String query) async {
  final url = new Uri.https(
    'www.googleapis.com',
    'books/v1/volumes',
    {
      'key': await getApiKey(),
      'q': query,
      'orderBy': 'relevance',
      'maxResults': '40',
      'projection': 'full',
    },
  );
  final request = await _httpClient.getUrl(url);
  final response = await request.close();
  final responseBody = await response.transform(UTF8.decoder).join();
  return JSON.decode(responseBody);
}