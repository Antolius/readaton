import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:readaton/app_state.dart';
import 'package:readaton/modules/book_editor_page/containers/book_editor_view_model.dart';

class EditorPage extends StatefulWidget {
  final BookEditorViewModel model;

  EditorPage({
    @required this.model,
  });

  @override
  EditorPageState createState() {
    return new EditorPageState();
  }
}

class EditorPageState extends State<EditorPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _title;
  String _subtitle;
  String _synopsis;
  int _numberOfPages;
  String _coverImageUrl;
  List<String> _authors = [];

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      var edited = widget.model.editedBook;
      _title = edited.title;
      _subtitle = edited.subtitle;
      _synopsis = edited.synopsis;
      _numberOfPages = edited.numberOfPages;
      _coverImageUrl = edited.coverImageUrl;
      _authors = edited.authors;
    }
  }

  bool get _isEdit => widget.model.editedBook != null;

  _onSave(BuildContext context) {
    final form = _formKey.currentState;
    if (form.validate()) {
      widget.model.onSaveBook(new Book(
        title: _title,
        subtitle: _subtitle,
        synopsis: _synopsis,
        numberOfPages: _numberOfPages,
        coverImageUrl: _coverImageUrl,
        authors: _authors,
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => new Form(
        key: _formKey,
        child: new Scaffold(
          appBar: new AppBar(
            title: _isEdit ? const Text('Edit book') : const Text('Add book'),
            actions: <Widget>[
              new IconButton(
                icon: const Icon(Icons.save),
                tooltip: 'Save',
                onPressed: () => _onSave(context),
              )
            ],
            bottom: new PreferredSize(
              child: new Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 54.0,
                ),
                child: new Theme(
                  data: Theme.of(context).copyWith(
                        accentColor: Colors.black,
                        primaryColor: Colors.black54,
                      ),
                  child: new TextFormField(
                    initialValue: _title ?? '',
                    validator: (val) =>
                        val == null ? 'Title is required' : null,
                    onSaved: (val) => _title = val,
                    decoration: new InputDecoration(
                      labelText: 'Book title',
                    ),
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
              preferredSize: const Size.fromHeight(kToolbarHeight),
            ),
          ),
          body: new Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new ListView(
              children: <Widget>[
                new TextFormField(),
                new TextFormField(),
                new Row(
                  children: <Widget>[
                    const Text('Authors'),
                    new DropdownButton<String>(
                      items: widget.model.authors
                          .map((id, auth) => new MapEntry(
                              id,
                              new DropdownMenuItem(
                                child: new Container(
                                  constraints: new BoxConstraints.tightFor(
                                    width: MediaQuery.of(context).size.width -
                                        120.0,
                                  ),
                                  child: new Text(auth.name),
                                ),
                                value: id,
                              )))
                          .values
                          .toList(growable: false),
                      onChanged: (val) => setState(() {
                            _authors.add(val);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
