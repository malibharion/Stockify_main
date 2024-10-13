import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/Add_Partner_2.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/bloc.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/event.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/bloc/state.dart';
import 'package:okra_distributer/FirmPartner/controllers/controllers.dart';

class AddPartner1 extends StatefulWidget {
  const AddPartner1({super.key});

  @override
  State<AddPartner1> createState() => _AddPartner1State();
}

class _AddPartner1State extends State<AddPartner1> {
  late Controllers _controllers;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      context.read<PartnerBloc>().add(FetchGroups());
      context.read<PartnerBloc>().add(FetchPartnerTypes());
      context.read<PartnerBloc>().add(FetchUser());
    });
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
      body: BlocBuilder<PartnerBloc, PartnerState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
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
                          border: Border.all(width: 2, color: Colors.blue),
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
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "STEP 1 :",
                    style:
                        TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Partner Categories & Groups",
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
                  child: Column(
                    children: [
                      BlocBuilder<PartnerBloc, PartnerState>(
                        builder: (context, state) {
                          print('Dropdown state: ${state.pertnerTypes}');

                          return Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                underline: SizedBox.shrink(),
                                value: state.selectedPartnerType,
                                hint: Text('Select Partner Type'),
                                items: state.pertnerTypes?.map((partner) {
                                      return DropdownMenuItem<String>(
                                        value: partner['id'],
                                        child: Text(partner['name'] ??
                                            'No name'), // Added fallback
                                      );
                                    }).toList() ??
                                    [],
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    context
                                        .read<PartnerBloc>()
                                        .add(SelectPartnerType(newValue));
                                    print(newValue);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.030,
                      ),
                      BlocBuilder<PartnerBloc, PartnerState>(
                        builder: (context, state) {
                          // Check if groupType or selectGroupType is null
                          if (state.groupType == null ||
                              state.groupType!.isEmpty) {
                            return Text(
                                'No group types available'); // Handle the case where no data is available
                          }

                          return Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox.shrink(),
                              value: state.selectGroupType,
                              hint: Text('Select Group Type'),
                              items: state.groupType!.map((group) {
                                return DropdownMenuItem<String>(
                                  value: group['id'],
                                  child: Text(group['name'] ?? 'No name'),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  context
                                      .read<PartnerBloc>()
                                      .add(SelectGroup(newValue));
                                  print(newValue);
                                }
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.030,
                      ),
                      BlocBuilder<PartnerBloc, PartnerState>(
                        builder: (context, state) {
                          // Check if groupType or selectGroupType is null
                          if (state.userType == null ||
                              state.userType!.isEmpty) {
                            return Text('No User types available');
                          }

                          return Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox.shrink(),
                              value: state.selectUserType,
                              hint: Text('Select User Type'),
                              items: state.userType!.map((user) {
                                return DropdownMenuItem<String>(
                                  value: user['id'],
                                  child: Text(user['name'] ?? 'No name'),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  context
                                      .read<PartnerBloc>()
                                      .add(SelectUserType(newValue));
                                  print(newValue);
                                }
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.030,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (state.selectedPartnerType == null ||
                              state.selectGroupType == null ||
                              state.selectUserType == null) {
                            final snackBar = SnackBar(
                              content: Text(
                                'Please select all fields',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddPartner2()));
                          }
                        },
                        child: Text(
                          'Next',
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.sp),
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
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
