import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback navigation;
  final Color color;

  const CustomButton({
    required this.title,
    required this.navigation,
    required this.color,
    
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black, // Warna garis tepi
            width: 2, // Lebar garis tepi
          ),
        ),
        child: TextButton(
          onPressed: navigation,
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}