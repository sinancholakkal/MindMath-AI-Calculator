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
  final int? cursorPos;
  ContinueState({required this.mainInput, this.cursorPos});
}

class ResultState extends ArithmeticalState {
  final String result;
  final int cursorPos;
  ResultState({required this.result, required this.cursorPos});
}

class ListenerState extends ArithmeticalState {
  final String result;
  ListenerState({required this.result});
}
