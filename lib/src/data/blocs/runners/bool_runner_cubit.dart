import 'package:flutter_bloc/flutter_bloc.dart';

class BoolRunnerCubit extends Cubit<bool> {
  BoolRunnerCubit(super.start);
  void set(bool set) => emit(set);
}
