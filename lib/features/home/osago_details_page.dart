import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/save_and_open_pdf.dart';

import '../../common/components/qr_code_widget.dart';
import '../../common/localization/language_constants.dart';
import '../osago/domain/entities/osago.dart';
import '../osago/presentation/components/info_tile.dart';

class OsagoDetailsPage extends StatefulWidget {
  final Osago osago;

  OsagoDetailsPage({super.key, required this.osago});

  @override
  State<OsagoDetailsPage> createState() => _OsagoDetailsPageState();
}

class _OsagoDetailsPageState extends State<OsagoDetailsPage> {
  String _dateTimeParser(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat("dd.MM.yyyy").format(dateTime);
  }

  final PdfInvoiceService service = PdfInvoiceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Osago detail page'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoTile(
                            title: 'Полистин Ээси',
                            content: widget.osago.polisOwnerName),
                        InfoTile(
                          title: 'Унаанын номери',
                          content: widget.osago.carPlate,
                        ),
                        InfoTile(
                          title: 'Башталыш жана Бутту',
                          content:
                              '${_dateTimeParser(widget.osago.startDate.toString())} - ${_dateTimeParser(widget.osago.endDate.toString())}',
                        ),
                        InfoTile(
                          title: 'Баасы',
                          content: '${widget.osago.costOfOsago}сом',
                        ),
                        InfoTile(
                          title: 'Статусу',
                          content: widget.osago.status ? 'Active' : 'Inactive',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    child: QrCodeWidget(url: 'https://example.com'),
                  ),
                  const SizedBox(height: 30),
                  MyButton(
                    text: 'Создать PDF',
                    onPress: () async {
                      final data =
                          await service.createOsagoDetailPdf(widget.osago);
                      service.savePdfFile('pdf_file', data);
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
