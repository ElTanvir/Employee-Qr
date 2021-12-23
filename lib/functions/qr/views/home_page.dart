import 'package:employee_qr/constant/constants.dart';
import 'package:employee_qr/functions/qr/data_models/branch_data_model.dart';
import 'package:employee_qr/functions/qr/providers/branch_provider.dart';
import 'package:employee_qr/functions/qr/views/qr_view.dart';
import 'package:employee_qr/functions/qr/views/qr_view_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final zero = ref.watch(branchesProvider);
          return zero.map(
            data: (_) => Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                children: _.value
                    .map(
                      (branch) => SideButton(
                        branch: branch,
                      ),
                    )
                    .toList(),
              ),
            ),
            error: (_) => Center(child: Text(_.toString())),
            loading: (_) => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

class SideButton extends StatelessWidget {
  const SideButton({Key? key, required this.branch}) : super(key: key);

  final BranchData branch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        focusColor: kEltnavy,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeQrViewv2(
                branchID: branch.branch_id!,
              ),
            ),
          );
        },
        child: Container(
          height: 300,
          width: 300,
          decoration: getBoxDecoration,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                branch.branch_name ?? '',
                style: const TextStyle(
                  color: kEltblack,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
