import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

class GenerateReceipt extends StatefulWidget {
  const GenerateReceipt({super.key});

  @override
  State<GenerateReceipt> createState() => _GenerateReceiptState();
}

class _GenerateReceiptState extends State<GenerateReceipt> {
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController vehiclePenaltyController =
      TextEditingController();
  final TextEditingController violenceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Generate Receipt"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: TextFormField(
                controller: vehicleNumberController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  labelText: 'Vehicle Number',
                  labelStyle: const TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: TextFormField(
                controller: vehiclePenaltyController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  labelText: 'Vehicle Penalty',
                  labelStyle: const TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: TextFormField(
                controller: violenceController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          width: 2.5, color: Colors.blueAccent)),
                  labelText: 'Violence',
                  labelStyle: const TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                generatePdf();
              },
              child: Text('Generate PDF', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> generatePdf() async {
    try {
      final pdf = pw.Document();
      final defaultImage = await getImageProvider();

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
                children: [
                  pw.Text(
                    'Receipt',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Image(defaultImage, height: 100, width: 100),
                  pw.Text('Vehicle Number: ${vehicleNumberController.text}'),
                  pw.Text(
                      'Penalty Amount: Rs.${vehiclePenaltyController.text}'),
                  pw.Text('Violence : ${violenceController.text}'),
                ],
              ),
            );
          },
        ),
      );

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } catch (e) {
      print("Error:---------------$e");
    }
  }

  Future<pw.ImageProvider> getImageProvider() async {
    final defaultImagePath = 'assets/TowedLogo.png';

    final byteData = await rootBundle.load(defaultImagePath);
    final Uint8List bytes = byteData.buffer.asUint8List();
    return pw.MemoryImage(bytes);
  }
}
