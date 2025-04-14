import 'package:flutter/material.dart';

import '../../../common/localization/language_constants.dart';

class StatusMark extends StatelessWidget {
  final bool isActive;

  const StatusMark({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final Color colorGreen = Color(0xFF55B049);
    final Color colorRed = Color(0xFFE04F54);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? colorGreen.withOpacity(0.06)
            : colorRed.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? colorGreen : colorRed, width: 1.0),
      ),
      child: Text(
        isActive ? translation(context).homeScreenPolisCardStatusActive : translation(context).homeScreenPolisCardStatusDisable,
        style: TextStyle(
          color: isActive ? colorGreen : colorRed,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }
}
