import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okra_distributer/view/unknown/unknown_bloc/date_picker_bloc/data_picker_event.dart';
import 'package:okra_distributer/view/unknown/unknown_bloc/date_picker_bloc/data_picker_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(DateState()) {
    on<DateEventChange>(dateEventChange);
  }

  FutureOr<void> dateEventChange(
      DateEventChange event, Emitter<DateState> emit) {
    emit(state.copyWith(date: event.date));
  }
}
