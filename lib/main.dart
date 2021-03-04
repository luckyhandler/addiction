import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'animation/animation_bloc.dart';
import 'calculation.dart';
import 'result.dart';

const int resultCount = 5;

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final random = Random();

  AnimationController animationController;
  Calculation correctCalculation;
  int correctIndexCalculation;
  int correctIndexResult;
  Animation<double> animation;

  @override
  void initState() {
    correctCalculation = createCalculation(random);
    correctIndexResult = random.nextInt(resultCount);
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AnimationBloc(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            animation = Tween<double>(begin: 500, end: constraints.maxHeight)
                .animate(animationController)
                  ..addListener(() {
                    setState(() {});
                  })
                  ..addStatusListener((state) {
                    if (state == AnimationStatus.completed) {
                      context.read<AnimationBloc>().resetAnimationState();
                    }
                  });
            return Scaffold(
                body: Column(
              children: [
                SizedBox(height: 64),
                // calculation Column
                CalculationWidget(
                    random: random, calculation: correctCalculation),
                // result Column
                Expanded(
                  child: BlocBuilder<AnimationBloc, AnimationState>(
                    builder: (context, state) {
                      if (state is CorrectAnimationState) {
                        animationController.forward();
                      }
                      return SizedBox(
                        height: animation.value,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: resultCount,
                          itemBuilder: (context, index) {
                            if (index == correctIndexResult) {
                              return ResultWidget(
                                  random: random,
                                  calculation: correctCalculation);
                            } else {
                              return ResultWidget(
                                  random: random,
                                  calculation: createCalculation(random));
                            }
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ));
          },
        ),
      );
}

const colors = [
  Colors.amberAccent,
  Colors.blueAccent,
  Colors.orangeAccent,
  Colors.deepPurpleAccent,
  Colors.cyanAccent,
  Colors.purpleAccent,
  Colors.pinkAccent,
];
