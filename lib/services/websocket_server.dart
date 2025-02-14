import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

class WebSocketServer {
  final String path;
  HttpServer? _server;
  final List<WebSocket> _clients = [];
  final void Function(String) showSnackBarCallback;
  int port = 8080;
  VoidCallback? onClientsUpdated;

  WebSocketServer(this.path, this.showSnackBarCallback);

  Future<void> start() async {
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, port);
      _server!.listen((HttpRequest request) async {
        if (request.uri.path == path &&
            WebSocketTransformer.isUpgradeRequest(request)) {
          WebSocket socket = await WebSocketTransformer.upgrade(request);
          _clients.add(socket);
          onClientsUpdated?.call();
          showSnackBarCallback('New connnection: ${socket.hashCode}');

          socket.listen((data) {}, onDone: () {
            _clients.remove(socket);
            onClientsUpdated?.call();
          }, onError: (error) {
            showSnackBarCallback('WebSocket error: $error');
          });
        }
      });
    } catch (e) {
      showSnackBarCallback('Cannot run server: $e');
    }
  }

  void sendAction(String actionName, int action) {
    String jsonData = jsonEncode({actionName: action});
    for (var client in _clients) {
      client.add(jsonData);
    }
  }

  int get connectedAmount => _clients.length;

  void stop() {
    _server?.close();
    for (var client in _clients) {
      client.close();
    }
  }
}
