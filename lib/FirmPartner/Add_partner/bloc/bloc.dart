import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/event.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/state.dart';
import 'package:okra_distributer/payment/Db/dbhelper.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../payment/views/Constant.dart';

class PartnerBloc extends Bloc<PatnerEvent, PartnerState> {
  final Dio dio;
  String? token;
  int? appId;
  String? firmId;
  PartnerBloc({required this.dio}) : super(PartnerState()) {
    _initizaPreferences();
    on<SelectPartnerType>(_selectPartnerType);
    on<FetchPartnerTypes>(_fetchPartnerTypes);
    on<SelectGroup>(_selectGroup);
    on<FetchGroups>(_fetchGroups);
    on<FetchUser>(_fetchUser);
    on<SelectUserType>(_selectUserType);
    on<UpdateFirstName>(_updateFirstName);
    on<UpdateLastName>(_updateLastName);
    on<UpdatePartnerCNIC>(_updatePatrnerCNIC);
    on<UpdatePartnerEmail>(_updatePatrnerEmail);
    on<UpdateKinName>(_updateKinName);
    on<UpdateKinCNIC>(_updateKinCNIC);
    on<UpdateEmergencyNumber>(_updateKinEmail);
    on<UpdateKinMobileNumber>(_updateKinPhone);
    on<UpdateAdress>(_updateAress);
    on<PermenantAdressUpdate>(_updatePermenantAdress);
    on<UpdateEquityHolder>(_updateEquityHolder);
    on<UpdateShareHolder>(_updateShareHolder);
    on<UpdateRequestDuration>(_updateRequesDuration);
    on<UpdatebankName>(_updatebankName);
    on<BankCode>(_bankCode);
    on<BankIBAN>(_bankIBAN);
    on<BankAccountNumber>(_bankAccountNumber);
    on<UserName>(_userName);
    on<Password>(_userPassword);
    on<ResetFormEvent>((event, emit) {
      emit(state.copyWith(
        userName: '',
        userPassword: '',
        firstName: '',
        lastName: '',
        adress: '',
        permenantAdress: '',
        partnerCNIC: '',
        kinName: '',
        kinCNIC: '',
        kinPhone: '',
        emergencyNumber: '',
        requestDuration: null,
        equityHolder: '',
        bankName: '',
        bankIBAN: '',
        bankCode: '',
        bankAccountNumber: '',
        selectedPartnerType: null,
      ));
    });
  }
  final db = DBHelper();
  //--------------TextFeild Comes Here

  //-----------2nd Step Text feilds
  void _updateFirstName(UpdateFirstName event, Emitter<PartnerState> emit) {
    emit(state.copyWith(firstName: event.firstname));
  }

  void _updateLastName(UpdateLastName event, Emitter<PartnerState> emit) {
    emit(state.copyWith(lastName: event.lastname));
  }

  void _updatePatrnerCNIC(UpdatePartnerCNIC event, Emitter<PartnerState> emit) {
    emit(state.copyWith(partnerCNIC: event.partnerCNIC));
  }

  void _updatePatrnerEmail(
      UpdatePartnerEmail event, Emitter<PartnerState> emit) {
    emit(state.copyWith(patnerEmail: event.partnerEmail));
  }

//---------------------------------3rd step text feilds
  void _updateKinName(UpdateKinName event, Emitter<PartnerState> emit) {
    emit(state.copyWith(kinName: event.kinName));
  }

  void _updateKinCNIC(UpdateKinCNIC event, Emitter<PartnerState> emit) {
    emit(state.copyWith(kinCNIC: event.kinCNIC));
  }

  void _updateKinEmail(
      UpdateEmergencyNumber event, Emitter<PartnerState> emit) {
    emit(state.copyWith(emergencyNumber: event.emergencyNumber));
  }

  void _updateKinPhone(
      UpdateKinMobileNumber event, Emitter<PartnerState> emit) {
    emit(state.copyWith(kinPhone: event.kinMobileNumber));
  }

//---------------------------------------------

//----------------4th step textFeilds

  void _updateAress(UpdateAdress event, Emitter<PartnerState> emit) {
    emit(state.copyWith(adress: event.address));
  }

  void _updatePermenantAdress(
      PermenantAdressUpdate event, Emitter<PartnerState> emit) {
    emit(state.copyWith(permenantAdress: event.permenatAdress));
  }

  void _updateEquityHolder(
      UpdateEquityHolder event, Emitter<PartnerState> emit) {
    emit(state.copyWith(equityHolder: event.equityHolder));
  }

  void _updateShareHolder(UpdateShareHolder event, Emitter<PartnerState> emit) {
    emit(state.copyWith(shareHolder: event.shareHolder));
  }

  void _updateRequesDuration(
      UpdateRequestDuration event, Emitter<PartnerState> emit) {
    emit(state.copyWith(requestDuration: event.selectedValue));
  }

//--------------------------------------

//5th text feild------------------------------
  void _updatebankName(UpdatebankName event, Emitter<PartnerState> emit) {
    emit(state.copyWith(bankName: event.bankName));
  }

  void _bankCode(BankCode event, Emitter<PartnerState> emit) {
    emit(state.copyWith(bankCode: event.bankCode));
  }

  void _bankIBAN(BankIBAN event, Emitter<PartnerState> emit) {
    emit(state.copyWith(bankIBAN: event.bankIBAN));
  }

  void _bankAccountNumber(BankAccountNumber event, Emitter<PartnerState> emit) {
    emit(state.copyWith(bankAccountNumber: event.bankAccountNumber));
  }

//----------------------------------------

//6th textfields-----------------------------

  void _userName(UserName event, Emitter<PartnerState> emit) {
    emit(state.copyWith(userName: event.username));
  }

  void _userPassword(Password event, Emitter<PartnerState> emit) {
    emit(state.copyWith(userPassword: event.password));
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

//-------------------------

  Future<void> _initizaPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    token = await _getToken();
    appId = await db.getAppId();
    firmId = prefs.getString('firm_id');
    print('Loaded token: $token');
    print('Loaded appId: $appId');
    print('Loaded firmId: $firmId');
  }

  void _fetchPartnerTypes(
      FetchPartnerTypes event, Emitter<PartnerState> emit) async {
    emit(state.copyWith(isLoading: true));
    // ...
    try {
      final response = await http.post(
        Uri.parse(Constant.getPartnerTypeList),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'authorization_token': token,
          'app_id': appId.toString(),
          'iFirmID': firmId,
        }),
      );

      // ...

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData is List) {
          List<Map<String, String>> partnerTypes = (jsonData as List)
              .map((item) => {
                    'id': item['iPartnerTypeID'].toString(),
                    'name': item['sPartnerTypeName'].toString(),
                  })
              .toList();

          emit(state.copyWith(
            pertnerTypes: partnerTypes,
            isLoading: false,
          ));
        } else {
          print('Unexpected response format: $jsonData');
          emit(state.copyWith(isLoading: false));
        }
      } else {
        print('Error response status: ${response.statusCode}');
        emit(state.copyWith(isLoading: false));
      }
    } catch (error) {
      print('Error fetching partner types: $error');
      emit(state.copyWith(isLoading: false));
    }
  }

  void _selectPartnerType(SelectPartnerType event, Emitter<PartnerState> emit) {
    emit(state.copyWith(selectedPartnerType: event.selectedValue));
  }

  //--------------------For Group
  void _fetchGroups(FetchGroups event, Emitter<PartnerState> emit) async {
    emit(state.copyWith(isLoading: true));
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final appId = await db.getAppId();
    final firmId = prefs.getString('firm_id');

    if (token == null || appId == null || firmId == null) {
      print('Token, App-ID, or Firm-ID is null');
      print('Token: $token');
      print('App-ID: $appId');
      print('Firm-ID: $firmId');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(Constant.getGroup),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'authorization_token': token,
          'app_id': appId,
          'iFirmID': firmId,
        }),
      );

      print('Response data: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData is List) {
          List<Map<String, String>> groupType = (jsonData as List)
              .map((item) => {
                    'id': item['id'].toString(),
                    'name': item['name'].toString(),
                  })
              .toList();

          print('Parsed group types: $groupType');

          // Update state with group types
          emit(state.copyWith(
            groupType: groupType,
            isLoading: false,
          ));
        } else {
          print('Unexpected response format: $jsonData');
          emit(state.copyWith(isLoading: false));
        }
      } else {
        print('Error response status: ${response.statusCode}');
        emit(state.copyWith(isLoading: false));
      }
    } catch (error) {
      print('Error fetching Group types: $error');
      emit(state.copyWith(isLoading: false));
    }
  }

  void _selectGroup(SelectGroup event, Emitter<PartnerState> emit) {
    emit(state.copyWith(selectGroupType: event.selectedValue));
  }

//-------------------------------------------

//-----------------For User

  void _fetchUser(FetchUser event, Emitter<PartnerState> emit) async {
    emit(state.copyWith(isLoading: true));
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final appId = await db.getAppId();

    final firmId = prefs.getString('firm_id');

    if (token == null || appId == null || firmId == null) {
      print('Token, App-ID, or Firm-ID is null');
      print('Token: $token');
      print('App-ID: $appId');
      print('Firm-ID: $firmId');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(Constant.getUserType),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'authorization_token': token,
          'app_id': appId,
          'iFirmID': firmId,
        }),
      );

      print('Response data: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData is List) {
          List<Map<String, String>> userType = (jsonData as List)
              .map((item) => {
                    'id': item['iUserTypeID'].toString(),
                    'name': item['sUserType'].toString(),
                  })
              .toList();

          print('Parsed user types: $userType');

          // Update state with user types
          emit(state.copyWith(
            userType: userType,
            isLoading: false,
          ));
        } else {
          print('Unexpected response format: $jsonData');
          emit(state.copyWith(isLoading: false));
        }
      } else {
        print('Error response status: ${response.statusCode}');
        emit(state.copyWith(isLoading: false));
      }
    } catch (error) {
      print('Error fetching User types: $error');
      emit(state.copyWith(isLoading: false));
    }
  }

  void _selectUserType(SelectUserType event, Emitter<PartnerState> emit) {
    emit(state.copyWith(selectUserType: event.selectedUserId));
  }
//-------------------------------
}
