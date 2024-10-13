import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:okra_distributer/payment/views/CustomWidgets/ledgerBtn.dart';
import 'package:okra_distributer/payment/views/CustomWidgets/tableWidget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

import 'package:okra_distributer/payment/views/CustomWidgets/ledgerFunction.dart';

class CustomerrLedger extends StatefulWidget {
  final List<Map<String, String>> data;

  const CustomerrLedger({super.key, required this.data});

  @override
  State<CustomerrLedger> createState() => _CustomerrLedgerState();
}

class _CustomerrLedgerState extends State<CustomerrLedger> {
  List<Map<String, String>> _rows = [];

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _rows = widget.data;
    }
  }

  void downloadPdf(BuildContext context) async {
    List<Map<String, String>> data = _rows;
    final ledgerFunction = LedgerFunction();

    try {
      final directory = await FilePicker.platform.getDirectoryPath();
      if (directory != null) {
        final filePath = '$directory/customer_ledger.pdf';
        await ledgerFunction.generateAndSavePdf(data, filePath);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('PDF saved at: $filePath'),
            duration: Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () async {
                final file = File(filePath);
                await OpenFile.open(file.path);
              },
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to select directory'),
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate PDF: $e'),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  Future<void> printPdf() async {
    final data = _rows;
    print(data);
    final ledgerFunction = LedgerFunction();
    final pdfData = await ledgerFunction.generatePdfFromDataTAble(data);

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async {
        return pdfData;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Customer Ledger",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomerledgerBtn(onTap: printPdf, text: "Print"),
                CustomerledgerBtn(
                    onTap: () => downloadPdf(context), text: "Pdf"),
                CustomerledgerBtn(onTap: () {}, text: "Excel "),
              ],
            ),
            DataTableWidget(rows: _rows),
          ],
        ),
      ),
    );
  }
}
