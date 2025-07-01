import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_home/core/enum/user_role.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;
  final UserRole role;
  final int buildingNo;
  final int apartmentNo;
  final DateTime registerTime;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
    required this.buildingNo,
    required this.apartmentNo,
    required this.registerTime,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      role: getRoleFromString(map['role']),
      buildingNo: map['buildingNo'] ?? 0,
      apartmentNo: map['apartmentNo'] ?? 0,
      registerTime: (map['registerTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'role': roleToString(role),
      'buildingNo': buildingNo,
      'apartmentNo': apartmentNo,
      'registerTime': registerTime,
    };
  }
}
