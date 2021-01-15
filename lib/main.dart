import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Addi+c+tion',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Ziehe eine Rechnung auf das Ergebnis'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

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

class _MyHomePageState extends State<MyHomePage> {
  final random = Random();

  Calculation correctCalculation;
  int correctIndexCalculation;
  int correctIndexResult;

  @override
  void initState() {
    correctCalculation = createCalculation(random);
    correctIndexCalculation = random.nextInt(5);
    correctIndexResult = random.nextInt(5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // calculation Column
            Expanded(
              child: CalculationWidget(random, correctCalculation),
            ),
            // result Column
            Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    if (index == correctIndexResult) {
                      return ResultWidget(random, correctCalculation);
                    } else {
                      return ResultWidget(random, createCalculation(random));
                    }
                  }),
            ),
          ],
        ));
  }
}

class CalculationWidget extends StatelessWidget {
  CalculationWidget(this.random, this.calculation);

  final Random random;
  final Calculation calculation;

  @override
  Widget build(BuildContext context) {
    final color =
        Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    return Draggable<int>(
        data: calculation.result,
        feedback: SizedBox(
          width: 180,
          child: CalculationCard(
            calculationString: calculation.calculationString,
            color: color,
          ),
        ),
        child: CalculationCard(
          calculationString: calculation.calculationString,
          color: color,
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
  Widget build(BuildContext context) => SizedBox(
      height: 180,
      child: Card(
          elevation: 4,
          color: color,
          child: Center(child: Text(calculationString))));
}

class ResultWidget extends StatelessWidget {
  ResultWidget(this.random, this.calculation);

  final Random random;
  final Calculation calculation;

  @override
  Widget build(BuildContext context) {
    final color =
        Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    return DragTarget<int>(
      onWillAccept: (_) => true,
      onAccept: (details) {
        print(details);
        if (details == calculation.result) {
          print('correct');
        }
      },
      builder: (context, List<int> candidateData, List<dynamic> rejectedData) {
        return SizedBox(
          height: 180,
          child: Card(
              elevation: 4,
              color: color,
              child: Center(child: Text(calculation.resultString))),
        );
      },
    );
  }
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
