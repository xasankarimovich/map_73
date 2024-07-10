import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Ink(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
