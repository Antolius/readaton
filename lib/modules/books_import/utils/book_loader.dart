import 'package:readaton/services/common/utils/wrapper.dart';
import 'package:readaton/state/state.dart';
import 'package:uuid/uuid.dart';
import 'package:xml/xml.dart';

final _uuid = new Uuid();

loadBookIfNew(
  XmlElement bookXml,
  AppState state,
  Map<String, Author> newAuthors,
  Map<String, Book> newBooks,
) {
  var wrapper = new Wrapper.wrapXmlElement(bookXml);
  var platformId = wrapper.pluck('id');

  for (var book in state.books.values) {
    if (book.platformIds[Platform.GOODREADS] == platformId) {
      continue;
    }
  }

  var authors = <String>[];
  var authorXmls = bookXml.findAllElements('author');
  for (var authorXml in authorXmls) {
    authors.add(_loadAuthorIfNew(authorXml, state, newAuthors));
  }

  var newBookId = _uuid.v4();
  newBooks[newBookId] = new Book(
    title: wrapper.pluckFirst([
      'title_without_series',
      'title',
    ]),
    subtitle: wrapper.pluck('title') ?? '',
    synopsis: wrapper.pluck('description') ?? '',
    coverImageUrl: wrapper.pluckFirst([
      'large_image_url',
      'image_url',
      'small_image_url',
    ]),
    numberOfPages: int.parse(wrapper.pluck('num_pages') ?? '0'),
    authors: authors,
    platformIds: {
      Platform.GOODREADS: platformId,
      Platform.ISBN: wrapper.pluck('isbn'),
      Platform.ISBN13: wrapper.pluck('isbn13'),
    },
  );
  return newBookId;
}

String _loadAuthorIfNew(
  XmlElement authorXml,
  AppState state,
  Map<String, Author> newAuthors,
) {
  var wrapped = new Wrapper.wrapXmlElement(authorXml);
  var platformId = wrapped.pluck('id');

  for (var auth in state.authors.entries) {
    if (auth.value.platformIds[Platform.GOODREADS] == platformId) {
      return auth.key;
    }
  }
  for (var auth in newAuthors.entries) {
    if (auth.value.platformIds[Platform.GOODREADS] == platformId) {
      return auth.key;
    }
  }

  var newAuthorId = _uuid.v4();
  newAuthors[newAuthorId] = new Author(
    name: wrapped.pluck('name'),
    profileImageUrl: wrapped.pluckFirst([
      'image_url',
      'small_image_url',
    ]),
    platformIds: {Platform.GOODREADS: platformId},
  );
  return newAuthorId;
}
