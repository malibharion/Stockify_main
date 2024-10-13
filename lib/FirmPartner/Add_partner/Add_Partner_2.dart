import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/Add_Partner_1.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/Add_Partner_3.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/bloc.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/event.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/state.dart';
import 'package:okra_distributer/FirmPartner/controllers/controllers.dart';

class AddPartner2 extends StatefulWidget {
  const AddPartner2({super.key});

  @override
  State<AddPartner2> createState() => _AddPartner2State();
}

class _AddPartner2State extends State<AddPartner2> {
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
                  padding: const EdgeInsets.symmetric(horizontal: 6),
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
                          border: Border.all(width: 2, color: Colors.blue),
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
                              'assets/images/kin.png',
                            ),
                          ),
                        ),
                      ),
                      //4th step ------------------------------------------------
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
                              'assets/images/frim.png',
                            ),
                          ),
                        ),
                      ),
                      //5th step ------------------------------------------------

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "STEP 2",
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "Personal Information ",
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
                            context
                                .read<PartnerBloc>()
                                .add(UpdateFirstName(value));
                          },
                          controller: _controllers.firstNameController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'First Name',
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
                                .add(UpdateLastName(value));
                          },
                          controller: _controllers.lastNameController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Last Name',
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
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            context
                                .read<PartnerBloc>()
                                .add(UpdatePartnerCNIC(value));
                          },
                          controller: _controllers.partnerCNICController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Partner  CNIC',
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
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            context
                                .read<PartnerBloc>()
                                .add(UpdatePartnerEmail(value));
                          },
                          controller: _controllers.ownerEmailController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Partner Email',
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
                                        builder: (context) => AddPartner1()));
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
                                if (state.firstName == null ||
                                    state.lastName == null ||
                                    state.partnerCNIC == null ||
                                    state.patnerEmail == null) {
                                  final snackBar = SnackBar(
                                    content: Text('Please fill all the fields'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddPartner3()));
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
                              Icon(Icons.delete, color: Colors.black),
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


//Personal and Partner Contact Details Form