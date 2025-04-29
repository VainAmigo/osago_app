import 'package:flutter/material.dart';

class EmergancyInputTile extends StatelessWidget {
  final String title;
  final Widget firstWidget;

  const EmergancyInputTile({
    super.key,
    required this.title,
    required this.firstWidget,
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
        firstWidget,
        const SizedBox(height: 8),
      ],
    );
  }
}
