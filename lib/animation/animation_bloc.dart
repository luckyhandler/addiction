import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class AnimationBloc extends Cubit<AnimationState> {
  AnimationBloc() : super(InitialAnimationState());

  void runCorrectAnimation() => emit(CorrectAnimationState());

  void runWrongAnimation() => emit(WrongAnimationState());

  void resetAnimationState() => emit(InitialAnimationState());
}

@immutable
abstract class AnimationState {}

class InitialAnimationState extends AnimationState {}

class CorrectAnimationState extends AnimationState {}

class WrongAnimationState extends AnimationState {}
