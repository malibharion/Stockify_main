import 'package:equatable/equatable.dart';

abstract class WithdrawEvent extends Equatable {}

class FetchPatnerFirm extends WithdrawEvent {
  @override
  List<Object?> get props => [];
}

class FetchBankFrom extends WithdrawEvent {
  @override
  List<Object?> get props => [];
}

class FetchBankTo extends WithdrawEvent {
  @override
  List<Object?> get props => [];
}

class SelectPatnerFirm extends WithdrawEvent {
  final String? patnerFirmName;

  SelectPatnerFirm(this.patnerFirmName);

  @override
  List<Object?> get props => [patnerFirmName];
}

class SelectbankFrom extends WithdrawEvent {
  final String? bankID;

  SelectbankFrom(this.bankID);

  @override
  List<Object?> get props => [bankID];
}

class SelectBankTo extends WithdrawEvent {
  final String? bankTo;

  SelectBankTo(this.bankTo);

  @override
  List<Object?> get props => [bankTo];
}

class WitdhrawAmount extends WithdrawEvent {
  @override
  List<Object?> get props => [];
}

class SelectDate extends WithdrawEvent {
  final DateTime date;
  SelectDate(this.date);
  @override
  List<Object?> get props => [DateTime];
}

class DateChanged extends WithdrawEvent {
  final String date;
  DateChanged(this.date);
  @override
  List<Object?> get props => [DateTime];
}

class ShowDatePickerEvent extends WithdrawEvent {
  @override
  List<Object?> get props => [];
}

class Sendpayment extends WithdrawEvent {
  @override
  List<Object?> get props => [];
}

class ResetAllStates extends WithdrawEvent {
  @override
  List<Object?> get props => [];
}
