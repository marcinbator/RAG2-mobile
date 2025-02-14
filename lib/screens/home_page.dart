import 'dart:io';

import 'package:flutter/material.dart';

import '../services/websocket_server.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebSocketServer _server;
  String _localIp = "";

  @override
  void initState() {
    super.initState();
    _server = WebSocketServer(_showSnackBar);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Adres: http://$_localIp:${_server.port}'),
            Text('Połączonych urządzeń: ${_server.connectedAmount}'),
            const SizedBox(height: 20),
            _buildControlButton("🔼 Góra", Colors.green, 1),
            const SizedBox(height: 10),
            _buildControlButton("🔽 Dół", Colors.red, -1),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(String text, Color color, int moveValue) {
    return GestureDetector(
      onTapDown: (_) => _server.updateMove(moveValue),
      onTapUp: (_) => _server.updateMove(0),
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
