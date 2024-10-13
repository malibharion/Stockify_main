import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:okra_distributer/payment/Db/dbhelper.dart';
import 'package:okra_distributer/payment/Models/model.dart';
import 'package:okra_distributer/bloc/popUpbloc/popBloc.dart';
import 'package:okra_distributer/bloc/popUpbloc/popEvent.dart';
import 'package:okra_distributer/bloc/popUpbloc/popState.dart';
import 'package:okra_distributer/payment/views/Constant.dart';

import 'package:okra_distributer/payment/views/CustomWidgets/infoCont.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Customerreciptlist extends StatefulWidget {
  const Customerreciptlist({Key? key}) : super(key: key);

  @override
  _CustomerreciptlistState createState() => _CustomerreciptlistState();
}

class _CustomerreciptlistState extends State<Customerreciptlist> {
  final dateController = TextEditingController();
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  @override
  void initState() {
    super.initState();
    DateTime startDate = DateTime.now().subtract(Duration(days: 1));
    DateTime endDate = DateTime.now();
    context
        .read<Popbloc>()
        .add(FilterPaymentsByDate(startDate: startDate, endDate: endDate));
    // context.read<Popbloc>().add(LoadAllPayments());
  }

  Future<void> syncOfflineData() async {
    final db = DBHelper();

    try {
      // Fetching token and appId asynchronously
      final token = await _getToken();
      final appId = await db.getAppId();

      // Fetching payments from the database
      final payments = await db.getAllPaymentWithoutTransactionId();

      // Prepare requestData with awaited values
      Map<String, dynamic> requestData = {
        "authorization_token": token,
        "app_id": appId,
        "data": {
          "permanent_customer_payments": {
            for (var payment in payments)
              "iPermanentCustomerPaymentsID__${payment['iPermanentCustomerPaymentsID']}":
                  {
                "iPermanentCustomerID": payment['iPermanentCustomerID'],
                "iBankID": payment['iBankID'],
                "dcPaidAmount": payment['dcPaidAmount'],
                "sBank": payment['sBank'],
                "sInvoiceNo": payment['sInvoiceNo'],
                "sDescription": payment['sDescription'],
                "dDate": payment['dDate'],
              },
          }
        }
      };

      // Sending HTTP POST request
      final response = await http.post(
        Uri.parse(Constant.customerReciptSync),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      // Handle the response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Debug print to check responseData structure
        print("Response Data: $responseData");

        // Check if '0', 'data', and 'permanent_customer_payments' are not null
        if (responseData['0'] != null &&
            responseData['0']['data'] != null &&
            responseData['0']['data']['permanent_customer_payments'] != null) {
          final updatedData =
              responseData['0']['data']['permanent_customer_payments'];

          for (var entry in updatedData.entries) {
            final primaryKey = entry.key.split(
                '__')[1]; // Extract the primary key from the formatted key
            final transactionId = entry.value['transaction_id'];

            final payment = PermanentCustomerPayment(
              iPermanentCustomerPaymentsID: int.parse(primaryKey),
              transaction_id: transactionId,
            );

            await db.updatePaymentWithTransactionId(payment);
          }

          print("Data synced successfully and updated locally!");
        } else {
          print("Unexpected response structure: ${responseData['0']['data']}");
        }
      } else {
        print("Failed to sync data: ${response.body}");
      }
    } catch (e) {
      print("Error syncing data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Customer Receipt List',
          style: TextStyle(color: Colors.black, fontSize: 20.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                // syncOfflineData();
                DBHelper().printAllPermanentCustomerPayments();
              },
              icon: Icon(Icons.search))
        ],
      ),
      backgroundColor: Color.fromARGB(255, 240, 240, 243),
      body: BlocBuilder<Popbloc, Popstate>(
        builder: (context, state) {
          DateTime startDate =
              state.startDate ?? DateTime.now().subtract(Duration(days: 30));
          DateTime endDate = state.endDate ?? DateTime.now();
          List<PermanentCustomerPayment> paymentsToShow =
              state.filteredPayments ?? [];

          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.date_range),
                    TextButton(
                      onPressed: () {
                        _pickStartDate(context, startDate, endDate);
                      },
                      child: Text('${_formattedDate(startDate)}'),
                    ),
                    Icon(Icons.date_range),
                    TextButton(
                      onPressed: () {
                        _pickEndDate(context, startDate, endDate);
                      },
                      child: Text('${_formattedDate(endDate)}'),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: paymentsToShow.length,
                    separatorBuilder: (context, index) => SizedBox(
                        height: MediaQuery.of(context).size.height * .003),
                    itemBuilder: (context, index) {
                      PermanentCustomerPayment payment = paymentsToShow[index];
                      return infoCont(
                        name: payment.customerName ?? 'No table name',
                        price: payment.dcPaidAmount != null
                            ? payment.dcPaidAmount!.toInt()
                            : 0,
                        refNo: payment.sInvoiceNo ?? '',
                        date: payment.dDate,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _pickStartDate(
      BuildContext context, DateTime startDate, DateTime endDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != startDate) {
      context
          .read<Popbloc>()
          .add(FilterPaymentsByDate(startDate: picked, endDate: endDate));
    }
  }

  void _pickEndDate(
      BuildContext context, DateTime startDate, DateTime endDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != endDate) {
      context
          .read<Popbloc>()
          .add(FilterPaymentsByDate(startDate: startDate, endDate: picked));
    }
  }

  String _formattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now().subtract(Duration(days: 30)),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: initialDateRange.start,
        end: initialDateRange.end,
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (newDateRange != null) {
      context.read<Popbloc>().add(FilterPaymentsByDate(
          startDate: newDateRange.start, endDate: newDateRange.end));
    }
  }
}
