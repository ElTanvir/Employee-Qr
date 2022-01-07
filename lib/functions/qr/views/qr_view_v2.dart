import 'dart:async';

import 'package:employee_qr/constant/constants.dart';
import 'package:employee_qr/functions/qr/data_models/department_model.dart';
import 'package:employee_qr/functions/qr/data_models/employee_model.dart';
import 'package:employee_qr/functions/qr/providers/branch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeQrViewv2 extends StatelessWidget {
  const EmployeeQrViewv2({Key? key, required this.branchID}) : super(key: key);
  final String branchID;

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final zero = ref.watch(employeeProvider(branchID));
          return zero.map(
            data: (_) => SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _.value.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox(
                        height: 50,
                        child: FittedBox(
                          child: Text(
                            'Rate / Complain About Employees',
                            textAlign: TextAlign.center,
                            style: kEltEcondtitleText.copyWith(
                              color: kEltred,
                              fontSize: 40,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return DepartmentView(
                        department: _.value[index - 1],
                      );
                    }
                  },
                ),
              ),
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

class DepartmentView extends StatefulWidget {
  const DepartmentView({Key? key, required this.department}) : super(key: key);
  final Department department;

  @override
  State<DepartmentView> createState() => _DepartmentViewState();
}

class _DepartmentViewState extends State<DepartmentView> {
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
      _scrollController.animateTo(
        reverse
            ? _scrollController.position.minScrollExtent
            : _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: durationDouble.toInt()),
        curve: Curves.linear,
      );
      reverse = !reverse;
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
    final Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: deviceSize.width,
        decoration: getBoxDecoration,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: kEltnavy,
                width: 50,
                height: (deviceSize.height - 80) / 4,
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FittedBox(
                      child: Text(
                        widget.department.department_name ?? '',
                        style: kElttitleText.copyWith(
                          fontSize: 30,
                          color: kEltred,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: deviceSize.width - 80,
              height: (deviceSize.height - 80) / 4,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.department.employees.length,
                itemBuilder: (context, index) {
                  return EmployeeCard(
                    employee: widget.department.employees[index],
                  );
                },
              ),
            ),
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
    final Size deviceSize = MediaQuery.of(context).size;
    final double cardHeight = (deviceSize.height - 80) / 4;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: getSecondBoxDecoration,
          height: cardHeight,
          width: cardHeight * 1.5,
          child: Row(
            children: [
              SizedBox(
                width: (cardHeight * 1.5) * 0.4,
                height: cardHeight,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 2,
                      ),
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            employee.full_name ?? '',
                            style: (employee.designation_name!
                                        .toLowerCase()
                                        .contains('in-charge') ||
                                    employee.designation_name!
                                        .toLowerCase()
                                        .contains('supervisor') ||
                                    employee.designation_name!
                                        .toLowerCase()
                                        .contains('incharge') ||
                                    employee.designation_name!
                                        .toLowerCase()
                                        .contains('deputy'))
                                ? kEltEcondtitleText.copyWith(
                                    color: kEltNeonBlue,
                                  )
                                : kEltEcondtitleText,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('$baseUrl${employee.photo}'),
                          radius: (cardHeight * 1.5) * 0.2,
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          child: Text(
                            employee.designation_name ?? '',
                            style: (employee.designation_name!
                                        .toLowerCase()
                                        .contains('in-charge') ||
                                    employee.designation_name!
                                        .toLowerCase()
                                        .contains('supervisor') ||
                                    employee.designation_name!
                                        .toLowerCase()
                                        .contains('incharge') ||
                                    employee.designation_name!
                                        .toLowerCase()
                                        .contains('deputy'))
                                ? kEltEcondtitleText.copyWith(
                                    color: kEltNeonBlue,
                                  )
                                : kEltEcondtitleText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  '$baseUrl${employee.qr_code}',
                  height: ((cardHeight * 1.5) * 0.6) - 20,
                  width: ((cardHeight * 1.5) * 0.6) - 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
