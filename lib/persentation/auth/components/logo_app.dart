import 'package:flutter/material.dart';
import '../../core/constant/constant.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(spacing2),
        child: Image.network(
          'https://logos-marques.com/wp-content/uploads/2021/03/Apple-logo.png',
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
