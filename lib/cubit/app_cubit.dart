import 'package:bloc/bloc.dart';
import 'package:usdcode/cubit/app_cubit_state.dart';

class AppCubit extends Cubit<CubitState> {
  AppCubit() : super(InitialState()) {
    emit(MtnState());
  }

  void changeState(int index) {
    if (index == 1) {
      emit(MtnState());
    } else if (index == 2) {
      emit(MoovState());
    } else if (index == 3) {
      emit(CeltisState());
    }
  }
}
