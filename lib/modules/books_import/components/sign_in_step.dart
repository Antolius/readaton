import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/books_import/books_import.dart';
import 'package:readaton/state/state.dart';

Step build(BuildContext context, BooksImportViewModel model) => new Step(
      title: const Text('Sign in'),
      state: model.pageState.currentStep == 0
          ? StepState.editing
          : StepState.complete,
      content: model.hasUser
          ? new _UserPreviewSignInStep(
              profile: model.userProfile,
              onSignOut: model.onSignOut,
            )
          : new _GoodreadsSignInStep(onSignIn: model.onSignIn),
    );

class _GoodreadsSignInStep extends StatelessWidget {
  final VoidCallback onSignIn;

  _GoodreadsSignInStep({
    @required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          const Text(
              'You need to sign in with your Goodreads account before importing books.'),
          new RaisedButton(
            onPressed: onSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
}

class _UserPreviewSignInStep extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback onSignOut;

  _UserPreviewSignInStep({
    @required this.profile,
    @required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) => new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('You are currently signed in as:'),
          new _UserProfileWidget(profile),
          const Text('Want to use another account?'),
          new FlatButton(
            onPressed: onSignOut,
            child: const Text('SIGN OUT'),
          )
        ],
      );
}

class _UserProfileWidget extends StatelessWidget {
  final UserProfile profile;

  _UserProfileWidget(this.profile);

  @override
  Widget build(BuildContext context) => new Row(
        children: <Widget>[
          profile.profileImage.accept(new _ImageBuilder()),
          new Text(profile.name),
        ],
      );
}

class _ImageBuilder extends ImageDataVisitor<Widget> {
  @override
  Widget visitLocalImage(LocalImageData data) =>
      new CircleAvatar(backgroundImage: new ExactAssetImage(data.imageName));

  @override
  Widget visitUrlImage(UrlImageData data) =>
      new CircleAvatar(backgroundImage: new NetworkImage(data.imageUrl));
}
