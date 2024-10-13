import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:okra_distributer/Reports/Store%20Sale%20Purchase%20Report/blocs/VisibilityBloc/visibilityEvent.dart';
import 'package:okra_distributer/Reports/Store%20Sale%20Purchase%20Report/blocs/VisibilityBloc/visibilityState.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, IsVisibleState> {
  VisibilityBloc() : super(IsVisibleState()) {
    on<VisibilityEvent>((event, emit) {
      emit(state.copyWith(isVisible: !state.isVisible));
    });
  }
}
