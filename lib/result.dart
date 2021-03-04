import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'animation/animation_bloc.dart';
import 'calculation.dart';
import 'main.dart';

class ResultWidget extends StatefulWidget {
  const ResultWidget({Key key, this.random, this.calculation})
      : super(key: key);

  final Random random;
  final Calculation calculation;

  @override
  _ResultWidgetState createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  Color color;

  @override
  void initState() {
    super.initState();
    color = colors[widget.random.nextInt(colors.length - 1)];
  }

  @override
  Widget build(BuildContext context) => DragTarget<int>(
        onWillAccept: (_) => true,
        onAccept: (details) {
          print(details);
          if (details == widget.calculation.result) {
            print('correct');
            context.read<AnimationBloc>().runCorrectAnimation();
          }
        },
        builder: (context, candidateData, rejectedData) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 240,
            child: Material(
                type: MaterialType.circle,
                elevation: 4,
                color: color,
                child: Center(
                    child: Text(
                  widget.calculation.resultString,
                  style: Theme.of(context).textTheme.headline6,
                ))),
          ),
        ),
      );
}
