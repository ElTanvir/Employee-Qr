import 'dart:convert';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: argument_type_not_assignable

class Employee {
  String? photo;
  String? full_name;
  String? qr_code;
  String? designation_name;
  Employee({
    this.photo,
    this.full_name,
    this.qr_code,
    this.designation_name,
  });

  Employee copyWith({
    String? photo,
    String? full_name,
    String? qr_code,
    String? designation_name,
  }) {
    return Employee(
      photo: photo ?? this.photo,
      full_name: full_name ?? this.full_name,
      qr_code: qr_code ?? this.qr_code,
      designation_name: designation_name ?? this.designation_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'photo': photo,
      'full_name': full_name,
      'qr_code': qr_code,
      'designation_name': designation_name,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      photo: map['photo'],
      full_name: map['full_name'],
      qr_code: map['qr_code'],
      designation_name: map['designation_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(photo: $photo, full_name: $full_name, qr_code: $qr_code, designation_name: $designation_name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.photo == photo &&
        other.full_name == full_name &&
        other.qr_code == qr_code &&
        other.designation_name == designation_name;
  }

  @override
  int get hashCode {
    return photo.hashCode ^
        full_name.hashCode ^
        qr_code.hashCode ^
        designation_name.hashCode;
  }
}
