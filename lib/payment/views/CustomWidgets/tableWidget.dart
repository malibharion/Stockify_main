import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final List<Map<String, dynamic>> rows;

  const DataTableWidget({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Store Name')),
          DataColumn(label: Text('Company Name')),
          DataColumn(label: Text('Product Name')),
          DataColumn(label: Text('Purchase Quantity')),
          DataColumn(label: Text('Purchase Value')),
          DataColumn(label: Text('Purchase Return Quantity')),
          DataColumn(label: Text('Purchase Return Value')),
          DataColumn(label: Text('Total Sale Quantity')),
          DataColumn(label: Text(' Total Sale Value')),
          DataColumn(label: Text('Sale Reutrn Quantity')),
          DataColumn(label: Text('Sale Return Value')),
        ],
        rows: rows.map((row) {
          return DataRow(
            cells: [
              DataCell(Text(row['store_name'] ?? '')),
              DataCell(Text(row['sCompanyName'] ?? '')),
              DataCell(Text(row['sProductName'] ?? '')),
              DataCell(Text(row['pur_total_qty'] ?? '')),
              DataCell(Text(row['pur_value'] ?? '')),
              DataCell(Text(row['purchase_return_qty'] ?? '')),
              DataCell(Text(row['pur_return_value'] ?? '')),
              DataCell(Text(row['sale_total_qty'] ?? '')),
              DataCell(Text(row['sale_value'] ?? '')),
              DataCell(Text(row['sale_return_total_qty'] ?? '')),
              DataCell(Text(row['sale_return_value'] ?? '')),
            ],
          );
        }).toList(),
      ),
    );
  }
}
