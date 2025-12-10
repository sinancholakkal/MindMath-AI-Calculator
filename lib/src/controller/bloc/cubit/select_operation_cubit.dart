import 'package:bloc/bloc.dart';

class SelectOperationCubit extends Cubit<String> {
  SelectOperationCubit() : super("+");

  void selectOperation(String operation) {
    emit(operation);
  }
}
