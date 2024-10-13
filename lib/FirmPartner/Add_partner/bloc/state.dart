import 'package:equatable/equatable.dart';

class PartnerState extends Equatable {
  final int? requestDuration;
  final List<Map<String, String>>? pertnerTypes;
  final String? selectedPartnerType;
  final String? selectGroupType;
  final List<Map<String, String>>? groupType;
  final bool isLoading;
  final List<Map<String, String>>? userType;
  final String? selectUserType;
  final String? firstName;
  final String? lastName;
  final String? partnerCNIC;
  final String? patnerEmail;
  final String? userName;
  final String? userPassword;
  final String? kinName;
  final String? kinCNIC;
  final String? emergencyNumber;
  final String? kinPhone;
  final String? adress;
  final String? permenantAdress;
  final String? equityHolder;
  final String? shareHolder;
  final String? bankName;
  final String? bankCode;
  final String? bankIBAN;
  final String? bankAccountNumber;

  PartnerState(
      {this.requestDuration,
      this.userType,
      this.selectUserType,
      this.userName,
      this.userPassword,
      this.pertnerTypes,
      this.kinCNIC,
      this.adress,
      this.permenantAdress,
      this.equityHolder,
      this.shareHolder,
      this.emergencyNumber,
      this.kinName,
      this.kinPhone,
      this.selectedPartnerType,
      this.selectGroupType,
      this.isLoading = false,
      this.firstName,
      this.lastName,
      this.partnerCNIC,
      this.patnerEmail,
      this.bankName,
      this.bankCode,
      this.bankIBAN,
      this.bankAccountNumber,
      this.groupType});

  PartnerState copyWith(
      {final int? requestDuration,
      List<Map<String, String>>? groupType,
      List<Map<String, String>>? pertnerTypes,
      final String? kinName,
      final String? kinCNIC,
      final String? userName,
      final String? userPassword,
      final String? emergencyNumber,
      final String? bankName,
      final String? bankCode,
      final String? bankIBAN,
      final String? bankAccountNumber,
      final String? adress,
      final String? permenantAdress,
      final String? equityHolder,
      final String? shareHolder,
      final String? kinPhone,
      String? selectUserType,
      final List<Map<String, String>>? userType,
      bool? isLoading,
      String? selectGroupType,
      final String? firstName,
      final String? lastName,
      final String? partnerCNIC,
      final String? patnerEmail,
      String? selectedPartnerType}) {
    return PartnerState(
      requestDuration: requestDuration ?? this.requestDuration,
      kinName: kinName ?? this.kinName,
      kinCNIC: kinCNIC ?? this.kinCNIC,
      adress: adress ?? this.adress,
      userName: userName ?? this.userName,
      userPassword: userPassword ?? this.userPassword,
      permenantAdress: permenantAdress ?? this.permenantAdress,
      equityHolder: equityHolder ?? this.equityHolder,
      shareHolder: shareHolder ?? this.shareHolder,
      bankName: bankName ?? this.bankName,
      bankCode: bankCode ?? this.bankCode,
      bankIBAN: bankIBAN ?? this.bankIBAN,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      emergencyNumber: emergencyNumber ?? this.emergencyNumber,
      kinPhone: kinPhone ?? this.kinPhone,
      groupType: groupType ?? this.groupType,
      userType: userType ?? this.userType,
      selectUserType: selectUserType ?? this.selectUserType,
      selectGroupType: selectGroupType ?? this.selectGroupType,
      pertnerTypes: pertnerTypes ?? this.pertnerTypes,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      partnerCNIC: partnerCNIC ?? this.partnerCNIC,
      patnerEmail: patnerEmail ?? this.patnerEmail,
      selectedPartnerType: selectedPartnerType ?? this.selectedPartnerType,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        requestDuration,
        pertnerTypes,
        selectedPartnerType,
        selectGroupType,
        userType,
        selectUserType,
        bankName,
        userName,
        userPassword,
        bankCode,
        bankIBAN,
        bankAccountNumber,
        firstName,
        lastName,
        kinName,
        kinCNIC,
        emergencyNumber,
        kinPhone,
        adress,
        permenantAdress,
        equityHolder,
        shareHolder,
        partnerCNIC,
        patnerEmail,
        isLoading,
        groupType
      ];
}
