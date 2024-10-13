import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/Add_Partner_1.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/Add_partner_5.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/bloc.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/event.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/state.dart';
import 'package:okra_distributer/FirmPartner/controllers/controllers.dart';

class AddPartner4 extends StatefulWidget {
  const AddPartner4({super.key});

  @override
  State<AddPartner4> createState() => _AddPartner4State();
}

class _AddPartner4State extends State<AddPartner4> {
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
                      border: Border.all(width: 2, color: Colors.blue),
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
                      border: Border.all(width: 2, color: Colors.grey),
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
                "STEP 4",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                "Address & Share Information",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            DividerWithText(text: 'Please fill the fields'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            Center(
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
                                .add(UpdateAdress(value));
                          },
                          controller: _controllers.addressController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Adress ',
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
                                .add(PermenantAdressUpdate(value));
                          },
                          controller: _controllers.permenantAddressController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Permenant Adress',
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
                                .add(UpdateEquityHolder(value));
                          },
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Equity Holder',
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
                                .add(UpdateShareHolder(value));
                          },
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Share Holder',
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: BlocBuilder<PartnerBloc, PartnerState>(
                          builder: (context, state) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 9),
                              child: DropdownButton<int>(
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                value: state.requestDuration,
                                hint: Text('Withdrawal Request Duration'),
                                items: List.generate(12, (index) => index + 1)
                                    .map((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(
                                        '$value Month${value > 1 ? 's' : ''}'),
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  if (newValue != null) {
                                    // Dispatch the event to update BLoC state
                                    context
                                        .read<PartnerBloc>()
                                        .add(UpdateRequestDuration(newValue));
                                  }
                                },
                              ),
                            );
                          },
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
                                        builder: (context) => AddPartner4()));
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
                              onPressed: () {
                                if (state.adress == '' ||
                                    state.permenantAdress == '' ||
                                    state.equityHolder == '' ||
                                    state.shareHolder == '' ||
                                    state.requestDuration == null) {
                                  SnackBar snackBar = SnackBar(
                                    content: Text(
                                      'Please fill all the fields',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddPartner5()));
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                  Icon(Icons.arrow_forward,
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
                                  )),
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
                                MediaQuery.of(context).size.width * 0.50,
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
