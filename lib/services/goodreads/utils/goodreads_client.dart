import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:readaton/services/goodreads/utils/api_key_provider.dart';
import 'package:readaton/state/domain/user.dart';

class GoodreadsClient extends oauth1.Client {
  GoodreadsClient(
    GoodreadsApiKey apiKey,
    UserCredentials credentials,
  )
      : super(
          oauth1.SignatureMethods.HMAC_SHA1,
          new oauth1.ClientCredentials(
            apiKey.key,
            apiKey.secret,
          ),
          new oauth1.Credentials(
            credentials.token,
            credentials.secret,
          ),
        );

  String get url => 'https://www.goodreads.com';
}
