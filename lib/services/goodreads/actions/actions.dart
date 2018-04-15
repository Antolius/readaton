import 'package:readaton/state/state.dart';

class SignInWithGoodreadsAction {
  const SignInWithGoodreadsAction();
}

class AddGoodreadsUserCredentials {
  final GoodreadsCredentials newCredentials;

  const AddGoodreadsUserCredentials(this.newCredentials);
}