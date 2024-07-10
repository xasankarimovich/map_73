import 'package:flutter/material.dart';
import 'package:flutter_code/utils/styles/app_text_style.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.yellow,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Center(
              child: Text(
            title,
            style: AppTextStyle.interMedium.copyWith(
              color: Colors.white,
            ),
          )),
        ),
      ),
    );
  }
}
