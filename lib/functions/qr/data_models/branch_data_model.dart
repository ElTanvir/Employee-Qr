import 'dart:convert';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: argument_type_not_assignable

class BranchData {
  String? branch_name;
  String? branch_id;
  BranchData({
    this.branch_name,
    this.branch_id,
  });

  BranchData copyWith({
    String? branch_name,
    String? branch_id,
  }) {
    return BranchData(
      branch_name: branch_name ?? this.branch_name,
      branch_id: branch_id ?? this.branch_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branch_name': branch_name,
      'branch_id': branch_id,
    };
  }

  factory BranchData.fromMap(Map<String, dynamic> map) {
    return BranchData(
      branch_name: map['branch_name'],
      branch_id: map['branch_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchData.fromJson(String source) =>
      BranchData.fromMap(json.decode(source));

  @override
  String toString() =>
      'BranchData(branch_name: $branch_name, branch_id: $branch_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BranchData &&
        other.branch_name == branch_name &&
        other.branch_id == branch_id;
  }

  @override
  int get hashCode => branch_name.hashCode ^ branch_id.hashCode;
}
