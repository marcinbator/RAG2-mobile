import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../data/colors.dart';

class TiltControlModal extends StatefulWidget {
  final void Function(String, double) sendAction;
  final String tooltipText;
  final String moveName;
  final bool xAxisUsed;
  final double valueOnSigned;
  final double valueOnUnsigned;
  final double valueOnNeutral;

  const TiltControlModal(
      {required this.sendAction,
      super.key,
      required this.tooltipText,
      required this.moveName,
      required this.xAxisUsed,
      required this.valueOnSigned,
      required this.valueOnUnsigned,
      required this.valueOnNeutral});

  @override
  TiltControlModalState createState() => TiltControlModalState();
}

class TiltControlModalState extends State<TiltControlModal> {
  double currentAction = 0;
  double currentPos = 0.0;
  double direction = 0.0;
  late final StreamSubscription<AccelerometerEvent> _streamSubscription;

  @override
  void initState() {
    super.initState();

    _streamSubscription = accelerometerEventStream().listen((event) {
      double newPos = widget.xAxisUsed ? event.x : event.y;
      double newDirection = 0;

      if (newPos > 0.5) {
        newDirection = widget.valueOnSigned;
        currentAction = widget.valueOnSigned;
      } else if (newPos < -0.5) {
        newDirection = widget.valueOnUnsigned;
        currentAction = widget.valueOnUnsigned;
      } else {
        newDirection = widget.valueOnNeutral;
        currentAction = widget.valueOnNeutral;
      }

      setState(() {
        currentPos = newPos;
        direction = newDirection;
      });

      widget.sendAction(widget.moveName, currentAction);
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    widget.sendAction(widget.moveName, widget.valueOnNeutral);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Tilt to control"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.tooltipText, style: TextStyle(color: mainGray)),
          const SizedBox(height: 20),
          Text("Position: ${currentPos.toStringAsFixed(2)}",
              style: TextStyle(color: mainGray)),
          Text("Move: $direction", style: TextStyle(color: mainGray)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.sendAction("move", 0);
          },
          child: const Text("Stop"),
        ),
      ],
    );
  }
}
