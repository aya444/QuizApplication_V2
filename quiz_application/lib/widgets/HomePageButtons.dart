import 'package:flutter/material.dart';

class HomePageButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const HomePageButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Button color
        fixedSize: Size(190, 70),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: TextStyle(fontSize: 20, color: Colors.purple, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      label: Text(label),
    );
  }
}
