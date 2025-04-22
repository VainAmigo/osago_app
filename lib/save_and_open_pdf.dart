import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'features/osago/domain/entities/osago.dart';

class PdfInvoiceService {
  static final PdfInvoiceService _instance = PdfInvoiceService._internal();

  factory PdfInvoiceService() => _instance;

  PdfInvoiceService._internal();

  late pw.Font _regularFont;
  late pw.Font _boldFont;
  late Uint8List _backgroundImage;
  bool _isInitialized = false;

  Future<void> _loadAssets() async {
    if (_isInitialized) return;

    final fontRegular =
        await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final fontBold = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');
    _regularFont = pw.Font.ttf(fontRegular);
    _boldFont = pw.Font.ttf(fontBold);

    _backgroundImage =
        (await rootBundle.load("assets/images/pdf_background.png"))
            .buffer
            .asUint8List();

    _isInitialized = true;
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat("dd.MM.yyyy").format(date);
  }

  Future<Uint8List> createOsagoDetailPdf(Osago osago) async {
    await _loadAssets();
    final pdf = pw.Document();

    final startDate = _formatDate(osago.startDate.toString());
    final endDate = _formatDate(osago.endDate.toString());

    final pinAndName = '${osago.polisOwnerPin}   ${osago.polisOwnerName}';
    final nameOfOwner = '${osago.carOwnerName}';
    final carBrandAndModel = '${osago.carBrand} ${osago.carModel}';
    final carPlate = osago.carPlate;
    final carIdNumber = osago.carId;
    final carTsNumber = osago.id;

    final firstDriverName = osago.carOwnerName;
    final fistDriverDocNumber = 'ID ${osago.carId}';

    final textStyle10 = pw.TextStyle(font: _regularFont, fontSize: 10);
    final textStyle8 = pw.TextStyle(font: _regularFont, fontSize: 8);
    final textStyleBold10 = pw.TextStyle(font: _boldFont, fontSize: 10);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (context) {
          return pw.Stack(
            children: [
              pw.Positioned.fill(
                child: pw.Image(
                  pw.MemoryImage(_backgroundImage),
                  fit: pw.BoxFit.cover,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(
                    left: 55, top: 40, right: 20, bottom: 40),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Автотранспорт каражаттарынын ээлеринин жарандык-укуктук жоопкерчилигин милдеттүү камсыздандыруунун КАМСЫЗДАНДЫРУУ ПОЛИСИ / СТРАХОВОЙ ПОЛИС обязательного страхования гражданско-правовой ответственности владельцев автотранспортных средств',
                      textAlign: pw.TextAlign.center,
                      style: textStyleBold10,
                    ),
                    pw.SizedBox(height: 20),

                    _buildDateRow(startDate, endDate, textStyle10),
                    pw.SizedBox(height: 10),

                    _buildParagraph1(textStyle8),
                    pw.SizedBox(height: 10),

                    _tileRow('1.Камсыздандыруучу \n  Страхователь', textStyle10,
                        _textContainer(pinAndName, textStyleBold10)),
                    pw.SizedBox(height: 8),

                    _tileRow(
                        '  Автотранспорт каражатынын ээси \n  Собственник автотранспортного',
                        textStyle10,
                        _textContainer(nameOfOwner, textStyleBold10)),
                    pw.SizedBox(height: 8),

                    _tileRow(
                        '  Жарандыкты берген өлкө \n  Страна гражданства',
                        textStyle10,
                        pw.Text('Кыргызская Республика',
                            style: textStyleBold10)),
                    pw.SizedBox(height: 8),

                    _tileRow(
                        '2.Автотранспорт каражаты \n  Автотранспортное средство',
                        textStyle10,
                        pw.SizedBox()),
                    pw.SizedBox(height: 8),

                    _tileRow(
                        '  Автотранспорт каражатынын маркасы, модели \n  Марка, модель автотранспортного средства',
                        textStyle10,
                        pw.Text(carBrandAndModel, style: textStyleBold10)),
                    pw.SizedBox(height: 8),

                    _tileRow(
                        '  Автотранспорт каражатынын мамлекеттик каттоо белгиси \n  Государственный регистрационный знак автотранспортного средства',
                        textStyle10,
                        pw.Text(carPlate, style: textStyleBold10)),
                    pw.SizedBox(height: 8),

                    _tileRow(
                        '  Автотранспорт каражатынын идентификациялык номери \n  Идентификационный номер автотранспортного средства',
                        textStyle10,
                        pw.Text(carIdNumber, style: textStyleBold10)),
                    pw.SizedBox(height: 8),

                    _tileRow(
                        '  Автотранспорт каражатынын катталышы \n  жөнүндө күбөлүк, техникалык паспорт же техникалык \n  талон (же ушул сыяктуу документтер) \n  Свидетельство о регистрации \n  автотранспортного средства технический паспорт,\n  технический талон (либо аналогичный документ)',
                        textStyle8,
                        _textContainer(
                            'Свидетельство о регистрации ТС, $carTsNumber',
                            textStyleBold10)),

                    pw.SizedBox(height: 10),
                    _buildDriverTable(textStyle8, textStyle10, firstDriverName,
                        fistDriverDocNumber),

                    // paragraphs
                    pw.SizedBox(height: 10),
                    _buildParagraph4(textStyle8),

                    pw.SizedBox(height: 10),
                    _buildParagraph5(textStyle8),

                    pw.SizedBox(height: 10),
                    _buildParagraph6(textStyle8),

                    pw.SizedBox(height: 10),
                    _buildParagraph7(textStyle8),

                    pw.SizedBox(height: 10),
                    _buildParagraph8(textStyle8),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _tileRow(String title, pw.TextStyle style, pw.Widget content) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(horizontal: 10),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(title, style: style),
          pw.SizedBox(width: 20),
          pw.Expanded(child: content),
        ],
      ),
    );
  }

  pw.Widget _textContainer(String text, pw.TextStyle style) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.black, width: 0.4),
        ),
      ),
      child: pw.Text(text, style: style),
    );
  }

  pw.Widget _buildDateRow(
      String startDate, String endDate, pw.TextStyle style) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Келишимдин колдонуу мөөнөтү', style: style),
            pw.SizedBox(height: 5),
            pw.Text('Срок действия договора', style: style),
          ],
        ),
        pw.SizedBox(width: 12),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('$startDate ж. баштап $endDate чейин', style: style),
              pw.SizedBox(height: 5),
              pw.Text('$startDate г. по $endDate г.', style: style),
            ],
          ),
        )
      ],
    );
  }

  pw.Widget _buildDriverTable(pw.TextStyle headerStyle, pw.TextStyle cellStyle,
      String name, String number) {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.5),
      columnWidths: {
        0: pw.FixedColumnWidth(25),
        1: pw.FlexColumnWidth(3),
        2: pw.FlexColumnWidth(3),
      },
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text('№',
                  style: headerStyle, textAlign: pw.TextAlign.center),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                'Автотранспорт каражатын башкарууга уруксаты бар адамдар (аты-жөнү)\n'
                'Лица, допущенные к управлению автотранспортным средством (фамилия, имя, отчество)',
                style: headerStyle,
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Text(
                'Айдоочулук күбөлүгү (сериясы, номери)\nВодительское удостоверение (серия, номер)',
                style: headerStyle,
                textAlign: pw.TextAlign.center,
              ),
            ),
          ],
        ),
        ...List.generate(1, (index) {
          return pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text('${index + 1}', style: cellStyle),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text(name, style: cellStyle),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(4),
                child: pw.Text(number, style: cellStyle),
              ),
            ],
          );
        }),
      ],
    );
  }

  pw.Widget _buildParagraph1(pw.TextStyle style) {
    return pw.Text(
      'Камсыздандыруу автотранспорт каражатын пайдалануу мезгилинде болгон камсыздандыруу окуяларына келишимди төмөнкүдөй колдонуу мөөнөтүнүн ичинде таркатылат / Страхование распространяется на страховые случаи, произошедшие в период использования автотранспортного средства в течение срока действия договора:',
      style: style,
    );
  }

  pw.Widget _buildParagraph4(pw.TextStyle style) {
    return pw.Text(
      '4. Камсыздандыруу суммасынын минимумдук өлчөмүнүн чегинде зыян келтирилгендиги үчүн жоопкерчиликтин төмөнкүдөй лимиттери бекитилет В пределах минимального размера страховой суммы устанавливаются следующие лимиты ответственности по причинению вреда - ар бир жабырлануучунун (жабырлануучулардын) өмүрүнө же ден соолугуна – 300 000 (үч жүз миң) сом өлчөмүндө; жизни и здоровью каждого потерпевшего (потерпевших) – в размере 300 000 (триста тысяч) сомов; - бир жабырлануучунун мүлкүнө – 150 000 (жүз элүү миң) сом өлчөмүндө, бирок бардык жабырлануучуларга 450 000 (төрт жүз элүү миң) сомдон ашык эмес; имуществу одного потерпевшего – в размере 150 000 (сто пятьдесят тысяч) сомов, но не более 450 000 (четыреста пятьдесят тысяч) сомов на всех потерпевших;',
      style: style,
    );
  }

  pw.Widget _buildParagraph5(pw.TextStyle style) {
    return pw.Text(
      '5. Камсыздандыруу окуясы болуп автотранспорт каражатын эксплуатациялоо учурунда жол-транспорт кырсыгынын натыйжасында жабырлануучунун (үчүнчү жактардын) өмүрүнө, ден соолугуна же мүлкүнө зыян келтирилгендиги үчүн камсыздандырылуучунун жарандык-укуктук жоопкерчилиги орун ала тургандыгынын Страховым случаем признается факт наступления гражданско-правовой ответственности страхователя по возмещению вреда, причиненного жизни, здоровью или',
      style: style,
    );
  }

  pw.Widget _buildParagraph6(pw.TextStyle style) {
    return pw.Text(
      '6. имуществу потерпевшего (третьих лиц) в результате дорожно-транспортного происшествия при эксплуатации автотранспортного средства. Камсыздандыруу полиси Кыргыз Республикасынын аймагында колдонулат. Страховой полис действует на территории Кыргызской Республики.',
      style: style,
    );
  }

  pw.Widget _buildParagraph7(pw.TextStyle style) {
    return pw.Text(
      '7.  Камсыздандыруу сый төлөмү 3975.5520000000006 сом, бардык салык төлөмдөрдү эске алуу менен.Страховая премия 3975.5520000000006 сом , включено все налоги .',
      style: style,
    );
  }

  pw.Widget _buildParagraph8(pw.TextStyle style) {
    return pw.Text(
      '8. Өзгөчө белгилер Особые отметки',
      style: style,
    );
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    final filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}
