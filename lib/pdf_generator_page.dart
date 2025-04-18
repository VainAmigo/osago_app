import 'dart:io';

import 'package:osago_bloc_app/save_and_open_pdf.dart';
import 'package:pdf/widgets.dart';

class SimplePdfApi {
  static Future<File> generateSimpleTextPdf(String text, String text2) async {
    final pdf = Document();

    pdf.addPage(
      Page(
        build: (_) => Center(
          child: Column(
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 48),
              ),
              Text(
                text2,
                style: const TextStyle(fontSize: 48),
              ),
            ],
          ),
        ),
      ),
    );
    return SaveAndOpenDocument.savePdf(name: 'Simpl_page.pdf', pdf: pdf);
  }
}
