class UserModel {
  final int id;
  final String name;
  final String email;
  final int age;
  final String gender;
  final String phone;
  final String lastName;
  final String image;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.phone,
    required this.lastName,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['firstName'] ?? '',
      email: json['email'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      phone: json['phone'] ?? '',
      lastName: json['lastName'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
