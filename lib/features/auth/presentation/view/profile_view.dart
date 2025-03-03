

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:open_nest/features/auth/domain/use_case/update_user.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_bloc.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_event.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_state.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   String _avatarBase64 = '';

//   @override
//   void initState() {
//     super.initState();
//     // Trigger the FetchUserEvent when the page is initialized
//     context.read<UserBloc>().add(FetchUserEvent());
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//       final bytes = await file.readAsBytes();
//       setState(() {
//         _avatarBase64 = base64Encode(bytes); // Encode the image to Base64
//       });
//     }
//   }

//   DecorationImage _getAvatarImage(String avatarBase64) {
//     try {
//       return DecorationImage(
//         image: MemoryImage(base64Decode(avatarBase64)),
//         fit: BoxFit.cover,
//       );
//     } catch (e) {
//       // Handle invalid Base64 string (e.g., show a placeholder image)
//       return const DecorationImage(
//         image: AssetImage('assets/images/profile.jpg'),
//         fit: BoxFit.cover,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               // Trigger a fetch event when the refresh button is pressed
//               context.read<UserBloc>().add(FetchUserEvent());
//             },
//           ),
//         ],
//       ),
//       body: BlocConsumer<UserBloc, UserState>(
//         listener: (context, state) {
//           if (state is UserUpdated) {
//             // Show a snackbar when the profile is updated successfully
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Profile updated successfully!')),
//             );
//           } else if (state is UserError) {
//             // Show a snackbar when an error occurs
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Error: ${state.message}')),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is UserInitial) {
//             return const Center(
//               child: Text(
//                 'Loading user data...',
//                 style: TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             );
//           } else if (state is UserLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is UserLoaded) {
//             _usernameController.text = state.username;
//             _emailController.text = state.email;

//             // Initialize _avatarBase64 with the existing avatar if it's not already set
//             if (_avatarBase64.isEmpty && state.avatarBase64.isNotEmpty) {
//               _avatarBase64 = state.avatarBase64;
//             }

//             return RefreshIndicator(
//               onRefresh: () async {
//                 // Trigger a fetch event when the user pulls to refresh
//                 context.read<UserBloc>().add(FetchUserEvent());
//               },
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 20),
//                       GestureDetector(
//                         onTap: _pickImage,
//                         child: Container(
//                           width: 120,
//                           height: 120,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: Colors.white,
//                               width: 4,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 10,
//                                 spreadRadius: 2,
//                               ),
//                             ],
//                             image: _avatarBase64.isNotEmpty
//                                 ? _getAvatarImage(_avatarBase64) // Safely decode Base64
//                                 : state.avatarBase64.isNotEmpty
//                                     ? _getAvatarImage(state.avatarBase64) // Safely decode Base64
//                                     : const DecorationImage(
//                                         image: AssetImage('assets/images/profile.jpg'),
//                                         fit: BoxFit.cover,
//                                       ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       TextField(
//                         controller: _usernameController,
//                         decoration: const InputDecoration(
//                           labelText: 'Username',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       TextField(
//                         controller: _emailController,
//                         decoration: const InputDecoration(
//                           labelText: 'Email',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           labelText: 'Password',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       ElevatedButton(
//                         onPressed: () {
//                           final updateParams = UpdateUserParams(
//                             username: _usernameController.text,
//                             email: _emailController.text,
//                             password: _passwordController.text,
//                             avatar: _avatarBase64, // Use the current value of _avatarBase64
//                           );
//                           context.read<UserBloc>().add(UpdateUserEvent(updateParams));
//                         },
//                         child: const Text('Update Profile'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           } else if (state is UserError) {
//             return Center(
//               child: Text(
//                 'Error: ${state.message}',
//                 style: const TextStyle(fontSize: 16, color: Colors.red),
//               ),
//             );
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_nest/features/auth/domain/use_case/update_user.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_bloc.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_event.dart';
import 'package:open_nest/features/auth/presentation/view_model/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _avatarBase64 = '';

  @override
  void initState() {
    super.initState();
    // Trigger the FetchUserEvent when the page is initialized
    context.read<UserBloc>().add(FetchUserEvent());
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      setState(() {
        _avatarBase64 = base64Encode(bytes); // Encode the image to Base64
      });
    }
  }

  DecorationImage _getAvatarImage(String avatarBase64) {
    try {
      return DecorationImage(
        image: MemoryImage(base64Decode(avatarBase64)),
        fit: BoxFit.cover,
      );
    } catch (e) {
      // Handle invalid Base64 string (e.g., show a placeholder image)
      return const DecorationImage(
        image: AssetImage('assets/images/profile.jpg'),
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Trigger a fetch event when the refresh button is pressed
              context.read<UserBloc>().add(FetchUserEvent());
            },
          ),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserUpdated) {
            // Show a snackbar when the profile is updated successfully
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
          } else if (state is UserError) {
            // Show a snackbar when an error occurs
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is UserInitial) {
            return const Center(
              child: Text(
                'Loading user data...',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          } else if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            _usernameController.text = state.username;
            _emailController.text = state.email;

            // Initialize _avatarBase64 with the existing avatar if it's not already set
            if (_avatarBase64.isEmpty && state.avatarBase64.isNotEmpty) {
              _avatarBase64 = state.avatarBase64;
            }

            return RefreshIndicator(
              onRefresh: () async {
                // Trigger a fetch event when the user pulls to refresh
                context.read<UserBloc>().add(FetchUserEvent());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                            image: _avatarBase64.isNotEmpty
                                ? _getAvatarImage(_avatarBase64) // Safely decode Base64
                                : state.avatarBase64.isNotEmpty
                                    ? _getAvatarImage(state.avatarBase64) // Safely decode Base64
                                    : const DecorationImage(
                                        image: AssetImage('assets/images/profile.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildCurvedButton(
                        onPressed: () {
                          final updateParams = UpdateUserParams(
                            username: _usernameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            avatar: _avatarBase64, // Use the current value of _avatarBase64
                          );
                          context.read<UserBloc>().add(UpdateUserEvent(updateParams));
                        },
                         label: 'Update Listing',
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is UserError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  
}

 Widget _buildCurvedButton({
    required VoidCallback onPressed,
    String? label,
    IconData? icon,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, size: 20),
          if (icon != null && label != null) const SizedBox(width: 8),
          if (label != null) Text(label),
        ],
      ),
    );
  }
