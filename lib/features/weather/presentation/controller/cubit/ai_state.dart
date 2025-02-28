part of 'ai_cubit.dart';

abstract class AIState extends Equatable {
  @override
  List<Object> get props => [];
}

class AIInitial extends AIState {}

class AILoading extends AIState {}

class AISuccess extends AIState {
  final List prediction;
  AISuccess(this.prediction);

  @override
  List<Object> get props => [prediction];
}

class AIFailure extends AIState {
  final String error;
  AIFailure(this.error);

  @override
  List<Object> get props => [error];
}
