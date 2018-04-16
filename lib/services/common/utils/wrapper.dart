import 'package:xml/xml.dart';

abstract class Wrapper {
  factory Wrapper.wrapMap(Map<String, dynamic> map) => new _MapWrapper(map);

  factory Wrapper.wrapXml(XmlDocument xml) => new _XmlWrapper(xml.rootElement);

  factory Wrapper.wrapXmlElement(XmlElement xml) => new _XmlWrapper(xml);

  Wrapper._internal();

  T pluck<T>(String path, [T defaultValue]);

  T pluckFirst<T>(List<String> paths, [T defaultValue]) {
    for (String path in paths) {
      var value = pluck(path);
      if (value != null) return value;
    }
    return defaultValue;
  }
}

class _MapWrapper extends Wrapper {
  final Map<String, dynamic> _source;

  _MapWrapper(this._source) : super._internal();

  @override
  T pluck<T>(String path, [T defaultValue]) {
    var props = path.split('.');
    var value = _source;
    for (String prop in props) {
      value = value[prop];
      if (value == null) return defaultValue;
    }
    return value as T;
  }
}

class _XmlWrapper extends Wrapper {
  final XmlElement _source;

  _XmlWrapper(this._source) : super._internal();

  @override
  T pluck<T>(String path, [T defaultValue]) {
    var props = path.split('.');
    var element = _source;
    for (String prop in props) {
      var attribute = element.getAttribute(prop);
      if (attribute != null && attribute.isNotEmpty) return attribute as T;
      element = element.findElements(prop).first;
      if (element == null) return defaultValue;
    }
    var value = element.text;
    if (value == null || value.isEmpty) return null;
    return value as T;
  }
}
