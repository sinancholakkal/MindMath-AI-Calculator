part of 'arithmetical_bloc.dart';

@immutable
sealed class ArithmeticalEvent {}

final class ArithmeticalTapEvent extends ArithmeticalEvent {
  final dynamic expression;
  final String mainInput;
  ArithmeticalTapEvent({required this.expression, required this.mainInput});
}

class ArithmeticalListenerEvent extends ArithmeticalEvent {
  final dynamic expression;
  ArithmeticalListenerEvent({required this.expression});
}
