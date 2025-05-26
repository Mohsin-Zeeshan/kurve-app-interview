// // ignore_for_file: camel_case_types
// import 'package:frontend/home.dart';

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Kurve Customer Manager',
//       home: CustomerListScreen(),  // Updated to show live customer data
// // home: customerScreen(),
//     );
//   }
// }



// class Customer {
//   final int id;
//   final String name;
//   final int age;
//   final String email;

//   Customer({required this.id, required this.name, required this.age, required this.email});

//   factory Customer.fromJson(Map<String, dynamic> json) {
//     return Customer(
//       id: json['id'],
//       name: json['name'],
//       age: json['age'],
//       email: json['email'],
//     );
//   }
// }

// class customerScreen extends StatefulWidget {
//   const customerScreen({super.key});

//   @override
//   _customerScreenState createState() => _customerScreenState();
// }

// class _customerScreenState extends State<customerScreen> {
//   List<Customer> customers = [];
//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _emailController = TextEditingController();

//   final String baseUrl = 'http://localhost:5000/customers';

//   Future<void> fetchCustomers() async {
//     final response = await http.get(Uri.parse(baseUrl));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       setState(() {
//         customers = data.map((json) => Customer.fromJson(json)).toList();
//       });
//     }
//   }

//   Future<void> addCustomer() async {
//     final response = await http.post(Uri.parse(baseUrl),
//       headers: {"Content-Type": "application/json"},
//       body: json.encode({
//         'name': _nameController.text,
//         'age': int.parse(_ageController.text),
//         'email': _emailController.text
//       })
//     );
//     if (response.statusCode == 201) {
//       fetchCustomers();
//       _nameController.clear();
//       _ageController.clear();
//       _emailController.clear();
//     }
//   }

//   Future<void> deleteCustomer(int id) async {
//     final response = await http.delete(Uri.parse('$baseUrl/$id'));
//     if (response.statusCode == 200) {
//       fetchCustomers();
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchCustomers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Customers')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
//             TextField(controller: _ageController, decoration: const InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number),
//             TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
//             ElevatedButton(onPressed: addCustomer, child: const Text('Add Customer')),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: customers.length,
//                 itemBuilder: (context, index) {
//                   final customer = customers[index];
//                   return ListTile(
//                     title: Text(customer.name),
//                     subtitle: Text('${customer.age} - ${customer.email}'),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () => deleteCustomer(customer.id),
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
// import 'customer.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomerListScreen(),  // home: original_home_screen
    );
  }
}

