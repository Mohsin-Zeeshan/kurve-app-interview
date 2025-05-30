class Customer {
  final int id;
  final String name;
  final int age;
  final String email;

  Customer({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      email: json['email'],
    );
  }
}
