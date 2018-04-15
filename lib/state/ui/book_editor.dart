class BookEditorPageState {
  final String addedAuthorId;

  const BookEditorPageState({this.addedAuthorId});

  BookEditorPageState copyWith({String addedAuthorId}) =>
      new BookEditorPageState(
          addedAuthorId: addedAuthorId ?? this.addedAuthorId);
}
