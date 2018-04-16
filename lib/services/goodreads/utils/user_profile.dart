import 'dart:async';

import 'package:readaton/services/common/utils/wrapper.dart';
import 'package:readaton/services/goodreads/utils/api_key_provider.dart';
import 'package:readaton/services/goodreads/utils/goodreads_client.dart';
import 'package:readaton/state/domain/user.dart';
import 'package:xml/xml.dart' as xml;

Future<UserProfile> fetchUserProfile(
  GoodreadsApiKey apiKey,
  UserCredentials credentials,
) async {
  var client = new GoodreadsClient(apiKey, credentials);
  var platformId = await _fetchGoodreadsUserId(client);
  var profile = await _fetchNameAndPicture(client, platformId);

  return profile['picture'] != null && profile['picture'].isNotEmpty
      ? new UserProfile(
          platformId: platformId,
          name: profile['name'],
          profileImageUrl: profile['picture'],
        )
      : new UserProfile(
          platformId: platformId,
          name: profile['name'],
        );
}

Future<String> _fetchGoodreadsUserId(client) async {
  var response = await client.read('${client.url}/api/auth_user');
  var wrapper = new Wrapper.wrapXml(xml.parse(response));
  return wrapper.pluck<String>('user.id');
}

Future<Map<String, String>> _fetchNameAndPicture(client, platformId) async {
  var response = await client.read('${client.url}/user/show/$platformId.xml');
  var wrapper = new Wrapper.wrapXml(xml.parse(response));
  var name = wrapper.pluckFirst<String>(
    ['user.user_name', 'user.name'],
    'Hero Protagonist',
  );
  var picture = wrapper.pluckFirst<String>(
    ['user.image_url', 'user.small_image_url'],
  );
  return {'name': name, 'picture': picture};
}
