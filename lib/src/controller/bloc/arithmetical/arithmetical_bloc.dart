import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

part 'arithmetical_event.dart';
part 'arithmetical_state.dart';

class ArithmeticalBloc extends Bloc<ArithmeticalEvent, ArithmeticalState> {
  ArithmeticalBloc() : super(ArithmeticalInitial()) {
    String allInput = "";
    on<ArithmeticalTapEvent>((event, emit) {
      dynamic data = event.expression;
      if (data is String && data != 'AC' && data != '=') {
        if (allInput.isEmpty) {
          allInput += data;
        } else if ("+-x/%÷".contains(allInput[allInput.length - 1]) &&
            (data == 'x' ||
                data == '/' ||
                data == "+" ||
                data == "-" ||
                data == "%" ||
                data == "÷")) {
          log("Last is operator");
          allInput = allInput =
              allInput.substring(0, allInput.length - 1) + data;
        } else {
          log("Last is number");
          allInput += data;
        }

        log(allInput.toString());
        emit(ContinueState(mainInput: allInput));
      } else if (data == "AC") {
        allInput = "";
        emit(ContinueState(mainInput: "0"));
      } else if (data == Icons.backspace_outlined) {
        allInput = allInput.substring(0, allInput.length - 1);
        emit(ContinueState(mainInput: allInput));
      } else if (data == '=') {
        log(allInput.toString());
        log(event.mainInput.toString());
        double result = calCulateResult(event.mainInput);

        allInput = result.toString();
        emit(ResultState(result: allInput));
      }
    });
    on<ArithmeticalListenerEvent>((event, emit) {
      double result = calCulateResult(event.expression);
      emit(ListenerState(result: result.toString()));
    });
  }
  double calCulateResult(String allInput) {
    allInput = allInput.replaceAll('x', '*');
    allInput = allInput.replaceAll('÷', '/');
    try {
      GrammarParser p = GrammarParser();
      Expression exp = p.parse(allInput);

      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval;
    } catch (e) {
      log(e.toString());
    }
    return 0;
  }
}
