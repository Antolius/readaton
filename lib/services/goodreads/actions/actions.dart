import 'package:readaton/app_state.dart';

class SignInWithGoodreadsAction {
  const SignInWithGoodreadsAction();
}

class AddGoodreadsUserCredentials {
  final GoodreadsCredentials newCredentials;

  const AddGoodreadsUserCredentials(this.newCredentials);
}