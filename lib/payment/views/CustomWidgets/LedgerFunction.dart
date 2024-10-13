import 'dart:io';
import 'dart:typed_data';
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
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(
                  'PreFex INC',
                  style: pw.TextStyle(
                      font: ttf,
                      fontSize: 22.sp,
                      fontWeight: pw.FontWeight.bold),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(
                  '172 lvy Club Gottllieburt',
                  style: pw.TextStyle(font: ttf, fontSize: 12.sp),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(
                  'Switzerland',
                  style: pw.TextStyle(font: ttf, fontSize: 12.sp),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(
                  'CH - 12345',
                  style: pw.TextStyle(font: ttf, fontSize: 12.sp),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text(
                  'To',
                  style: pw.TextStyle(
                      font: ttf,
                      fontSize: 22.sp,
                      fontWeight: pw.FontWeight.bold),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text(
                  'Weimann Daniel and Kuzarev Artem',
                  style: pw.TextStyle(font: ttf, fontSize: 12.sp),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text(
                  '1937 Emiie Center ',
                  style: pw.TextStyle(font: ttf, fontSize: 12.sp),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.Text(
                  'lake Augustine Kantus, WI 54485',
                  style: pw.TextStyle(font: ttf, fontSize: 12.sp),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(
                  'Account Summary',
                  style: pw.TextStyle(
                      font: ttf,
                      fontSize: 22.sp,
                      fontWeight: pw.FontWeight.bold),
                ),
              ]),

              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(
                  'Date: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                  style: pw.TextStyle(font: ttf, fontSize: 12.sp),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text('---------------------------------------',
                    style: pw.TextStyle(font: ttf, fontSize: 12.sp)),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(
                  'Beging Balance:           0.00 Rs ',
                  style: pw.TextStyle(font: ttf, fontSize: 12.sp),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(
                  'Innovice Amout:           23344 Rs ',
                  style: pw.TextStyle(font: ttf, fontSize: 12.sp),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(
                  'Amout Paid:           83342948 Rs ',
                  style: pw.TextStyle(font: ttf, fontSize: 12.sp),
                ),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                pw.Text(
                  'Balance Due:           3423.00 Rs ',
                  style: pw.TextStyle(
                    font: ttf,
                    fontSize: 12.sp,
                  ),
                ),
              ]),

              pw.SizedBox(height: 20),

              // Table
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    decoration:
                        pw.BoxDecoration(color: PdfColor.fromHex("#E2E3E5")),
                    children: [
                      pw.Text("Sr No",
                          style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 17.sp)),
                      pw.Text("Date",
                          style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 17.sp)),
                      pw.Text("Customer",
                          style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 17.sp)),
                      pw.Text("Amount",
                          style: pw.TextStyle(
                              font: ttf,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 17.sp)),
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
                        pw.Text(row["Sr No"]!,
                            style: pw.TextStyle(font: ttf, fontSize: 10)),
                        pw.Text(row["Date"]!,
                            style: pw.TextStyle(font: ttf, fontSize: 10)),
                        pw.Text(row["Customer"]!,
                            style: pw.TextStyle(font: ttf, fontSize: 10)),
                        pw.Text(row["Amount"]!,
                            style: pw.TextStyle(font: ttf, fontSize: 10)),
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
