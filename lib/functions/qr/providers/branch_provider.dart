import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:employee_qr/constant/constants.dart';
import 'package:employee_qr/functions/qr/data_models/branch_data_model.dart';
import 'package:employee_qr/functions/qr/data_models/department_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore_for_file: argument_type_not_assignable
final branchesProvider = FutureProvider.autoDispose((ref) async {
  final List<BranchData> branches = [];
  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
  final Response response = await dio.get('json/qr-branches');
  print(response.data);
  // ignore: avoid_dynamic_calls
  jsonDecode(response.data).forEach((element) {
    branches.add(BranchData.fromMap(element));
  });

  return branches;
});

final employeeProvider = FutureProvider.autoDispose
    .family<List<Department>, String>((ref, id) async {
  final List<Department> departments = [];
  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));
  final Response response = await dio.get('json/qr-code/$id');
  // ignore: avoid_dynamic_calls
  jsonDecode(response.data).forEach((element) {
    departments.add(Department.fromMap(element));
  });

  return departments;
});

final connectivityProvider =
    StateNotifierProvider.autoDispose<ConnectivityNotifier, bool>(
  (ref) => ConnectivityNotifier(),
);

class ConnectivityNotifier extends StateNotifier<bool> {
  ConnectivityNotifier() : super(false) {
    checkNetowrk();
  }
  // ignore: cancel_subscriptions
  StreamSubscription<ConnectivityResult>? subscription;
  void checkNetowrk() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print("Connected");
        state = true;
      } else {
        print("Disconnected");
        state = false;
      }
    });
  }

  @override
  void dispose() {
    if (subscription != null) {
      subscription!.cancel();
    }
    super.dispose();
  }
}
