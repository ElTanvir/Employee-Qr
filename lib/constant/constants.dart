import 'package:flutter/cupertino.dart';

const Color kEltwhite = Color(0xFFF5F5F5);
const Color kEltred = Color(0xFFF05454);
const Color kEltnavy = Color(0xFF30475E);
const Color kEltblack = Color(0xFF121212);
const Color kEltNeonBlue = Color(0xFF00FFFF);

const String baseUrl = 'http://erp.superhostelbd.com/super_home/';

TextStyle kElttitleText = const TextStyle(
  color: kEltblack,
  fontWeight: FontWeight.bold,
);
TextStyle kEltEcondtitleText = const TextStyle(
  color: kEltwhite,
  fontWeight: FontWeight.bold,
);

final BoxDecoration getBoxDecoration = BoxDecoration(
  color: kEltwhite.withOpacity(0.8),
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      offset: const Offset(4, 4),
      blurRadius: 5,
      color: kEltblack.withOpacity(0.2),
    ),
  ],
);

final BoxDecoration getSecondBoxDecoration = BoxDecoration(
  color: kEltblack.withOpacity(0.8),
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      offset: const Offset(4, 4),
      blurRadius: 5,
      color: kEltblack.withOpacity(0.2),
    ),
  ],
);
