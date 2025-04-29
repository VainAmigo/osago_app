import 'package:flutter/material.dart';

class EmergancyInputTileD extends StatelessWidget {
  final String title;
  final Widget firstWidget;
  final Widget? secondWidget;

  const EmergancyInputTileD({
    super.key,
    required this.title,
    required this.firstWidget,
    this.secondWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: firstWidget),
            const SizedBox(width: 16),
            if (secondWidget != null) secondWidget!,
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
