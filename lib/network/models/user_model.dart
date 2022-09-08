class UserModel {
  final String uid; // A unique id provided by firebase
  final String name;
  final String email;
  final String role;
  final bool isBooking;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.isBooking,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      isBooking: json['is_booking'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'is_booking': isBooking,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? role,
    bool? isBooking,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      isBooking: isBooking ?? this.isBooking,
    );
  }
}
