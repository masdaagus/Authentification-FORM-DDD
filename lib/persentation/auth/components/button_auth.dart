import 'package:flutter/material.dart';

import '../../core/constant/colors.dart';
import '../../core/constant/spacing.dart';

class ButtonAuth extends StatelessWidget {
  const ButtonAuth({
    Key? key,
    this.onTap,
    this.tittle,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String? tittle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 64,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(spacing3),
        ),
        child: Text(
          tittle ?? 'LOGIN',
          style: const TextStyle(
            color: lightColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
