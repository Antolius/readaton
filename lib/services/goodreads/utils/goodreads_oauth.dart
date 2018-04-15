import 'dart:async';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:readaton/services/goodreads/utils/api_key_provider.dart';
import 'package:readaton/services/goodreads/utils/oauth_callback_server.dart';
import 'package:readaton/state/state.dart';

final callbackUri = 'http://localhost:8080';

Future<UserCredentials> obtainUserToken(GoodreadsApiKey apiKey) async {
  var client = _instantiateOauthClient(apiKey);
  var tempCredentials = await _obtainTempCredentials(client);
  await _askUserForConsent(client, tempCredentials);
  return await _obtainCredentials(client, tempCredentials);
}

oauth1.Authorization _instantiateOauthClient(
  GoodreadsApiKey apiKey,
) {
  return new oauth1.Authorization(
    new oauth1.ClientCredentials(apiKey.key, apiKey.secret),
    new oauth1.Platform(
      'https://www.goodreads.com/oauth/request_token',
      'https://www.goodreads.com/oauth/authorize',
      'https://www.goodreads.com/oauth/access_token',
      oauth1.SignatureMethods.HMAC_SHA1,
    ),
  );
}

Future<oauth1.Credentials> _obtainTempCredentials(
  oauth1.Authorization client,
) async {
  var tempCredentialsResponse = await client.requestTemporaryCredentials(
    callbackUri,
    false,
  );
  return tempCredentialsResponse.credentials;
}

Future _askUserForConsent(
  oauth1.Authorization client,
  oauth1.Credentials tempCredentials,
) async {
  var authUri = client.getResourceOwnerAuthorizationURI(
    tempCredentials.token,
    callbackURI: callbackUri,
  );

  var server = new OauthCallbackServer();
  await server.init();
  final webView = new FlutterWebviewPlugin();
  await webView.launch('$authUri&mobile=1');
  await Future.any([
    new Future.delayed(const Duration(minutes: 2)),
    server.onCallback.first,
    webView.onDestroy.first,
    webView.onUrlChanged
        .where((url) => url.startsWith('http://localhost'))
        .first,
  ]);
  await webView.close();
  await server.close();
}

Future<UserCredentials> _obtainCredentials(
  oauth1.Authorization client,
  oauth1.Credentials tempCredentials,
) async {
  var tokenResponse = await client.requestTokenCredentials(tempCredentials, '');
  var credentials = tokenResponse.credentials;
  return new UserCredentials(
    token: credentials.token,
    secret: credentials.tokenSecret,
  );
}
