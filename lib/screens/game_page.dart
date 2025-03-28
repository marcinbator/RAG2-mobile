import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rag_2_mobile/data/colors.dart';
import 'package:rag_2_mobile/models/game.dart';
import 'package:rag_2_mobile/screens/components/game_steering.dart';

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

  void _disconnect() {
    _server.stop();
    _server.start();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var steeringPage = GameSteering(_server.sendAction);
    List<Widget> controls = steeringPage.generateControls(widget.game, context);

    if (_server.connectedAmount == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.game.name,
            style: TextStyle(color: mainCreme),
          ),
          backgroundColor: lightGray,
          iconTheme: IconThemeData(
            color: mainOrange, //change your color here
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Steering tool address:'),
              Text('http://$_localIp:8080${widget.game.path}'),
              Text('No connected devices',
                  style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.game.name,
          style: TextStyle(color: mainCreme),
        ),
        backgroundColor: lightGray,
        iconTheme: IconThemeData(
          color: mainOrange, //change your color here
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Connected devices: ${_server.connectedAmount}'),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _disconnect,
                    child: Text(
                      'Disconnect',
                      style: TextStyle(color: mainGray),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [...controls],
                ),
              ),
            ],
          ),
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
      return "Cannot get IP";
    }
    return "";
  }
}
