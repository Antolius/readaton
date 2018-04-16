import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/modules/books_import/books_import.dart';
import 'package:readaton/state/state.dart';

Step build(BuildContext context, BooksImportViewModel model) => new Step(
      title: const Text('Sign in'),
      state: _mapState(model.pageState),
      content: _buildStepContent(model),
    );

StepState _mapState(BooksImportPageState state) {
  if (state.currentStep == 0) return StepState.editing;

  switch (state.stepStates[0]) {
    case ImportStepState.COMPLETE:
      return StepState.complete;
    case ImportStepState.ERROR:
      return StepState.error;
    default:
      return StepState.indexed;
  }
}

Widget _buildStepContent(BooksImportViewModel model) {
  switch (model.pageState.stepStates[0]) {
    case ImportStepState.INCOMPLETE:
      return new _GoodreadsSignInStep(
        onSignIn: model.onSignIn,
      );
    case ImportStepState.LOADING:
      return new _LoadingStep();
    case ImportStepState.COMPLETE:
      return new _UserPreviewSignInStep(
        profile: model.userProfile,
        onSignOut: model.onSignOut,
      );
    case ImportStepState.ERROR:
      return new _ErrorOnSignInStep(
        onSignIn: model.onSignIn,
      );
  }
  assert(false);
  return null;
}

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

class _LoadingStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          const Text('Signing you in...'),
          const CircularProgressIndicator(),
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
          new Row(
            children: <Widget>[
              profile.profileImage.accept(new _ImageBuilder()),
              new Text(profile.name),
            ],
          ),
          const Text('Want to use another account?'),
          new FlatButton(
            onPressed: onSignOut,
            child: const Text('SIGN OUT'),
          )
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

class _ErrorOnSignInStep extends StatelessWidget {
  final VoidCallback onSignIn;

  _ErrorOnSignInStep({
    @required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          const Text('Error signing in. Please try again:'),
          new RaisedButton(
            onPressed: onSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
}
