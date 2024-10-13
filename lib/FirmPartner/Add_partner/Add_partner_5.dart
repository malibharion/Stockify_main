import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/Add_Partner_1.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/Add_Partner_4.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/bloc.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/event.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/state.dart';
import 'package:okra_distributer/FirmPartner/controllers/controllers.dart';

import 'Add_Partner_6.dart';

class AddPartner5 extends StatefulWidget {
  const AddPartner5({super.key});

  @override
  State<AddPartner5> createState() => _AddPartner5State();
}

class _AddPartner5State extends State<AddPartner5> {
  late Controllers _controllers;
  String? _selectedValue;
  final List<String> _items = ['Option 1', 'Option 2', 'Option 3'];
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
        child: Column(
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
                      border: Border.all(width: 2, color: Colors.blue),
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
                  Expanded(child: Divider()),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey),
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
                "STEP 5",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                "Bank Details",
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
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            DividerWithText(text: 'Please fill the fields'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: BlocBuilder<PartnerBloc, PartnerState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextField(
                          onChanged: (value) {
                            context
                                .read<PartnerBloc>()
                                .add(UpdatebankName(value));
                          },
                          controller: _controllers.bankName,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Bank Name',
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
                            context.read<PartnerBloc>().add(BankCode(value));
                          },
                          controller: _controllers.bankCode,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Bank code',
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
                            context.read<PartnerBloc>().add(BankIBAN(value));
                          },
                          controller: _controllers.bankIBAN,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Bank IBAN',
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
                            context
                                .read<PartnerBloc>()
                                .add(BankAccountNumber(value));
                          },
                          controller: _controllers.bankAccountNumber,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Bank account Number',
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
                        height: MediaQuery.of(context).size.height * 0.030,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddPartner4()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_back, color: Colors.white),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
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
                            onPressed: () {
                              if (state.bankName == '' ||
                                  state.bankCode == '' ||
                                  state.bankIBAN == '' ||
                                  state.bankAccountNumber == '') {
                                SnackBar snackBar = SnackBar(
                                  content: Text('Please fill all the fields'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPartner6()));
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
                                ),
                                Icon(Icons.arrow_forward, color: Colors.white),
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
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
