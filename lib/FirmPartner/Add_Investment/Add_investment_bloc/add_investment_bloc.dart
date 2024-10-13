import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:okra_distributer/FirmPartner/Add_Investment/Add_investment_bloc/add_investment_state.dart';
import 'package:okra_distributer/payment/Db/dbhelper.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../payment/views/Constant.dart';

import 'add_investment_event.dart';

class AddInvestmentBloc extends Bloc<AddInvestmentEvent, AddInvestmentState> {
  String? token;
  String? appId;
  String? firmId;
  AddInvestmentBloc() : super(AddInvestmentState()) {
    on<FetchPatnerFirm>(_fetchPatnerFirm);
    on<FetchBankFrom>(_fetchBankFrom);
    // on<FetchBankTo>(_fetchbankto);
    on<SelectPatnerFirm>(_selectPatnerFirm);
    on<SelectbankFrom>(_selectBankFrom);
    on<Sendpayment>(_sendpayment);
    on<FetchBankTo>(_fetchBankTo);
    on<ShowDatePickerEvent>(_showDatePicker);

    on<SelectBankTo>(_selectbankto);
    on<DateChanged>(_dateChanged);
    on<ResetAllStates>(_resetAllStates);

    // on<SelectDate>(_selectdate);
  }

  void _resetAllStates(ResetAllStates event, Emitter<AddInvestmentState> emit) {
    AddInvestmentState newState = state.copywith(
      selectedDate: '',
      bankTo: null,
      selectPatnerFirm: null,
      selectBankForm: null,
      widhtdrawAmount: '',
    );
    emit(newState);
  }

  final db = DBHelper();

  void _sendpayment(Sendpayment event, Emitter<AddInvestmentState> emit) {}

  void _showDatePicker(
      ShowDatePickerEvent event, Emitter<AddInvestmentState> emit) {}

  void _dateChanged(DateChanged event, Emitter<AddInvestmentState> emit) {
    emit(state.copywith(selectedDate: event.date));
  }

  void _fetchPatnerFirm(
      FetchPatnerFirm event, Emitter<AddInvestmentState> emit) async {
    print('_fetchPatnerFirm function called');

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final appId = await db.getAppId();
    final firmId = prefs.getString('firm_id');

    print('Token: $token');
    print('App-ID: $appId');
    print('Firm-ID: $firmId');

    if (token == null || appId == null || firmId == null) {
      print('Token, App-ID, or Firm-ID is null');
      return;
    }

    final requestBody = jsonEncode({
      'authorization_token': token,
      'app_id': appId,
      'iFirmID': firmId,
    });

    try {
      final response = await http.post(
        Uri.parse(Constant.getPatnersList),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        final data = jsonDecode(response.body);

        if (data is List<dynamic>) {
          final convertedPartnerList = data
              .map((item) => item is Map<String, dynamic>
                  ? item
                  : {} as Map<String, dynamic>)
              .toList();
          emit(state.copywith(patnerFirmList: convertedPartnerList));
        } else if (data is Map<String, dynamic>) {
          final partnerList = [data];
          emit(state.copywith(patnerFirmList: partnerList));
        } else {
          print('Invalid response format');
        }
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        print('Error response: $errorData');
        if (errorData.containsKey('validation_error')) {
          print('Validation error: ${errorData['validation_error']}');
        }
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
//----------------------------

  void _fetchBankTo(FetchBankTo event, Emitter<AddInvestmentState> emit) async {
    print('_fetchBankTo function called');

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final appId = await db.getAppId();

    final firmId = prefs.getString('firm_id');

    print('Token: $token');
    print('App-ID: $appId');
    print('Firm-ID: $firmId');

    if (token == null || appId == null || firmId == null) {
      print('Token, App-ID, or Firm-ID is null');
      return;
    }

    final requestBody = jsonEncode({
      'authorization_token': token,
      'app_id': appId,
      'iFirmID': firmId,
    });

    try {
      final response = await http.post(
        Uri.parse(Constant.getFirmsBanksList),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        // print('Response body: ${response.body}');
        final data = jsonDecode(response.body);

        if (data is List<dynamic>) {
          final convertedBankToList = data
              .map((item) => item is Map<String, dynamic>
                  ? item
                  : {} as Map<String, dynamic>)
              .toList();
          print(' This is in Bloc $convertedBankToList');
          emit(state.copywith(bankToList: convertedBankToList));
          print("this is Bank to list ${state.bankToList}");
        } else if (data is Map<String, dynamic>) {
          final banktoList = [data];
          emit(state.copywith(bankToList: banktoList));
        } else {
          print('Invalid response format');
        }
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        print('Error response: $errorData');
        if (errorData.containsKey('validation_error')) {
          print('Validation error: ${errorData['validation_error']}');
        }
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

//--------------------------------

  void _fetchBankFrom(
      FetchBankFrom event, Emitter<AddInvestmentState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('authToken');
    final appId = await db.getAppId();
    firmId = prefs.getString('firm_id');

    final response = await http.post(
      Uri.parse(Constant.getpatnerBanksList),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'authorization_token': token,
        'app_id': appId,
        'iFirmID': firmId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is List<dynamic>) {
        final convertedBankList = data
            .map((item) => item is Map<String, dynamic>
                ? item
                : {} as Map<String, dynamic>)
            .toList();
        emit(state.copywith(bankFormList: convertedBankList));
      } else if (data is Map<String, dynamic>) {
        final bankList = [data];
        emit(state.copywith(bankFormList: bankList));
      } else {
        print('Invalid response format');
      }
    } else if (response.statusCode == 400) {
      final errorData = jsonDecode(response.body);
      if (errorData.containsKey('validation_error')) {
        print('Validation error: ${errorData['validation_error']}');
      } else {
        print('Error: ${response.body}');
      }
    } else {
      print('Failed to load data');
    }
  }

  void _selectPatnerFirm(
      SelectPatnerFirm event, Emitter<AddInvestmentState> emit) {
    emit(state.copywith(selectPatnerFirm: event.patnerFirmName));

    final filteredBanks = state.bankFormList?.where((bank) {
      return bank['iTableID'] == event.patnerFirmName;
    }).toList();

    emit(state.copywith(selectBankForm: null));

    emit(state.copywith(filteredBankList: filteredBanks));
  }

  void _selectBankFrom(SelectbankFrom event, Emitter<AddInvestmentState> emit) {
    emit(state.copywith(selectBankForm: event.bankID));
  }

  void _selectbankto(SelectBankTo event, Emitter<AddInvestmentState> emit) {
    emit(state.copywith(bankTo: event.bankTo));
  }
}
