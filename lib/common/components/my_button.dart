import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onPress;

  const MyButton({
    super.key,
    required this.text,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.primary,
          disabledBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          disabledForegroundColor: Colors.white,
          side: BorderSide.none,
          padding: EdgeInsets.symmetric(vertical: 20),
          textStyle: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
