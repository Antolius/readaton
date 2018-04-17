import 'dart:async';
import 'dart:io';

class OauthCallbackServer {
  final StreamController<Null> _onCallbackListener = new StreamController();

  bool _initialized = false;
  HttpServer _server;
  Stream<Null> _onCallback;
  Stream<Null> get onCallback =>
      _onCallback ??= _onCallbackListener.stream.asBroadcastStream();

  close() async {
    await _server?.close();
    await _onCallbackListener?.close();
  }

  init() async {
    if (_initialized) return;

    _server = await HttpServer.bind(
      InternetAddress.LOOPBACK_IP_V4,
      8080,
      shared: true,
    );
    _initialized = true;

    _server.listen(_handleCallback);
  }

  void _handleCallback(HttpRequest req) async {
    var uri = req.uri;
    print('Received callback: ${uri.toString()}');
    req.response
      ..statusCode = 200
      ..headers.set('Content-Type', ContentType.HTML.mimeType)
      ..write(_responseBody);

    print(uri.toString());
    await req.response.close();

    _onCallbackListener.add(null);
  }

  String get _responseBody => """
        <html>
          <h1>Sign in successful</h1>
          <p>Thank you for signing in with your Goodreads account.</p>
        </html>
      """;
}
