import 'package:equatable/equatable.dart';

abstract class AddInvestmentEvent extends Equatable {}

class FetchPatnerFirm extends AddInvestmentEvent {
  @override
  List<Object?> get props => [];
}

class FetchBankFrom extends AddInvestmentEvent {
  @override
  List<Object?> get props => [];
}

class FetchBankTo extends AddInvestmentEvent {
  @override
  List<Object?> get props => [];
}

class SelectPatnerFirm extends AddInvestmentEvent {
  final String? patnerFirmName;

  SelectPatnerFirm(this.patnerFirmName);

  @override
  List<Object?> get props => [patnerFirmName];
}

class SelectbankFrom extends AddInvestmentEvent {
  final String? bankID;

  SelectbankFrom(this.bankID);

  @override
  List<Object?> get props => [bankID];
}

class SelectBankTo extends AddInvestmentEvent {
  final String? bankTo;

  SelectBankTo(this.bankTo);

  @override
  List<Object?> get props => [bankTo];
}

class WitdhrawAmount extends AddInvestmentEvent {
  @override
  List<Object?> get props => [];
}

class SelectDate extends AddInvestmentEvent {
  final DateTime date;
  SelectDate(this.date);
  @override
  List<Object?> get props => [DateTime];
}

class DateChanged extends AddInvestmentEvent {
  final String date;
  DateChanged(this.date);
  @override
  List<Object?> get props => [DateTime];
}

class ShowDatePickerEvent extends AddInvestmentEvent {
  @override
  List<Object?> get props => [];
}

class Sendpayment extends AddInvestmentEvent {
  @override
  List<Object?> get props => [];
}

class ResetAllStates extends AddInvestmentEvent {
  @override
  List<Object?> get props => [];
}
