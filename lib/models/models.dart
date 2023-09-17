class DepartmentModel {
  late final int id;
  late final String name;
  final ManagerModel manager;

  DepartmentModel({
    required this.id,
    required this.name,
    required this.manager,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(

      id: json['id'],
      name: json['name'],
      manager: ManagerModel(
        id: 2,
        userCode: "00002",
        name: "diaa",
        email: "h@h.com",
        phone:234324,
        status: "active",
        userType: "manager",
      ),
      /*ManagerModel.fromJson(json['manager']),*/
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'manager': manager.toJson(),
    };
  }
}

class ManagerModel {
  final int id;
  final String userCode;
  final String name;
  final String email;
  final int phone;
  final String status;
  final String userType;

  ManagerModel({
    required this.id,
    required this.userCode,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.userType,
  });

  factory ManagerModel.fromJson(Map<String, dynamic> json) {
    return ManagerModel(
      id: json['id'],
      userCode: json['user_code'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      userType: json['user_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_code': userCode,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
      'user_type': userType,
    };
  }
}

class UserModel {
  final int id;
  final String userCode;
  final String name;
  final String email;
  final int phone;
  final String status;
  final String userType;

  UserModel({
    required this.id,
    required this.userCode,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userCode: json['user_code'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      userType: json['user_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_code': userCode,
      'name': name,
      'email': email,
      'phone': phone,
      'status': status,
      'user_type': userType,
    };
  }
}