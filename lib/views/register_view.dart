// lib/views/register_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../viewmodels/register_viewmodel.dart';
import 'profile_view.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        body: Consumer<RegisterViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Logo
                  Center(
                      child:
                          Image.asset('assets/images/logo.png', height: 100)),
                  const SizedBox(height: 20),
                  // Name TextField
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email TextField
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // Confirm Password TextField
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // Terms and Conditions Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: viewModel.agreeToTerms,
                        onChanged: (bool? value) {
                          viewModel.setAgreeToTerms(value ?? false);
                        },
                      ),
                      const Text('I agree to the Terms and Conditions'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Register Button
                  viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Passwords do not match'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return;
                            }
                            UserModel? user = await viewModel.register(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (user != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Registration Successful: ${user.name}'),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileView()), // Navigate to ProfileView
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Registration Failed'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          child: const Text('Register'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// class RegisterView extends StatelessWidget {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => RegisterViewModel(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text('Register'),
//           backgroundColor: Colors.blueAccent,
//           foregroundColor: Colors.white,
//         ),
//         body: Consumer<RegisterViewModel>(
//           builder: (context, viewModel, child) {
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // App Logo
//                   Center(child: Image.asset('assets/images/logo.png', height: 100)),
//                   const SizedBox(height: 20),
//                   // Name TextField
//                   TextField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Name',
//                       hintText: 'Enter your name',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.person),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Email TextField
//                   TextField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                       hintText: 'Enter your email',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.email),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Password TextField
//                   TextField(
//                     controller: _passwordController,
//                     decoration: const InputDecoration(
//                       labelText: 'Password',
//                       hintText: 'Enter your password',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.lock),
//                     ),
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 20),
//                   // Register Button
//                   viewModel.isLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : ElevatedButton(
//                           onPressed: () async {
//                             UserModel? user = await viewModel.register(
//                               _nameController.text,
//                               _emailController.text,
//                               _passwordController.text,
//                             );
//                             if (user != null) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text('Registration Successful: ${user.name}'),
//                                   duration: const Duration(seconds: 3),
//                                 ),
//                               );
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Registration Failed'),
//                                   duration: Duration(seconds: 3),
//                                 ),
//                               );
//                             }
//                           },
//                           child: const Text('Register'),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blueAccent,
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                             textStyle: const TextStyle(fontSize: 16),
//                           ),
//                         ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
