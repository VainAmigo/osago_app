import 'package:flutter/material.dart';

import '../../../common/components/qr_code_widget.dart';

class QrCodeBottomModalSheet extends StatelessWidget {
  final String polisId;
  final String url;

  const QrCodeBottomModalSheet({super.key, required this.polisId, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: Column(
        children: [
          Text(
            'No $polisId',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          QrCodeWidget(url: url)
        ],
      ),
    );
  }
}
