import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({
    super.key,
    required this.meesage,
    this.label,
    this.onClickAction,
  });

  final String meesage;
  final String? label;
  final VoidCallback? onClickAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: Colors.black,
      ),
      width: double.maxFinite,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Text(
              meesage,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          if (label != null && onClickAction != null)
            GestureDetector(
              onTap: onClickAction,
              child: Text(
                label!,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w800,
                  fontSize: 16.0,
                ),
              ),
            )
        ],
      ),
    );
  }
}
