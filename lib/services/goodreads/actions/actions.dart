import 'package:readaton/state/state.dart';

class SignInWithGoodreadsAction {
  const SignInWithGoodreadsAction();
}

class AddGoodreadsUserAction {
  final UserCredentials newCredentials;
  final UserProfile newProfile;

  const AddGoodreadsUserAction(this.newCredentials, this.newProfile);
}

class SignOutFromGoodreadsAction {
  const SignOutFromGoodreadsAction();
}