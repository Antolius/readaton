import 'package:readaton/state/state.dart';

class UpdateExistingBookAction {
  final String bookId;
  final Book updatedBook;

  UpdateExistingBookAction(this.bookId, this.updatedBook);
}

class AddNewBookAction {
  final Book newBook;

  AddNewBookAction(this.newBook);
}

class AddNewAuthorAction {
  final Author newAuthor;

  AddNewAuthorAction(this.newAuthor);
}