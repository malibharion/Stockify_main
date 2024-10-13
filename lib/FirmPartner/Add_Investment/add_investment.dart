import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:okra_distributer/FirmPartner/Add_Investment/Add_investment_bloc/add_investment_bloc.dart';
import 'package:okra_distributer/FirmPartner/Add_Investment/Add_investment_bloc/add_investment_event.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/Add_Partner_1.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../payment/views/Constant.dart';
import 'Add_investment_bloc/add_investment_state.dart';

class AddInvestment extends StatefulWidget {
  const AddInvestment({super.key});

  @override
  State<AddInvestment> createState() => _AddInvestmentState();
}

class _AddInvestmentState extends State<AddInvestment> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController AddInvestmentalController =
      TextEditingController();
  Future<void> _submitData() async {
    final patnerFirmId =
        context.read<AddInvestmentBloc>().state.selectPatnerFirm;
    final AddInvestmentalAmount = AddInvestmentalController.text;
    final bankFromId = context.read<AddInvestmentBloc>().state.selectBankForm;
    final bankToId = context.read<AddInvestmentBloc>().state.bankTo;
    final date = dateController.text;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final appId = prefs.getString('app_id');
    final firmId = prefs.getString('firm_id');

    final data = {
      'authorization_token': token,
      'app_id': appId,
      'iFirmID': firmId,
      'iFirmPartnerID': patnerFirmId,
      'dcAddInvestmentalAmount': AddInvestmentalAmount,
      'iCommonBankID': bankFromId,
      'iBankID': bankToId,
      'date': date,
    };

    final url = Constant.getpatnerBanksList;
    final response =
        await http.post(Uri.parse(url), body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      context.read<AddInvestmentBloc>().add(ResetAllStates());
      AddInvestmentalController.clear();
      dateController.clear();
      // context.read<AddInvestmentBloc>().add(SelectPatnerFirm(null));
      // context.read<AddInvestmentBloc>().add(SelectbankFrom(null));
      // context.read<AddInvestmentBloc>().add(SelectBankTo(null));
      print('Data sent successfully');
    } else {
      print('Error sending data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<AddInvestmentBloc>().add(FetchPatnerFirm());
    context.read<AddInvestmentBloc>().add(FetchBankFrom());
    context.read<AddInvestmentBloc>().add(FetchBankTo());
    context.read<AddInvestmentBloc>().add(SelectPatnerFirm(null));
    context.read<AddInvestmentBloc>().add(SelectbankFrom(null));
    context.read<AddInvestmentBloc>().add(SelectBankTo(null));
  }

  String? _selectedValue = "Select Frim Patner";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Investment',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<AddInvestmentBloc, AddInvestmentState>(
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Icon(Icons.account_balance, size: 100),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  DividerWithText(text: 'Please fill the fields'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: BlocBuilder<AddInvestmentBloc, AddInvestmentState>(
                        builder: (context, state) {
                          print('Patner Firm List: ${state.patnerFirmList}');
                          if (state.patnerFirmList == null ||
                              state.patnerFirmList!.isEmpty) {
                            return Text('No partner type available');
                          }

                          return DropdownButton<String>(
                            value: state.selectPatnerFirm,
                            hint: Text("Select Partner"),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                context
                                    .read<AddInvestmentBloc>()
                                    .add(SelectPatnerFirm(newValue));
                              }
                            },
                            items: state.patnerFirmList
                                ?.map<DropdownMenuItem<String>>((partner) {
                              print('Partner Item: $partner');
                              return DropdownMenuItem<String>(
                                value: partner['iFirmPartnerID'],
                                child: Text(partner['sName'] ?? ''),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextField(
                      controller: AddInvestmentalController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {},
                      maxLines: 1,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        labelText: 'Add Investment amount ',
                        labelStyle: TextStyle(fontSize: 12, color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: BlocBuilder<AddInvestmentBloc, AddInvestmentState>(
                        builder: (context, state) {
                          final currentSelectedBank = state.selectBankForm;

                          final selectedValueExists = state.filteredBankList
                              ?.any((bank) =>
                                  bank['iCommonBankID'] == currentSelectedBank);

                          final dropdownValue = selectedValueExists == true
                              ? currentSelectedBank
                              : null;

                          return DropdownButton<String>(
                            value: dropdownValue,
                            hint: Text("Select Bank"),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                context
                                    .read<AddInvestmentBloc>()
                                    .add(SelectbankFrom(newValue));
                              }
                            },
                            items: state.filteredBankList
                                ?.map<DropdownMenuItem<String>>((bank) {
                              return DropdownMenuItem<String>(
                                value: bank['iCommonBankID'].toString(),
                                child: Text(bank['sBankName'] ?? ''),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: BlocBuilder<AddInvestmentBloc, AddInvestmentState>(
                        builder: (context, state) {
                          print('State: $state');
                          print('Bank Firm List: ${state.bankToList}');

                          if (state.bankToList == null ||
                              state.bankToList!.isEmpty) {
                            return Text('No Bank Firm available');
                          }

                          return DropdownButton<String>(
                            value: state.bankTo,
                            hint: Text("Select Bank"),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                context
                                    .read<AddInvestmentBloc>()
                                    .add(SelectBankTo(newValue));
                              }
                            },
                            items: state.bankToList
                                ?.map<DropdownMenuItem<String>>((bankTo) {
                              print('Bank To $bankTo');
                              return DropdownMenuItem<String>(
                                value: bankTo['iBankID'],
                                child: Text(bankTo['sName'] ?? ''),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  BlocBuilder<AddInvestmentBloc, AddInvestmentState>(
                    builder: (context, state) {
                      // Update the text field when the selectedDate changes
                      if (state.selectedDate != null &&
                          state.selectedDate!.isNotEmpty) {
                        dateController.text = state.selectedDate!;
                      }

                      return Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          controller: dateController, // Attach the controller
                          onChanged: (value) {
                            context
                                .read<AddInvestmentBloc>()
                                .add(DateChanged(value));
                          },
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  // Dispatch the event to update the BLoC state
                                  context
                                      .read<AddInvestmentBloc>()
                                      .add(DateChanged(formattedDate));
                                }
                              },
                            ),
                            labelText: 'Add Date',
                            labelStyle:
                                TextStyle(fontSize: 12, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: _submitData,
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.90,
                          MediaQuery.of(context).size.height * 0.06,
                        )),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
