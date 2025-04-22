import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatelessWidget {
  final String url;

  const QrCodeWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: url,
      version: QrVersions.auto,
      gapless: true,
      foregroundColor: Theme.of(context).colorScheme.tertiary,
      errorStateBuilder: (cxt, err) {
        return Center(
          child: Text(
            'Не удалось сгенерировать QR',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
