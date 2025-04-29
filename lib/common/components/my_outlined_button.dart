import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function()? onPress;

  const MyOutlinedButton({
    super.key,
    required this.text,
    this.icon,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Color(0xFF32A3D6)),
        padding: EdgeInsets.symmetric(vertical: 20),
        backgroundColor: Color(0xFF32A3D6).withOpacity(0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF32A3D6),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 10),
          Icon(icon, color: Color(0xFF32A3D6),),
        ],
      ), // The button's label
    );
  }
}
