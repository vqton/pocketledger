// lib/views/profile_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_viewmodel.dart';


class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel()..loadUserProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (viewModel.error != null) {
              return Center(child: Text('Error: ${viewModel.error}'));
            }

            if (viewModel.user == null) {
              return Center(child: Text('No user data available.'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (viewModel.user!.profilePictureUrl != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(viewModel.user!.profilePictureUrl!),
                    ),
                  SizedBox(height: 20),
                  Text('Name: ${viewModel.user!.name}'),
                  Text('Email: ${viewModel.user!.email}'),
                  if (viewModel.user!.phoneNumber != null)
                    Text('Phone: ${viewModel.user!.phoneNumber}'),
                  SizedBox(height: 20),
                  viewModel.isLoggingOut
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            await viewModel.logout();
                            Navigator.of(context).pushReplacementNamed('/login');
                          },
                          child: Text('Logout'),
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

// class ProfileView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ProfileViewModel()..loadUserProfile(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Profile'),
//         ),
//         body: Consumer<ProfileViewModel>(
//           builder: (context, viewModel, child) {
//             if (viewModel.user == null) {
//               return Center(child: CircularProgressIndicator());
//             }
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Name: ${viewModel.user!.name}'),
//                   Text('Email: ${viewModel.user!.email}'),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await viewModel.logout();
//                       Navigator.of(context).pushReplacementNamed('/login');
//                     },
//                     child: Text('Logout'),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }