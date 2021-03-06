import 'package:readaton/services/common/utils/wrapper.dart';
import 'package:readaton/state/state.dart';
import 'package:uuid/uuid.dart';

final _uuid = new Uuid();

class GoogleBookParser {
  final Wrapper googleBook;

  GoogleBookParser(Map<String, dynamic> googleBook)
      : googleBook = new Wrapper.wrapMap(googleBook);

  void populate(Map<String, Book> books, Map<String, Author> authors) {
    List<String> authorIds = _parseAuthors(authors);
    books.putIfAbsent(_uuid.v4(), () => _parseBook(authorIds));
  }

  List<String> _parseAuthors(Map<String, Author> existingAuthors) {
    List<String> googleAuthors = googleBook.pluck('volumeInfo.authors', []);
    List<String> usedAuthorIds = [];
    for (String authorName in googleAuthors) {
      String authorId = _findAuthorByName(existingAuthors, authorName);
      if (authorId == null) {
        authorId = _uuid.v4();
        existingAuthors.putIfAbsent(
            authorId, () => new Author(name: authorName));
      }
      usedAuthorIds.add(authorId);
    }
    return usedAuthorIds;
  }

  String _findAuthorByName(
      Map<String, Author> existingAuthors, String authorName) {
    String existingAuthorId;
    existingAuthors.forEach((key, auth) {
      if (auth.name == authorName) {
        existingAuthorId = key;
      }
    });
    return existingAuthorId;
  }

  Book _parseBook(List<String> authorIds) => new Book(
        title: googleBook.pluck('volumeInfo.title', ''),
        numberOfPages: googleBook.pluck('volumeInfo.pageCount', 0),
        coverImageUrl: googleBook.pluckFirst([
          'volumeInfo.imageLinks.extraLarge',
          'volumeInfo.imageLinks.large',
          'volumeInfo.imageLinks.medium',
          'volumeInfo.imageLinks.small',
          'volumeInfo.imageLinks.thumbnail',
        ], ''),
        authors: authorIds,
        subtitle: googleBook.pluck('volumeInfo.subtitle', ''),
        synopsis: googleBook.pluck('volumeInfo.description', ''),
        language: googleBook.pluck('volumeInfo.language'),
      );
}
