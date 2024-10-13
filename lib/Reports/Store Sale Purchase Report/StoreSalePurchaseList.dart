import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:okra_distributer/FirmPartner/Add_partner/Add_Partner_1.dart';
import 'package:okra_distributer/Reports/Store%20Sale%20Purchase%20Report/blocs/StoreSalePurchaseBloc/StoreSalePurchaseEvent.dart';
import 'package:okra_distributer/Reports/Store%20Sale%20Purchase%20Report/blocs/VisibilityBloc/visibilityBloc.dart';
import 'package:okra_distributer/Reports/Store%20Sale%20Purchase%20Report/blocs/VisibilityBloc/visibilityEvent.dart';
import 'package:okra_distributer/Reports/Store%20Sale%20Purchase%20Report/blocs/VisibilityBloc/visibilityState.dart';
import 'package:http/http.dart' as http;
import 'package:okra_distributer/Reports/Store%20Sale%20Purchase%20Report/constants.dart';
import 'package:okra_distributer/payment/views/paymnetLedger.dart';
import 'blocs/StoreSalePurchaseBloc/StoreSalePurchaseBloc.dart';
import 'blocs/StoreSalePurchaseBloc/StoreSalePurchaseState.dart';

class StoreSalePurchaseList extends StatefulWidget {
  const StoreSalePurchaseList({super.key});

  @override
  State<StoreSalePurchaseList> createState() => _StoreSalePurchaseListState();
}

class _StoreSalePurchaseListState extends State<StoreSalePurchaseList> {
  String? _getDropdownValue(
      String? selectedDateRange, String? customDateRange) {
    if (selectedDateRange == 'Custom' && customDateRange != null) {
      return customDateRange; // Show custom date range in dropdown
    }

    if (selectedDateRange == 'Last 7 Days' ||
        selectedDateRange == 'Last 30 Days' ||
        selectedDateRange == 'Last 6 Months') {
      return customDateRange; // Display the calculated date range
    }

    return null;
  }

  String _calculateDateRange(String rangeType) {
    DateTime now = DateTime.now();
    DateTime startDate;

    if (rangeType == 'Last 7 Days') {
      startDate = now.subtract(Duration(days: 7));
    } else if (rangeType == 'Last 30 Days') {
      startDate = now.subtract(Duration(days: 30));
    } else if (rangeType == 'Last 6 Months') {
      startDate = DateTime(now.year, now.month - 6, now.day);
    } else {
      return ''; // For any other option
    }

    return "${_formatDate(startDate)} - ${_formatDate(now)}"; // Format as dd/mm/yyyy - dd/mm/yyyy
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  //Date Function
  //Date Function
  Future<void> _selectCustomDate(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      String formattedDateRange =
          "${_formatDate(picked.start)} - ${_formatDate(picked.end)}";
      context.read<Storesalepurchasebloc>().add(
            SelectDateRange(
              selectedDateRange:
                  'Custom', // Update selectedDateRange to 'Custom'
              customDateRange: formattedDateRange,
            ),
          );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<Storesalepurchasebloc>().add(LoadCompanies());
      }
    });
    Future.microtask(() {
      if (mounted) {
        context.read<Storesalepurchasebloc>().add(LoadGroups());
      }
    });
    Future.microtask(() {
      if (mounted) {
        context.read<Storesalepurchasebloc>().add(LoadProducts());
      }
    });
    Future.microtask(() {
      if (mounted) {
        context.read<Storesalepurchasebloc>().add(LoadStores());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Store Sale Purchase List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Store Based Customer wise Product Sale Summary',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 25.sp,
                        fontFamily: 'Roboto'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            DividerWithText(text: 'Please fill the fields'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            //Select Company Dropdown
            BlocBuilder<Storesalepurchasebloc, StorePalePurchaseState>(
              builder: (context, state) {
                // Check if companies are loaded and available
                if (state.companies == null || state.companies!.isEmpty) {
                  return Center(child: Text('No companies available'));
                }

                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton<String>(
                      value: state.selectedCompaniesId?.isNotEmpty == true
                          ? state.selectedCompaniesId
                          : null, // Use null if no company is selected
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text('Select Company'),
                      items: state.companies!.map((company) {
                        return DropdownMenuItem<String>(
                          value: company.id,
                          child: Text(company.name ?? 'Unknown'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<Storesalepurchasebloc>()
                              .add(SelectCompany(companyId: value));
                        }
                      },
                    ),
                  ),
                );
              },
            ),

            //Select Group
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            BlocBuilder<Storesalepurchasebloc, StorePalePurchaseState>(
              builder: (context, state) {
                if (state.groups == null || state.groups!.isEmpty) {
                  return Center(child: Text('No companies available'));
                }

                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton<String>(
                      value: state.selectedGroupsId?.isNotEmpty == true
                          ? state.selectedGroupsId
                          : null,
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text('Sselect Group'),
                      items: state.groups!.map((groups) {
                        return DropdownMenuItem<String>(
                          value: groups.id,
                          child: Text(groups.name ?? 'Unknown'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<Storesalepurchasebloc>()
                              .add(SelectGroup(groupId: value));
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            //Select Procucts
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            BlocBuilder<Storesalepurchasebloc, StorePalePurchaseState>(
              builder: (context, state) {
                if (state.products == null || state.products!.isEmpty) {
                  return Center(child: Text('No Product available'));
                }

                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton<String>(
                      value: state.selectedProductId?.isNotEmpty == true
                          ? state.selectedProductId
                          : null,
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text('Select Product'),
                      items: state.products!.map((products) {
                        return DropdownMenuItem<String>(
                          value: products.id,
                          child: Text(products.name ?? 'Unknown'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          context
                              .read<Storesalepurchasebloc>()
                              .add(SelectProducts(productId: value));
                        }
                      },
                    ),
                  ),
                );
              },
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            BlocBuilder<Storesalepurchasebloc, StorePalePurchaseState>(
              builder: (context, state) {
                String? _getDropdownValue() {
                  if (state.selectedDateRange == 'Custom' &&
                      state.customDateRange != null) {
                    return state
                        .customDateRange; // Show custom date range in dropdown
                  }

                  if (state.selectedDateRange == 'Last 7 Days' ||
                      state.selectedDateRange == 'Last 30 Days' ||
                      state.selectedDateRange == 'Last 6 Months') {
                    return _calculateDateRange(state.selectedDateRange!);
                  }

                  return null;
                }

                List<DropdownMenuItem<String>> _getDateRangeItems() {
                  List<DropdownMenuItem<String>> items = [
                    DropdownMenuItem(
                        value: 'Last 7 Days', child: Text('Last 7 Days')),
                    DropdownMenuItem(
                        value: 'Last 30 Days', child: Text('Last 30 Days')),
                    DropdownMenuItem(
                        value: 'Last 6 Months', child: Text('Last 6 Months')),
                    DropdownMenuItem(
                        value: 'Custom', child: Text('Custom Date Range')),
                  ];

                  if (state.customDateRange != null) {
                    items.add(DropdownMenuItem(
                      value: state.customDateRange,
                      child: Text(state.customDateRange!),
                    ));
                  }

                  return items;
                }

                return Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text("Select Date Range"),
                      value:
                          _getDropdownValue(), // Use _getDropdownValue as the value
                      items: _getDateRangeItems(),
                      onChanged: (value) {
                        if (value == 'Custom') {
                          _selectCustomDate(context);
                        } else {
                          final dateRange = _calculateDateRange(value!);
                          context.read<Storesalepurchasebloc>().add(
                                SelectDateRange(
                                  selectedDateRange: value,
                                  customDateRange: dateRange,
                                ),
                              );
                        }
                      },
                    ),
                  ),
                );
              },
            ),
            //CheckBox
            BlocBuilder<VisibilityBloc, IsVisibleState>(
              builder: (context, state) {
                return CheckboxListTile(
                  title: Text('Show additional fields'),
                  value: state.isVisible,
                  onChanged: (value) {
                    context.read<VisibilityBloc>().add(isVisible());
                  },
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            BlocBuilder<VisibilityBloc, IsVisibleState>(
              builder: (context, state) {
                return Visibility(
                    visible: state.isVisible,
                    child: Column(children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: SizedBox(),
                            hint: Text('Select Firm'),
                            items: [],
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      BlocBuilder<Storesalepurchasebloc,
                          StorePalePurchaseState>(
                        builder: (context, state) {
                          if (state.products == null ||
                              state.products!.isEmpty) {
                            return Center(child: Text('No Product available'));
                          }

                          return Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: DropdownButton<String>(
                                value: state.selectedStoreId?.isNotEmpty == true
                                    ? state.selectedStoreId
                                    : null,
                                isExpanded: true,
                                underline: SizedBox(),
                                hint: Text('Select Store'),
                                items: state.stores!.map((store) {
                                  return DropdownMenuItem<String>(
                                    value: store.id,
                                    child: Text(store.name ?? 'Unknown'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    context
                                        .read<Storesalepurchasebloc>()
                                        .add(SelectStore(storeId: value));
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ]));
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            //Sending Button
            //Sending Button
//Sending Button
            //Sending Button
            //Sending Button
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: BlocBuilder<Storesalepurchasebloc, StorePalePurchaseState>(
                builder: (context, state) {
                  return TextButton(
                    onPressed: () {
                      Map<String, dynamic> requestBody = {
                        'company_id': state.selectedCompaniesId,
                        'company_name': state.selectedCompaniesId != null
                            ? state.companies!
                                .firstWhere((company) =>
                                    company.id == state.selectedCompaniesId)
                                .name
                            : '',
                        'group_id': state.selectedGroupsId,
                        'group_name': state.selectedGroupsId != null
                            ? state.groups!
                                .firstWhere((group) =>
                                    group.id == state.selectedGroupsId)
                                .name
                            : '',
                        'product_id': state.selectedProductId,
                        'product_name': state.selectedProductId != null
                            ? state.products!
                                .firstWhere((product) =>
                                    product.id == state.selectedProductId)
                                .name
                            : '',
                        'date_range': state.customDateRange ??
                            _calculateDateRange(state.selectedDateRange!),
                        'firm_id': '1',
                        'firm_name': 'ABC',
                        'store_id': state.selectedStoreId,
                        'store_name': state.selectedStoreId != null
                            ? state.stores!
                                .firstWhere((store) =>
                                    store.id == state.selectedStoreId)
                                .name
                            : '',
                      };

                      http
                          .post(
                              Uri.parse(ReportConstants
                                  .ProductWiseSalePurchasaeSummary),
                              body: requestBody)
                          .then((response) {
                        print('API Response: ${response.body}');
                        if (response.statusCode == 200) {
                          try {
                            final jsonData = jsonDecode(response.body);
                            if (jsonData != null) {
                              // Access the 'record_list' array from the JSON response
                              List<dynamic> recordList =
                                  jsonData['record_list'];
                              List<Map<String, String>> rows =
                                  recordList.map((element) {
                                Map<String, String> row = {};
                                element.forEach((key, value) {
                                  row[key] = value.toString();
                                });
                                return row;
                              }).toList();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomerrLedger(data: rows)),
                              );
                            } else {
                              print('jsonData is null');
                            }
                          } catch (e) {
                            print('Error parsing JSON: $e');
                          }
                        } else {
                          print('API Response Error: ${response.statusCode}');
                        }
                      }).catchError((error) {
                        print('API Error: $error');
                      });
                    },
                    child: Text(
                      'Get Report',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


//ReportConstants.ProductWiseSalePurchasaeSummary