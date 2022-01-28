import 'package:employee_qr/constant/constants.dart';
import 'package:employee_qr/functions/qr/views/home_page.dart';
import 'package:employee_qr/functions/qr/views/qr_view_v2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
// ignore_for_file: argument_type_not_assignable

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final box = GetStorage();

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
        home: (box.read('branch_id') == null || box.read('branch_id') == '')
            ? const MyHomePage()
            : EmployeeQrViewv2(
                branchID: box.read('branch_id'),
              ),
      ),
    );
  }
}
