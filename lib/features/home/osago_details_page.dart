import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:osago_bloc_app/common/components/my_button.dart';
import 'package:osago_bloc_app/common/components/top_text_block.dart';
import 'package:osago_bloc_app/save_and_open_pdf.dart';

import '../../common/localization/language_constants.dart';
import '../osago/domain/entities/osago.dart';
import '../osago/presentation/components/info_tile.dart';
import 'components/qr_bottom_modal_sheet.dart';

class OsagoDetailsPage extends StatefulWidget {
  final Osago osago;

  const OsagoDetailsPage({super.key, required this.osago});

  @override
  State<OsagoDetailsPage> createState() => _OsagoDetailsPageState();
}

class _OsagoDetailsPageState extends State<OsagoDetailsPage> {
  String _dateTimeParser(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat("dd.MM.yyyy").format(dateTime);
  }

  @override
  void initState() {
    super.initState();
    _createAndUploadPdf();
  }

  final PdfInvoiceService service = PdfInvoiceService();
  Uint8List? _generatedPdfBytes;
  String? _downloadUrl;
  bool isPdfGenerated = false;

  // bottom sheet open button pressed
  void _qrCodeButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) => QrCodeBottomModalSheet(
        polisId: widget.osago.id,
        url: _downloadUrl!,
      ),
    );
  }

  Future<void> _createAndUploadPdf() async {
    try {
      final pdfBytes = await service.createOsagoDetailPdf(widget.osago);

      final downloadUrl = await service.uploadPdfToFirebase(
          pdfBytes, 'osago_${widget.osago.id}_${widget.osago.carPlate}');

      setState(() {
        _generatedPdfBytes = pdfBytes;
        _downloadUrl = downloadUrl;
        isPdfGenerated = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('error: $e'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  Future<void> _openPdf() async {
    await service.openPdfOnDevice(_generatedPdfBytes!, 'temp_osago');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: isPdfGenerated
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      topTextBlock(
                        title: translation(context).osagoDetailPageTopTitle,
                        text: translation(context).osagoDetailPageTopText,
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
                              title: translation(context)
                                  .osagoDetailPageIngoTileCarPlate,
                              content: widget.osago.carPlate,
                            ),
                            InfoTile(
                              title: translation(context)
                                  .osagoDetailPageIngoTileDates,
                              content:
                                  '${_dateTimeParser(widget.osago.startDate.toString())} - ${_dateTimeParser(widget.osago.endDate.toString())}',
                            ),
                            InfoTile(
                              title: translation(context)
                                  .osagoDetailPageIngoTileCost,
                              content: '${widget.osago.costOfOsago}сом',
                            ),
                            InfoTile(
                              title: translation(context)
                                  .osagoDetailPageIngoTileStatus,
                              content: widget.osago.status
                                  ? translation(context)
                                      .osagoDetailPageIngoTileStatusActive
                                  : translation(context)
                                      .osagoDetailPageIngoTileStatusInactive,
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
                                onPress: isPdfGenerated
                                    ? () {
                                        _openPdf();
                                      }
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                  width: 1,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () => _qrCodeButtonPressed(),
                                icon: Icon(Icons.qr_code),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}
