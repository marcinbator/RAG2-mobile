import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rag_2_mobile/models/Game.dart';

import '../services/websocket_server.dart';

class GamePage extends StatefulWidget {
  final Game game;

  const GamePage({super.key, required this.game});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late WebSocketServer _server;
  String _localIp = "";

  @override
  void initState() {
    super.initState();
    _server = WebSocketServer(widget.game.path, _showSnackBar);
    _server.start().then((_) {
      setState(() {});
    });

    _server.onClientsUpdated = () {
      setState(() {});
    };

    _getLocalIpAddress().then((ip) {
      setState(() {
        _localIp = ip;
      });
    });
  }

  @override
  void dispose() {
    _server.stop();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildControlButton(
      String text, Color color, String actionName, int action) {
    return GestureDetector(
      onTapDown: (_) => _server.sendAction(actionName, action),
      onTapUp: (_) => _server.sendAction(actionName, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> controls;

    if (widget.game.path == "/pong") {
      controls = [
        _buildControlButton("Góra", Colors.green, "move", 1),
        const SizedBox(height: 10),
        _buildControlButton("Dół", Colors.red, "move", -1),
      ];
    } else if (widget.game.path == "/flappy") {
      controls = [
        _buildControlButton("Jump", Colors.green, "jump", 1),
      ];
    } else {
      controls = [const Text("Brak sterowania dla tej gry")];
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.game.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Adres: http://$_localIp:8080${widget.game.path}'),
            Text('Połączonych urządzeń: ${_server.connectedAmount}'),
            const SizedBox(height: 20),
            ...controls,
          ],
        ),
      ),
    );
  }

  Future<String> _getLocalIpAddress() async {
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4 &&
              !addr.address.startsWith('127')) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      return "Nie udało się pobrać IP";
    }
    return "";
  }
}
