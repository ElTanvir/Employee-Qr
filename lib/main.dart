import 'package:employee_qr/constant/constants.dart';
import 'package:employee_qr/functions/qr/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore_for_file: argument_type_not_assignable

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent()
      },
      child: MaterialApp(
        title: 'Employee QR',
        theme: ThemeData(
          fontFamily: 'Dosis',
          colorScheme: const ColorScheme.light().copyWith(
            primary: kEltblack,
            secondary: kEltwhite,
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
