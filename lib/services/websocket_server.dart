import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

class WebSocketServer {
  HttpServer? _server;
  final List<WebSocket> _clients = [];
  int _currentMove = 0;
  final void Function(String) showSnackBarCallback;
  int port = 8080;
  VoidCallback? onClientsUpdated;

  WebSocketServer(this.showSnackBarCallback);

  Future<void> start() async {
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, port);

      _server!.listen((HttpRequest request) async {
        if (WebSocketTransformer.isUpgradeRequest(request)) {
          WebSocket socket = await WebSocketTransformer.upgrade(request);
          _clients.add(socket);
          onClientsUpdated?.call();
          showSnackBarCallback('Nowe połączenie: ${_clients[0].hashCode}');

          socket.listen((data) {
            _sendMove(socket);
          }, onDone: () {
            onClientsUpdated?.call();
            _clients.remove(socket);
          }, onError: (error) {
            showSnackBarCallback('Błąd WebSocket: $error');
          });
        }
      });
    } catch (e) {
      showSnackBarCallback('Błąd uruchamiania serwera: $e');
    }
  }

  void _sendMove(WebSocket client) {
    String jsonData = jsonEncode({"move": _currentMove});
    client.add(jsonData);
  }

  void updateMove(int move) {
    _currentMove = move;
    for (var client in _clients) {
      _sendMove(client);
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
