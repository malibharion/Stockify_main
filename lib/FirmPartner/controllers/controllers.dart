import 'package:flutter/material.dart';

class Controllers {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final kinNameController = TextEditingController();
  final kinCNICController = TextEditingController();
  final kinContactNumberController = TextEditingController();
  final partnerCNICController = TextEditingController();
  final emergencyNumberController = TextEditingController();
  final ownerEmailController = TextEditingController();
  final addressController = TextEditingController();
  final permenantAddressController = TextEditingController();
  final capitalInvestmentController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final bankName = TextEditingController();
  final bankCode = TextEditingController();
  final bankIBAN = TextEditingController();
  final bankAccountNumber = TextEditingController();

  void dispose() {
    bankName.dispose();
    bankCode.dispose();
    bankIBAN.dispose();
    bankAccountNumber.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    kinNameController.dispose();
    kinCNICController.dispose();
    kinContactNumberController.dispose();
    partnerCNICController.dispose();
    emergencyNumberController.dispose();
    ownerEmailController.dispose();
    addressController.dispose();
    permenantAddressController.dispose();
    capitalInvestmentController.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void clear() {
    bankName.clear();
    bankCode.clear();
    bankIBAN.clear();
    bankAccountNumber.clear();
    firstNameController.clear();
    lastNameController.clear();
    kinNameController.clear();
    kinCNICController.clear();
    kinContactNumberController.clear();
    partnerCNICController.clear();
    emergencyNumberController.clear();
    ownerEmailController.clear();
    addressController.clear();
    permenantAddressController.clear();
    capitalInvestmentController.clear();
    usernameController.clear();
    passwordController.clear();
  }

  void clearBankName() {
    bankName.clear();
  }

  void clearBankCode() {
    bankCode.clear();
  }

  void clearBankIBAN() {
    bankIBAN.clear();
  }

  void clearBankAccountNumber() {
    bankAccountNumber.clear();
  }

  void clearFirstName() {
    firstNameController.clear();
  }

  void clearLastName() {
    lastNameController.clear();
  }

  void clearKinName() {
    kinNameController.clear();
  }

  void clearKinCNIC() {
    kinCNICController.clear();
  }

  void clearKinContactNumber() {
    kinContactNumberController.clear();
  }

  void clearPartnerCNIC() {
    partnerCNICController.clear();
  }

  void clearEmergencyNumber() {
    emergencyNumberController.clear();
  }

  void clearOwnerEmail() {
    ownerEmailController.clear();
  }

  void clearAddress() {
    addressController.clear();
  }

  void clearPermanentAddress() {
    permenantAddressController.clear();
  }

  void clearCapitalInvestment() {
    capitalInvestmentController.clear();
  }

  void clearUsername() {
    usernameController.clear();
  }

  void clearPassword() {
    passwordController.clear();
  }
}
