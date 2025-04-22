import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/components/top_text_block.dart';
import 'package:osago_bloc_app/save_and_open_pdf.dart';

import '../../common/components/qr_code_widget.dart';
import '../../common/localization/language_constants.dart';
import '../osago/domain/entities/osago.dart';
import '../osago/presentation/components/info_tile.dart';
import 'components/qr_bottom_modal_sheet.dart';

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

  // bottom sheet open button pressed
  void _qrCodeButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) => QrCodeBottomModalSheet(
              polisId: widget.osago.id,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                topTextBlock(
                  title: translation(context).osagoDetailPageTopTitle,
                  text:
                  translation(context).osagoDetailPageTopText,
                ),
                const SizedBox(height: 24),
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
                          title: translation(context).osagoDetailPageIngoTileOwner,
                          content: widget.osago.polisOwnerName),
                      InfoTile(
                        title: translation(context).osagoDetailPageIngoTileCarPlate,
                        content: widget.osago.carPlate,
                      ),
                      InfoTile(
                        title: translation(context).osagoDetailPageIngoTileDates,
                        content:
                            '${_dateTimeParser(widget.osago.startDate.toString())} - ${_dateTimeParser(widget.osago.endDate.toString())}',
                      ),
                      InfoTile(
                        title: translation(context).osagoDetailPageIngoTileCost,
                        content: '${widget.osago.costOfOsago}сом',
                      ),
                      InfoTile(
                        title: translation(context).osagoDetailPageIngoTileStatus,
                        content: widget.osago.status ? translation(context).osagoDetailPageIngoTileStatusActive : translation(context).osagoDetailPageIngoTileStatusInactive,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyButton(
                          text: translation(context).buttonCreatePdf,
                          onPress: () async {
                            final data =
                                await service.createOsagoDetailPdf(widget.osago);
                            service.savePdfFile('pdf_file', data);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                          onPressed: () => _qrCodeButtonPressed(),
                          icon: Icon(Icons.qr_code),
                          color: Theme.of(context).primaryColor)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
