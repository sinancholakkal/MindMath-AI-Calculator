part of 'arithmetical_bloc.dart';

@immutable
sealed class ArithmeticalEvent {}

final class ArithmeticalTapEvent extends ArithmeticalEvent {
  final dynamic expression;
  ArithmeticalTapEvent({required this.expression});
}

class ArithmeticalListenerEvent extends ArithmeticalEvent {
  final dynamic expression;
  ArithmeticalListenerEvent({required this.expression});
}
