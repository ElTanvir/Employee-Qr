import 'dart:async';

import 'package:employee_qr/constant/constants.dart';
import 'package:employee_qr/functions/qr/data_models/department_model.dart';
import 'package:employee_qr/functions/qr/data_models/employee_model.dart';
import 'package:employee_qr/functions/qr/providers/branch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeQrView extends StatefulWidget {
  const EmployeeQrView({Key? key, required this.branchID}) : super(key: key);
  final String branchID;

  @override
  State<EmployeeQrView> createState() => _EmployeeQrViewState();
}

class _EmployeeQrViewState extends State<EmployeeQrView> {
  ScrollController _scrollController = ScrollController();
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoscroll();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
    _scrollController.dispose();
  }

  void autoscroll() {
    bool reverse = false;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      final double maxExtent = _scrollController.position.maxScrollExtent;
      final double distanceDifference = maxExtent - _scrollController.offset;
      final double durationDouble = distanceDifference / 20;
      print(durationDouble);
      timer = Timer.periodic(Duration(seconds: durationDouble.toInt() + 2),
          (timer) {
        _scrollController.animateTo(
          reverse
              ? _scrollController.position.minScrollExtent
              : _scrollController.position.maxScrollExtent,
          duration: Duration(seconds: durationDouble.toInt()),
          curve: Curves.linear,
        );
        reverse = !reverse;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final zero = ref.watch(employeeProvider(widget.branchID));
          return zero.map(
            data: (_) => ListView.builder(
              controller: _scrollController,
              itemCount: _.value.length,
              itemBuilder: (context, index) {
                return DepartmentView(
                  department: _.value[index],
                );
              },
            ),
            error: (_) => Center(
              child: Text(_.error.toString()),
            ),
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class DepartmentView extends StatelessWidget {
  const DepartmentView({Key? key, required this.department}) : super(key: key);
  final Department department;

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: (deviceSize.width / 2) - 20,
        decoration: getBoxDecoration,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                department.department_name ?? '',
                style: kElttitleText.copyWith(fontSize: 30),
              ),
            ),
            Wrap(
              children: department.employees
                  .map(
                    (employee) => EmployeeCard(
                      employee: employee,
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({Key? key, required this.employee}) : super(key: key);
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: getSecondBoxDecoration,
          height: 200,
          width: 300,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FittedBox(
                        child: Text(
                          employee.full_name ?? '',
                          style: kEltEcondtitleText,
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage('$baseUrl${employee.photo}'),
                        radius: 50,
                      ),
                      FittedBox(
                        child: Text(
                          employee.designation_name ?? '',
                          style: kEltEcondtitleText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  '$baseUrl${employee.qr_code}',
                  height: 130,
                  width: 130,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
