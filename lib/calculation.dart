import 'dart:math';

import 'package:flutter/material.dart';

import 'main.dart';

class Calculation {
  Calculation({
    this.summand1,
    this.summand2,
    this.result,
    this.calculationString,
    this.resultString,
  });

  final int summand1;
  final int summand2;
  final int result;

  final String calculationString;
  final String resultString;
}

class CalculationWidget extends StatelessWidget {
  const CalculationWidget({
    @required this.random,
    @required this.calculation,
  });

  final Random random;
  final Calculation calculation;

  @override
  Widget build(BuildContext context) {
    final color = colors[random.nextInt(colors.length - 1)];

    return Draggable<int>(
        data: calculation.result,
        feedback: Container(
          height: 280,
          width: 280,
          child: CalculationCard(
            calculationString: calculation.calculationString,
            color: color,
          ),
        ),
        childWhenDragging: null,
        child: Container(
          height: 280,
          width: 280,
          child: CalculationCard(
            calculationString: calculation.calculationString,
            color: color,
          ),
        ));
  }
}

class CalculationCard extends StatelessWidget {
  const CalculationCard(
      {Key key, @required this.calculationString, @required this.color})
      : super(key: key);

  final String calculationString;
  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          type: MaterialType.circle,
          elevation: 4,
          color: color,
          child: Center(
            child: Text(
              calculationString,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      );
}

Calculation createCalculation(Random random) {
  final summand1 = random.nextInt(10);
  final summand2 = random.nextInt(10);
  final result = summand1 + summand2;

  return Calculation(
      summand1: random.nextInt(10),
      summand2: random.nextInt(10),
      result: result,
      calculationString: '$summand1 + $summand2',
      resultString: '$result');
}
