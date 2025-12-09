part of 'arithmetical_bloc.dart';

@immutable
sealed class ArithmeticalState {}

final class ArithmeticalInitial extends ArithmeticalState {}

// class AllClearedState extends ArithmeticalState {
//   String mainInput;
//   AllClearedState({this.mainInput = "0"});
// }
class ContinueState extends ArithmeticalState {
  final String mainInput;
  ContinueState({required this.mainInput});
}

class ResultState extends ArithmeticalState {
  final String result;
  ResultState({required this.result});
}

class ListenerState extends ArithmeticalState {
  final String result;
  ListenerState({required this.result});
}
