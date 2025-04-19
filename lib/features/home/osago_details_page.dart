import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/save_and_open_pdf.dart';

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
                          title: translation(context).personInfoTilePin,
                          content: widget.osago.userId),
                      InfoTile(
                        title: translation(context).personInfoTileDateOfBirth,
                        content: widget.osago.carPlate,
                      ),
                      InfoTile(
                        title: translation(context).personInfoTileTypeOfDoc,
                        content: widget.osago.osagoType,
                      ),
                      InfoTile(
                        title: translation(context).personInfoTileDateOfDoc,
                        content: _dateTimeParser(widget.osago.startDate.toString()),
                      ),
                      InfoTile(
                        title: translation(context).personInfoTileDateOfDoc,
                        content: _dateTimeParser(widget.osago.endDate.toString()),
                      ),
                      InfoTile(
                        title: translation(context).personInfoTileDateOfDoc,
                        content: '${widget.osago.costOfOsago}сом',
                      ),
                      InfoTile(
                        title: translation(context).personInfoTileDateOfDoc,
                        content: widget.osago.status ? 'Active' : 'Inactive',
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                MyButton(
                  text: 'Создать PDF',
                  onPress: () async {
                    final data = await service.createOsagoDetailPdf(widget.osago);
                    service.savePdfFile('pdf_file', data);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
