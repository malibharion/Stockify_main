import 'package:equatable/equatable.dart';

class WithdrawState extends Equatable {
  final List<Map<String, dynamic>>? patnerFirmList;
  final String? selectPatnerFirm;
  final List<Map<String, dynamic>>? bankToList;
  final String? bankTo;
  final String? selectedDate;

  final List<Map<String, dynamic>>? bankFormList;
  final List<Map<String, dynamic>>? filteredBankList;
  final String? selectBankForm;
  final String? widhtdrawAmount;
  final DateTime? addDate;
  final bool isLoading;

  WithdrawState(
      {this.patnerFirmList,
      this.selectPatnerFirm,
      this.bankToList,
      this.bankTo,
      this.selectedDate,
      this.filteredBankList,
      this.bankFormList,
      this.isLoading = false,
      this.selectBankForm,
      this.widhtdrawAmount,
      this.addDate});

  WithdrawState copywith(
      {final List<Map<String, dynamic>>? patnerFirmList,
      List<Map<String, dynamic>>? filteredBankList,
      final String? bankTo,
      final List<Map<String, dynamic>>? bankToList,
      final String? selectedDate,
      final bool? isLoading,
      final String? selectPatnerFirm,
      final List<Map<String, dynamic>>? bankFormList,
      final String? selectBankForm,
      final String? widhtdrawAmount,
      final DateTime? addDate}) {
    return WithdrawState(
      patnerFirmList: patnerFirmList ?? this.patnerFirmList,
      bankToList: bankToList ?? this.bankToList,
      bankTo: bankTo ?? this.bankTo,
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
      filteredBankList: filteredBankList ?? this.filteredBankList,
      selectPatnerFirm: selectPatnerFirm ?? this.selectPatnerFirm,
      bankFormList: bankFormList ?? this.bankFormList,
      selectBankForm: selectBankForm ?? this.selectBankForm,
      widhtdrawAmount: widhtdrawAmount ?? this.widhtdrawAmount,
    );
  }

  @override
  List<Object?> get props => [
        patnerFirmList,
        selectPatnerFirm,
        bankFormList,
        selectBankForm,
        widhtdrawAmount,
        selectedDate,
        filteredBankList,
        addDate,
        isLoading,
        bankTo,
        bankToList
      ];
}
