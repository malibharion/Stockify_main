import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:okra_distributer/consts/const.dart';
import 'package:okra_distributer/payment/Db/dbhelper.dart';
import 'package:http/http.dart' as http;

import 'package:okra_distributer/view/sale_order/sale_order_list/bloc/sale_order_list_event.dart';
import 'package:okra_distributer/view/sale_order/sale_order_list/bloc/sale_order_list_state.dart';
import 'package:okra_distributer/view/sale_order/sale_order_list/model/sale_order_list_details_model.dart';
import 'package:okra_distributer/view/sale_order/sale_order_list/model/sale_order_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaleOrderListBloc extends Bloc<SaleOrderListEvent, SaleOrderListState> {
  SaleOrderListBloc() : super(SaleInitialState()) {
    on<SaleOrderListInitialEvent>(saleListInitialEvent);
    on<SaleOrderListLastMonthEvent>(saleListLastMonthEvent);
    on<SaleOrderListThisMonthEvent>(saleListThisMonthEvent);
    on<SaleOrderListThisWeekEvent>(saleListThisWeekEvent);
    on<SaleOrderListThisYearEvent>(saleListThisYearEvent);
    on<SaleOrderListThisQuarterEvent>(saleListThisQuarterEvent);
    on<SaleOrderListCustomDate>(saleListCustomDate);
    on<SaleOrderListDismissEvent>(saleListDismissEvent);
    on<SaleOrderListDetailsEvent>(saleListDetailsEvent);
    on<SaleOrderListSyncEvent>(saleOrderListSyncEvent);
  }

  FutureOr<void> saleListInitialEvent(
      SaleOrderListInitialEvent event, Emitter<SaleOrderListState> emit) async {
    DateTime current = DateTime.now();
    String currentDate = formatDate(current);
    DBHelper dbHelper = DBHelper();
    final db = await dbHelper.database;
    List<Map<String, dynamic>> saleRows = await db.rawQuery('''
    SELECT s.*, pc.sName as customerName
    FROM sale_order s
    LEFT JOIN permanent_customer pc ON s.iPermanentCustomerID = pc.iPermanentCustomerID
    WHERE s.dSaleOrderDate = ?
  ''', [currentDate]);

    // List to hold SaleListModel instances
    List<SaleOrderListModel> salesList = [];
    // Iterate over fetched rows and populate SaleListModel instances
    saleRows.forEach((row) {
      salesList.add(SaleOrderListModel(
        saleId: row['iSaleOrderID'],
        sSyncStatus: row['sSyncStatus'],
        invoice_price: row['dcTotalBill'],

        customer_Name: row['customerName'],
        total_discount: row['dcTotalDiscount'],
        sale_date: row['dSaleOrderDate'], // Add the sale date
      ));
    });

    emit(SuccessState(
        saleList: salesList, firstDate: currentDate, lastDate: currentDate));
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  FutureOr<void> saleListLastMonthEvent(SaleOrderListLastMonthEvent event,
      Emitter<SaleOrderListState> emit) async {
    // Calculate first and last dates of the last month
    DateTime firstDateOfLastMonth = getFirstDateOfLastMonth();
    DateTime lastDateOfLastMonth = getLastDateOfLastMonth();

    // Format dates to strings using the provided formatDate function
    String firstDateStr = formatDate(firstDateOfLastMonth);
    String lastDateStr = formatDate(lastDateOfLastMonth);

    DBHelper dbHelper = DBHelper();
    final db = await dbHelper.database;

    // Query to fetch sales between the first and last dates of last month
    List<Map<String, dynamic>> saleRows = await db.rawQuery('''
      SELECT s.*, pc.sName as customerName
      FROM sale_order s
      LEFT JOIN permanent_customer pc ON s.iPermanentCustomerID = pc.iPermanentCustomerID
      WHERE s.dSaleOrderDate BETWEEN ? AND ?
    ''', [firstDateStr, lastDateStr]);

    // List to hold SaleListModel instances
    List<SaleOrderListModel> salesList = [];
    // Iterate over fetched rows and populate SaleListModel instances
    saleRows.forEach((row) {
      salesList.add(SaleOrderListModel(
        saleId: row['iSaleOrderID'],
        sSyncStatus: row['sSyncStatus'],
        invoice_price: row['dcTotalBill'],

        customer_Name: row['customerName'],
        total_discount: row['dcTotalDiscount'],
        sale_date: row['dSaleOrderDate'], // Add the sale date
      ));
    });

    emit(SuccessState(
        saleList: salesList, firstDate: firstDateStr, lastDate: lastDateStr));
  }

  FutureOr<void> saleListThisMonthEvent(SaleOrderListThisMonthEvent event,
      Emitter<SaleOrderListState> emit) async {
    // Calculate first and last dates of the last month
    DateTime firstDateOfLastMonth = getFirstDateOfThisMonth();
    DateTime lastDateOfLastMonth = getLastDateOfThisMonth();

    // Format dates to strings using the provided formatDate function
    String firstDateStr = formatDate(firstDateOfLastMonth);
    String lastDateStr = formatDate(lastDateOfLastMonth);

    DBHelper dbHelper = DBHelper();
    final db = await dbHelper.database;

    // Query to fetch sales between the first and last dates of this month
    List<Map<String, dynamic>> saleRows = await db.rawQuery('''
      SELECT s.*, pc.sName as customerName
      FROM sale_order s
      LEFT JOIN permanent_customer pc ON s.iPermanentCustomerID = pc.iPermanentCustomerID
      WHERE s.dSaleOrderDate BETWEEN ? AND ?
    ''', [firstDateStr, lastDateStr]);

    // List to hold SaleListModel instances
    List<SaleOrderListModel> salesList = [];
    // Iterate over fetched rows and populate SaleListModel instances
    saleRows.forEach((row) {
      salesList.add(SaleOrderListModel(
        saleId: row['iSaleOrderID'],
        sSyncStatus: row['sSyncStatus'],
        invoice_price: row['dcTotalBill'],

        customer_Name: row['customerName'],
        total_discount: row['dcTotalDiscount'],
        sale_date: row['dSaleOrderDate'], // Add the sale date
      ));
    });

    emit(SuccessState(
        saleList: salesList, firstDate: firstDateStr, lastDate: lastDateStr));
  }

  FutureOr<void> saleListThisWeekEvent(SaleOrderListThisWeekEvent event,
      Emitter<SaleOrderListState> emit) async {
    DateTime firstDateOfLastMonth = getFirstDateOfThisWeek();
    DateTime lastDateOfLastMonth = getLastDateOfThisWeek();

    // Format dates to strings using the provided formatDate function
    String firstDateStr = formatDate(firstDateOfLastMonth);
    String lastDateStr = formatDate(lastDateOfLastMonth);

    DBHelper dbHelper = DBHelper();
    final db = await dbHelper.database;

    // Query to fetch sales between the first and last dates of this week
    List<Map<String, dynamic>> saleRows = await db.rawQuery('''
      SELECT s.*, pc.sName as customerName
      FROM sale_order s
      LEFT JOIN permanent_customer pc ON s.iPermanentCustomerID = pc.iPermanentCustomerID
      WHERE s.dSaleOrderDate BETWEEN ? AND ?
    ''', [firstDateStr, lastDateStr]);

    // List to hold SaleListModel instances
    List<SaleOrderListModel> salesList = [];
    // Iterate over fetched rows and populate SaleListModel instances
    saleRows.forEach((row) {
      salesList.add(SaleOrderListModel(
        saleId: row['iSaleOrderID'],
        sSyncStatus: row['sSyncStatus'],
        invoice_price: row['dcTotalBill'],

        customer_Name: row['customerName'],
        total_discount: row['dcTotalDiscount'],
        sale_date: row['dSaleOrderDate'], // Add the sale date
      ));
    });

    emit(SuccessState(
        saleList: salesList, firstDate: firstDateStr, lastDate: lastDateStr));
  }

  FutureOr<void> saleListThisYearEvent(SaleOrderListThisYearEvent event,
      Emitter<SaleOrderListState> emit) async {
    DateTime firstDateOfLastMonth = getFirstDateOfThisYear();
    DateTime lastDateOfLastMonth = getLastDateOfThisYear();

    // Format dates to strings using the provided formatDate function
    String firstDateStr = formatDate(firstDateOfLastMonth);
    String lastDateStr = formatDate(lastDateOfLastMonth);

    DBHelper dbHelper = DBHelper();
    final db = await dbHelper.database;

    // Query to fetch sales between the first and last dates of this week
    List<Map<String, dynamic>> saleRows = await db.rawQuery('''
      SELECT s.*, pc.sName as customerName
      FROM sale_order s
      LEFT JOIN permanent_customer pc ON s.iPermanentCustomerID = pc.iPermanentCustomerID
      WHERE s.dSaleOrderDate BETWEEN ? AND ?
    ''', [firstDateStr, lastDateStr]);

    // List to hold SaleListModel instances
    List<SaleOrderListModel> salesList = [];
    // Iterate over fetched rows and populate SaleListModel instances
    saleRows.forEach((row) {
      salesList.add(SaleOrderListModel(
        saleId: row['iSaleOrderID'],
        sSyncStatus: row['sSyncStatus'],
        invoice_price: row['dcTotalBill'],

        customer_Name: row['customerName'],
        total_discount: row['dcTotalDiscount'],
        sale_date: row['dSaleOrderDate'], // Add the sale date
      ));
    });

    emit(SuccessState(
        saleList: salesList, firstDate: firstDateStr, lastDate: lastDateStr));
  }

  FutureOr<void> saleListThisQuarterEvent(SaleOrderListThisQuarterEvent event,
      Emitter<SaleOrderListState> emit) async {
    DateTime firstDateOfLastMonth =
        getFirstDateOfLastSixMonthsIncludingCurrent();
    DateTime lastDateOfLastMonth = getLastDateOfLastSixMonthsIncludingCurrent();

    // Format dates to strings using the provided formatDate function
    String firstDateStr = formatDate(firstDateOfLastMonth);
    String lastDateStr = formatDate(lastDateOfLastMonth);

    DBHelper dbHelper = DBHelper();
    final db = await dbHelper.database;

    // Query to fetch sales between the first and last dates of this week
    List<Map<String, dynamic>> saleRows = await db.rawQuery('''
      SELECT s.*, pc.sName as customerName
      FROM sale_order s
      LEFT JOIN permanent_customer pc ON s.iPermanentCustomerID = pc.iPermanentCustomerID
      WHERE s.dSaleOrderDate BETWEEN ? AND ?
    ''', [firstDateStr, lastDateStr]);

    // List to hold SaleListModel instances
    List<SaleOrderListModel> salesList = [];
    // Iterate over fetched rows and populate SaleListModel instances
    saleRows.forEach((row) {
      salesList.add(SaleOrderListModel(
        saleId: row['iSaleOrderID'],
        sSyncStatus: row['sSyncStatus'],
        invoice_price: row['dcTotalBill'],
        customer_Name: row['customerName'],

        total_discount: row['dcTotalDiscount'],
        sale_date: row['dSaleOrderDate'], // Add the sale date
      ));
    });

    emit(SuccessState(
        saleList: salesList, firstDate: firstDateStr, lastDate: lastDateStr));
  }

  FutureOr<void> saleListCustomDate(
      SaleOrderListCustomDate event, Emitter<SaleOrderListState> emit) async {
    DBHelper dbHelper = DBHelper();
    final db = await dbHelper.database;
    // Query to fetch sales between the first and last dates of this week
    List<Map<String, dynamic>> saleRows = await db.rawQuery('''
      SELECT s.*, pc.sName as customerName
      FROM sale_order s
      LEFT JOIN permanent_customer pc ON s.iPermanentCustomerID = pc.iPermanentCustomerID
      WHERE s.dSaleOrderDate BETWEEN ? AND ?
    ''', [event.fastDay, event.lastDay]);

    // List to hold SaleListModel instances
    List<SaleOrderListModel> salesList = [];
    // Iterate over fetched rows and populate SaleListModel instances
    saleRows.forEach((row) {
      salesList.add(SaleOrderListModel(
        saleId: row['iSaleOrderID'],
        sSyncStatus: row['sSyncStatus'],
        invoice_price: row['dcTotalBill'],

        customer_Name: row['customerName'],
        total_discount: row['dcTotalDiscount'],
        sale_date: row['dSaleOrderDate'], // Add the sale date
      ));
    });

    emit(SuccessState(
        saleList: salesList,
        firstDate: event.fastDay,
        lastDate: event.lastDay));
  }

  FutureOr<void> saleListDismissEvent(
      SaleOrderListDismissEvent event, Emitter<SaleOrderListState> emit) async {
    DBHelper dbHelper = DBHelper();
    final db = await dbHelper.database;
    await db.delete(
      'sale_order',
      where: 'iSaleOrderID = ?',
      whereArgs: [event.SaleId],
    );

    // Query to fetch sales between the first and last dates of this week
    List<Map<String, dynamic>> saleRows = await db.rawQuery('''
      SELECT s.*, pc.sName as customerName
      FROM sale_order s
      LEFT JOIN permanent_customer pc ON s.iPermanentCustomerID = pc.iPermanentCustomerID
      WHERE s.dSaleOrderDate BETWEEN ? AND ?
    ''', [event.firstDate, event.lastDate]);

    // List to hold SaleListModel instances
    List<SaleOrderListModel> salesList = [];
    // Iterate over fetched rows and populate SaleListModel instances
    saleRows.forEach((row) {
      salesList.add(SaleOrderListModel(
        sSyncStatus: row['sSyncStatus'],
        saleId: row['iSaleOrderID'],
        invoice_price: row['dcTotalBill'],

        customer_Name: row['customerName'],
        total_discount: row['dcTotalDiscount'],
        sale_date: row['dSaleOrderDate'], // Add the sale date
      ));
    });
    emit(SuccessState(
        saleList: salesList,
        firstDate: event.firstDate,
        lastDate: event.lastDate));
  }

  FutureOr<void> saleListDetailsEvent(
      SaleOrderListDetailsEvent event, Emitter<SaleOrderListState> emit) async {
    DBHelper dbHelper = DBHelper();
    final db = await dbHelper.database;
    print("this : ${event.SaleId}");
    int i = 4;
    print(i);
    i++;

    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT 
          sale_order.*,
          permanent_customer.*
      FROM 
          sale_order
      LEFT JOIN 
          permanent_customer ON sale_order.iPermanentCustomerID = permanent_customer.iPermanentCustomerID
      WHERE 
          sale_order.iSaleOrderID = ?
      ''', [event.SaleId]);

    if (result.isNotEmpty) {
      final row = result.first;

      final SaleOrder sale = SaleOrder(
        iSaleOrderID: row['iSaleID'],
        iSystemUserID: row['iSystemUserID'],
        iFirmID: row['iFirmID'],
        dcOnProuctDiscount: row['dcOnProuctDiscount'],
        sTotal_Item: row['sTotal_Item'],
        sNoficationStatus: row['sNoficationStatus'],
        sReadStatus: row['sReadStatus'],
        dSaleOrderDate: row['dSaleOrderDate'],
        iStoreID: row['iStoreID'],
        iPermanentCustomerID: row['iPermanentCustomerID'],
        sAddress: row['sAddress'],
        dcTotalBill: row['dcTotalBill'],
        dcGrandTotal: row['dcGrandTotal'],
        dcExtraDiscount: row['dcExtraDiscount'],
        dcTotalDiscount: row['dcTotalDiscount'],
        sTotalBonus: row['sTotalBonus'],
        sSaleType: row['sSaleType'],
        sSaleDescription: row['sSaleDescription'],
        bStatus: row['bStatus'],
        sSyncStatus: row['sSyncStatus'],
        sEntrySource: row['sEntrySource'],
        sAction: row['sAction'],
        dtDueDate: row['dtDueDate'],
        dtCreatedDate: row['dtCreatedDate'],
        iAddedBy: row['iAddedBy'],
        dtUpdatedDate: row['dtUpdatedDate'],
        iUpdatedBy: row['iUpdatedBy'],
        dtDeletedDate: row['dtDeletedDate'],
        iDeletedBy: row['iDeletedBy'],
      );

      PermanentCustomer? customer;
      if (row['iPermanentCustomerID'] != null) {
        customer = PermanentCustomer(
          iPermanentCustomerID: row['iPermanentCustomerID'],
          iSystemUserID: row['iSystemUserID'],
          iAreaID: row['iAreaID'],
          iFirmID: row['iFirmID'],
          sName: row['sName'],
          sShopName: row['sShopName'],
          sEmail: row['sEmail'],
          sCode: row['sCode'],
          sAddress: row['permanent_customer.sAddress'],
          sPhone: row['sPhone'],
          sMobile: row['sMobile'],
          sDescription: row['sDescription'],
          dcDefaultAmount: row['dcDefaultAmount'],
          dcPreviousAmount: row['dcPreviousAmount'],
          dcTotalRemainingAmount: row['dcTotalRemainingAmount'],
          bStatus: row['permanent_customer.bStatus'],
          sSyncStatus: row['permanent_customer.sSyncStatus'],
          sEntrySource: row['permanent_customer.sEntrySource'],
          sAction: row['permanent_customer.sAction'],
          sType: row['sType'],
          dtCreatedDate: row['permanent_customer.dtCreatedDate'],
          iAddedBy: row['permanent_customer.iAddedBy'],
          dtUpdatedDate: row['permanent_customer.dtUpdatedDate'],
          iUpdatedBy: row['permanent_customer.iUpdatedBy'],
          dtDeletedDate: row['permanent_customer.dtDeletedDate'],
          iDeletedBy: row['permanent_customer.iDeletedBy'],
        );
      }
      final List<Map<String, dynamic>> sale_products = await db.query(
        'sale_order_products_list',
        where: 'iSaleOrderID = ?',
        whereArgs: [event.SaleId],
      );
      // for (var product in sale_products) {
      //   print(product);
      // }
      final List<Map<String, dynamic>> saleProducts = await db.query(
        'sale_order_products_list',
        where: 'iSaleOrderID = ?',
        whereArgs: [event.SaleId],
      );

      // Loop through the products and print the details
      for (var product in saleProducts) {
        print('Product ID: ${product['iProductID']}');
        print('Sale Order ID: ${product['iSaleOrderID']}');
      }

      Future<List<Map<String, dynamic>>> fetchAndProcessData(int saleID) async {
        // Execute the query
        final result = await db.rawQuery('''
    SELECT sp.*, p.*, pu.*
    FROM sale_order_products_list sp
    JOIN product p ON sp.iProductID = p.iProductID
    JOIN product_unit pu ON (sp.sSaleStatus = pu.iItemUnitID)
    WHERE sp.iSaleOrderID = ?
  ''', [saleID]);
        return result;
        // // Process the result
        // List<Map<String, dynamic>> rows = result.map((row) => row).toList();
        // return rows;
      }

      List<Map<String, dynamic>> products =
          await fetchAndProcessData(event.SaleId);

      // ======================== Remove Duplicate List ========================   //
      // Use a Map to filter out duplicates based on `iSaleOrderProductID`
      Map<int, Map<String, dynamic>> uniqueProductsMap = {};

      for (var product in products) {
        uniqueProductsMap[product['iSaleOrderProductID']] = product;
      }

      // Convert back to List
      List<Map<String, dynamic>> uniqueProducts =
          uniqueProductsMap.values.toList();

      emit(SaleListDetailsState(
          saleWithCustomer: SaleWithCustomer(sale: sale, customer: customer),
          products: uniqueProducts));
    }
  }

  Future<void> saleOrderListSyncEvent(
      SaleOrderListSyncEvent event, Emitter<SaleOrderListState> emit) async {
    emit(SaleLoadingState());
    final Uri url = Uri.parse(addSaleOrderUrl);
    final _box = GetStorage();
    final authorization_token = await _getToken();

    final headers = {'Content-Type': 'application/json'};

    DBHelper dbHelper = DBHelper();
    final db = await dbHelper.database;
    int? appId = await dbHelper.getAppId();

    Map<String, dynamic> data = {};

    for (int saleOrderID in event.iSaleOrderID) {
      // Query the sale_order table

      List<Map<String, dynamic>> saleOrderList = await db.query(
        'sale_order',
        where: 'iSaleOrderID = ?',
        whereArgs: [saleOrderID],
      );

      if (saleOrderList.isNotEmpty) {
        Map<String, dynamic> saleOrder = saleOrderList.first;

        // Query the sale_order_products_list table
        List<Map<String, dynamic>> saleOrderProductList = await db.query(
          'sale_order_products_list',
          where: 'iSaleOrderID = ?',
          whereArgs: [saleOrderID],
        );

        // Organize the sale_order and sale_order_product_list into the desired structure
        Map<String, dynamic> saleOrderData = {
          'sale_order': saleOrder,
          'sale_order_product_list': {
            for (int i = 0; i < saleOrderProductList.length; i++)
              'product_${i + 1}': saleOrderProductList[i]
          }
        };

        // Add the structured data to the main data map
        data['sale_order__${saleOrderID}'] = saleOrderData;
      }
    }

    // // Structure the final JSON request body
    // Map<String, dynamic> requestBody = {
    //   'authorization_token': authorizationToken,
    //   'data': data,
    // };

    final body = {
      "authorization_token": authorization_token,
      "app_id": "${appId}",
      "data": data,
    };
    print(body);

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('error')) {
          print('Faced error: ${jsonResponse['error']}');
          // emit(InitialAuthState());
        } else if (jsonResponse.containsKey('success')) {
          // String transaction_id = jsonResponse['transaction_id'];
          // print(transaction_id);
          print(jsonResponse);
          // Access the transactionIDs map
          Map<String, dynamic> transactionIDs = jsonResponse['transactionIDs'];

          // Create a list to store the transaction IDs
          List<String> transactionIDList = [];

          // Iterate over the map and add the values to the list
          transactionIDs.forEach((key, value) {
            transactionIDList.add(value);
          });

          // Print the list of transaction IDs
          print('Transaction IDs: $transactionIDList');
          print('Transaction IDs: ${event.iSaleOrderID.length}');
          print('list length: ${event.iSaleOrderID})');
          print('list length: ${event.iSaleOrderID.length})');

          for (int i = 0; i < event.iSaleOrderID.length; i++) {
            // Check that transactionIDList has enough items
            if (i >= transactionIDList.length) {
              print(
                  "Warning: transactionIDList has fewer elements than event.iSaleOrderID");
              break; // Exit loop if there are not enough transaction IDs
            }

            await db.update(
              'sale_order',
              {
                'sSyncStatus': 1,
                'transaction_id': transactionIDList[i],
              },
              where: 'iSaleOrderID = ?',
              whereArgs: [event.iSaleOrderID[i]],
            );
          }

          // Update sale_order_products_list with transaction_id
          for (int i = 0; i < event.iSaleOrderID.length; i++) {
            await db.update(
              'sale_order_products_list',
              {
                'transaction_id': transactionIDList[i],
              },
              where: 'iSaleOrderID = ?',
              whereArgs: [event.iSaleOrderID[i]],
            );
          }
          // Query to fetch sales between the first and last dates of this week
          List<Map<String, dynamic>> saleRows = await db.rawQuery('''
                    SELECT s.*, pc.sName as customerName
                    FROM sale_order s
                    LEFT JOIN permanent_customer pc ON s.iPermanentCustomerID = pc.iPermanentCustomerID
                    WHERE s.dSaleOrderDate BETWEEN ? AND ?
                  ''', [event.firstDate, event.lastDate]);

          // List to hold SaleListModel instances
          List<SaleOrderListModel> salesList = [];
          // Iterate over fetched rows and populate SaleListModel instances
          saleRows.forEach((row) {
            salesList.add(SaleOrderListModel(
              saleId: row['iSaleOrderID'],
              sSyncStatus: row['sSyncStatus'],
              invoice_price: row['dcTotalBill'],

              customer_Name: row['customerName'],
              total_discount: row['dcTotalDiscount'],
              sale_date: row['dSaleOrderDate'], // Add the sale date
            ));
          });

          emit(SuccessState(
              saleList: salesList,
              firstDate: event.firstDate,
              lastDate: event.lastDate));
        }
      } else {
        print("Error: ${response.statusCode}");
        print("Error body: ${response.body}");
      }
    } catch (e) {
      print('Request failed: $e');
    }
  }
}
