import 'package:equatable/equatable.dart';

class IsVisibleState extends Equatable {
  final bool isVisible;

  IsVisibleState({this.isVisible = false});
  IsVisibleState copyWith({bool? isVisible}) {
    return IsVisibleState(isVisible: isVisible ?? this.isVisible);
  }

  @override
  List<Object?> get props => [isVisible];
}
