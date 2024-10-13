import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;
import 'package:okra_distributer/FirmPartner/Add_partner/Add_Partner_1.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/Add_partner_5.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/bloc.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/event.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/state.dart';
import 'package:okra_distributer/FirmPartner/controllers/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../payment/views/Constant.dart';

class AddPartner6 extends StatefulWidget {
  const AddPartner6({super.key});

  @override
  State<AddPartner6> createState() => _AddPartner6State();
}

class _AddPartner6State extends State<AddPartner6> {
  late Controllers _controllers;

  @override
  void initState() {
    _controllers = Controllers();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllers.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Partner',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<PartnerBloc, PartnerState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 1  step-----------------------------------------------
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: AssetImage(
                              'assets/images/user_selection.png',
                            ),
                          ),
                        ),
                      ),
                      //2nd step
                      //------------------------------------------------
                      Expanded(
                          child: Divider(
                        color: Colors.green,
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: AssetImage(
                              'assets/images/personal_info.png',
                            ),
                          ),
                        ),
                      ),
                      //3rd step -------------------------------------------------
                      Expanded(
                          child: Divider(
                        color: Colors.green,
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: AssetImage(
                              'assets/images/kin.png',
                            ),
                          ),
                        ),
                      ),
                      //4th step ------------------------------------------------
                      Expanded(
                          child: Divider(
                        color: Colors.green,
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: AssetImage(
                              'assets/images/frim.png',
                            ),
                          ),
                        ),
                      ),
                      //5th step ------------------------------------------------

                      Expanded(
                          child: Divider(
                        color: Colors.green,
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.green),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: AssetImage(
                              'assets/images/adress.png',
                            ),
                          ),
                        ),
                      ),
                      //6th step ------------------------------------------------
                      Expanded(
                          child: Divider(
                        color: Colors.green,
                      )),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width * 0.10,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image(
                            image: AssetImage(
                              'assets/images/password.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "STEP 6",
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "Username & Password",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                DividerWithText(text: 'Please fill the fields'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          onChanged: (value) {
                            context.read<PartnerBloc>().add(UserName(value));
                          },
                          controller: _controllers.usernameController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Username ',
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
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          onChanged: (value) {
                            context.read<PartnerBloc>().add(Password(value));
                          },
                          controller: _controllers.passwordController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Password',
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
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPartner5()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_back, color: Colors.white),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                  Text(
                                    'Back',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.sp),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.40,
                                    MediaQuery.of(context).size.height * 0.06,
                                  )),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final token = prefs.getString('authToken');
                                final appId = prefs.getString('app_id');
                                final firmId = prefs.getString('firm_id');

                                if (_controllers
                                        .usernameController.text.isEmpty ||
                                    _controllers
                                        .passwordController.text.isEmpty) {
                                  final snackBar = SnackBar(
                                    content: Text("Please fill all the fields"),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  Map<String, dynamic> apiData = {
                                    'authorization_token': token,
                                    'app_id': appId,
                                    'iFirmID': firmId,
                                    "sEmail": state.patnerEmail,
                                    "iUserTypeID": state.selectUserType,
                                    "username": state.userName,
                                    "iPartnerTypeID": state.selectedPartnerType,
                                    "sFirstName": state.firstName,
                                    "sLastName": state.lastName,
                                    "sAddress": state.adress,
                                    "iGroupID": state.selectGroupType,
                                    "sPermanentAddress": state.permenantAdress,
                                    "sCNIC": state.partnerCNIC,
                                    "sKinName": state.kinName,
                                    "sKinCNIC": state.kinCNIC,
                                    "sKinContactNumber": state.kinPhone,
                                    "sEmergencyNumber": state.emergencyNumber,
                                    "password": state.userPassword,
                                    "sWithdrawalRequestDuraction":
                                        state.requestDuration.toString(),
                                    "dcEquityHolder": state.equityHolder,
                                    "sBankName": state.bankName,
                                    "sBankIBAN": state.bankIBAN,
                                    "dcEquityPercentage": state.shareHolder,
                                    "sBankCode": state.bankCode,
                                    "sBankAccountNumber":
                                        state.bankAccountNumber
                                  };

                                  try {
                                    final response = await http.post(
                                      Uri.parse(Constant.addPostPartner),
                                      headers: {
                                        'Content-Type': 'application/json',
                                      },
                                      body: jsonEncode(apiData),
                                    );

                                    if (response.statusCode == 200) {
                                      print(jsonDecode(
                                          response.body)['success_added']);
                                      final responseBody =
                                          jsonDecode(response.body);

                                      if (responseBody['success_added'] !=
                                          null) {
                                        print('add sucess');
                                        print(responseBody);
                                        final snackbar = SnackBar(
                                          content: Text(
                                              "Partner Added Successfully"),
                                        );
                                        context
                                            .read<PartnerBloc>()
                                            .add(ResetFormEvent());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddPartner1()),
                                        );
                                      }
                                    } else {
                                      final snackbar = SnackBar(
                                        content: Text(
                                            "Error: ${response.reasonPhrase}"),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackbar);
                                    }
                                  } catch (e) {
                                    final snackbar = SnackBar(
                                      content: Text("Exception: $e"),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                  Icon(Icons.check_rounded,
                                      color: Colors.white),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.40,
                                  MediaQuery.of(context).size.height * 0.06,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _controllers.clear();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Reset',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20.sp),
                              ),
                              //icon for reset
                              Icon(Icons.restore, color: Colors.black),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.70,
                                MediaQuery.of(context).size.height * 0.06,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
