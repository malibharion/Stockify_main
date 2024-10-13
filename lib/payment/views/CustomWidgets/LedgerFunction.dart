import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class LedgerFunction {
  Future<void>? dummyFunction() {
    print("hello there");
  }

  Future<void> generateAndSavePdf(
      List<Map<String, String>> data, String filePath) async {
    try {
      final pdf = await generatePdfFromDataTAble(data);
      final file = File(filePath);
      await file.writeAsBytes(pdf);
      await OpenFile.open(file.path);
    } catch (e) {
      print('Failed to generate and save PDF: $e');
    }
  }

  Future<Uint8List> generatePdfFromDataTAble(
      List<Map<String, String>> data) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final ttf = pw.Font.ttf(fontData);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Firm Log'),
                    pw.Text('Aman Traders'),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(children: [
                            pw.Text('Phone Number',
                                style: pw.TextStyle(fontSize: 4)),
                            pw.Text('1234567890',
                                style: pw.TextStyle(fontSize: 4)),
                          ]),
                          pw.Row(children: [
                            pw.Text('Email', style: pw.TextStyle(fontSize: 4)),
                            pw.Text('malikmuhammad103@gmail.com',
                                style: pw.TextStyle(fontSize: 4)),
                          ]),
                          pw.Row(children: [
                            pw.Text('Address',
                                style: pw.TextStyle(fontSize: 4)),
                            pw.Text('Okrasoft Bullo Khel Road Mianwali',
                                style: pw.TextStyle(fontSize: 4)),
                          ])
                        ])
                  ]),

              pw.Container(
                height: 30,
                alignment: pw.Alignment.center,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Container(
                      width: 150,
                      child: pw.Divider(),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Text('Customer wise sale Summary'),
                    pw.SizedBox(width: 10),
                    pw.Container(
                      width: 150,
                      child: pw.Divider(),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // Table
              pw.Table(
                border: pw.TableBorder.all(),
                tableWidth: pw.TableWidth.max,
                columnWidths: {
                  0: pw.FixedColumnWidth(40.0),
                  1: pw.FixedColumnWidth(40.0),
                  2: pw.FixedColumnWidth(40.0),
                  3: pw.FixedColumnWidth(40.0),
                  4: pw.FixedColumnWidth(40.0),
                  5: pw.FixedColumnWidth(40.0),
                  6: pw.FixedColumnWidth(40.0),
                  7: pw.FixedColumnWidth(40.0),
                  8: pw.FixedColumnWidth(40.0),
                  9: pw.FixedColumnWidth(40.0),
                  14: pw.FixedColumnWidth(40.0),
                },
                children: [
                  pw.TableRow(
                    decoration:
                        pw.BoxDecoration(color: PdfColor.fromHex("#808080")),
                    children: [
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Store Name",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Company Name",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Product Name",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Purchase Quantity",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Purchase Value",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Purchase Return Quantity",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Purchase Return Value",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Total Sale Quantity",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Total Sale Value",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Sale Return Quantity",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Container(
                        height: 14,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          "Sale Return Value",
                          style: pw.TextStyle(
                            font: ttf,
                            fontSize: 4.sp,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...data.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, String> row = entry.value;

                    return pw.TableRow(
                      decoration: pw.BoxDecoration(
                        color: index % 2 == 0
                            ? PdfColor.fromHex("#E2E3E5")
                            : PdfColors.white,
                      ),
                      children: [
                        pw.Container(
                          height: 14, // Set the desired height
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["store_name"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                        pw.Container(
                          height: 14,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["sCompanyName"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                        pw.Container(
                          height: 14,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["sProductName"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                        pw.Container(
                          height: 14,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["pur_total_qty"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                        pw.Container(
                          height: 14,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["pur_value"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                        pw.Container(
                          height: 14,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["purchase_return_qty"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                        pw.Container(
                          height: 14,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["pur_return_value"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                        pw.Container(
                          height: 14,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["sale_total_qty"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                        pw.Container(
                          height: 14,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["sale_value"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                        pw.Container(
                          height: 14,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["sale_return_total_qty"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                        pw.Container(
                          height: 14,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            row["sale_return_value"] ?? 'N/A',
                            style: pw.TextStyle(font: ttf, fontSize: 4.sp),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
