abstract class PatnerEvent {}

class FetchPartnerTypes extends PatnerEvent {}

class SelectPartnerType extends PatnerEvent {
  final String selectedValue;

  SelectPartnerType(this.selectedValue);

  @override
  List<Object> get props => [selectedValue];
}

class SelectGroup extends PatnerEvent {
  final String selectedValue;

  SelectGroup(this.selectedValue);

  @override
  List<Object> get props => [selectedValue];
}

class FetchGroups extends PatnerEvent {}

class FetchUser extends PatnerEvent {}

class SelectUserType extends PatnerEvent {
  final String selectedUserId;

  SelectUserType(this.selectedUserId);
}

class UpdateFirstName extends PatnerEvent {
  final String firstname;

  UpdateFirstName(this.firstname);
}

class UpdateLastName extends PatnerEvent {
  final String lastname;

  UpdateLastName(this.lastname);
}

class UpdatePartnerCNIC extends PatnerEvent {
  final String partnerCNIC;

  UpdatePartnerCNIC(this.partnerCNIC);
}

class UpdatePartnerEmail extends PatnerEvent {
  final String partnerEmail;

  UpdatePartnerEmail(this.partnerEmail);
}

class UpdateKinName extends PatnerEvent {
  final String kinName;

  UpdateKinName(this.kinName);
}

class UpdateKinCNIC extends PatnerEvent {
  final String kinCNIC;

  UpdateKinCNIC(this.kinCNIC);
}

class UpdateEmergencyNumber extends PatnerEvent {
  final String emergencyNumber;

  UpdateEmergencyNumber(this.emergencyNumber);
}

class UpdateKinMobileNumber extends PatnerEvent {
  final String kinMobileNumber;

  UpdateKinMobileNumber(this.kinMobileNumber);
}

class UpdateAdress extends PatnerEvent {
  final String address;

  UpdateAdress(this.address);
}

class PermenantAdressUpdate extends PatnerEvent {
  final String permenatAdress;

  PermenantAdressUpdate(this.permenatAdress);
}

class UpdateEquityHolder extends PatnerEvent {
  final String equityHolder;

  UpdateEquityHolder(this.equityHolder);
}

class UpdateShareHolder extends PatnerEvent {
  final String shareHolder;

  UpdateShareHolder(this.shareHolder);
}

class UpdateRequestDuration extends PatnerEvent {
  final int selectedValue;

  UpdateRequestDuration(this.selectedValue);

  @override
  List<Object?> get props => [selectedValue];
}

class UpdatebankName extends PatnerEvent {
  final String bankName;

  UpdatebankName(this.bankName);
}

class BankCode extends PatnerEvent {
  final String bankCode;

  BankCode(this.bankCode);
}

class BankIBAN extends PatnerEvent {
  final String bankIBAN;

  BankIBAN(this.bankIBAN);
}

class BankAccountNumber extends PatnerEvent {
  final String bankAccountNumber;

  BankAccountNumber(this.bankAccountNumber);
}

class UserName extends PatnerEvent {
  final String username;

  UserName(this.username);
}

class Password extends PatnerEvent {
  final String password;

  Password(this.password);
}

class ResetFormEvent extends PatnerEvent {}
