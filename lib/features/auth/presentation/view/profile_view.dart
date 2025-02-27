// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Placeholder user data
//     final Map<String, String> placeholderUser = {
//       'userId': '12345',
//       'email': 'user@example.com',
//       'username': 'john_doe',
//     };

//     return Scaffold(
//       body: Container(
//         color: Colors.grey[50], // Light gray background
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Profile Picture
//                 Container(
//                   width: 120,
//                   height: 120,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Colors.white,
//                       width: 4,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 10,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                     image: const DecorationImage(
//                       image: AssetImage('assets/profile_placeholder.png'), // Add a placeholder image in your assets
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 // User Name
//                 Text(
//                   placeholderUser['username']!.toUpperCase(),
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 // User Email
//                 Text(
//                   placeholderUser['email']!,
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 // User Info Card
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 20),
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 10,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       // User ID
//                       _buildInfoRow(Icons.person_outline, 'User ID', placeholderUser['userId']!),
//                       const SizedBox(height: 15),
//                       // Divider
//                       Divider(color: Colors.grey[300]),
//                       const SizedBox(height: 15),
//                       // Email
//                       _buildInfoRow(Icons.email_outlined, 'Email', placeholderUser['email']!),
//                       const SizedBox(height: 15),
//                       // Divider
//                       Divider(color: Colors.grey[300]),
//                       const SizedBox(height: 15),
//                       // Username
//                       _buildInfoRow(Icons.verified_user_outlined, 'Username', placeholderUser['username']!),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper method to build a row with icon, title, and value
//   Widget _buildInfoRow(IconData icon, String title, String value) {
//     return Row(
//       children: [
//         Icon(icon, color: Colors.blueGrey[600], size: 24),
//         const SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:open_nest/features/auth/presentation/bloc/user_bloc.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_bloc.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_event.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_state.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Profile'),
//       ),
//       body: BlocBuilder<UserBloc, UserState>(
//         builder: (context, state) {
//           if (state is UserInitial) {
//             return const Center(child: Text('Press the button to fetch user data.'));
//           } else if (state is UserLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is UserLoaded) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (state.avatarBase64.isNotEmpty)
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: MemoryImage(
//                         base64Decode(state.avatarBase64),
//                       ),
//                     ),
//                   const SizedBox(height: 20),
//                   Text('Username: ${state.username}'),
//                   Text('Email: ${state.email}'),
//                   Text('User ID: ${state.userId}'),
//                 ],
//               ),
//             );
//           } else if (state is UserError) {
//             // debugPrint("erorrrrrrr______________ ${state.message}");
//             return Center(child: Text('Error: ${state.message}'));
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           context.read<UserBloc>().add(FetchUserEvent());
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_bloc.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_event.dart';
// import 'package:open_nest/features/auth/presentation/view_model/profile_state.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.grey[50], // Light gray background
//         child: BlocBuilder<UserBloc, UserState>(
//           builder: (context, state) {
//             if (state is UserInitial) {
//               return const Center(
//                 child: Text(
//                   'Press the button to fetch user data.',
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//               );
//             } else if (state is UserLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is UserLoaded) {
//               return SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 40),
//                     // Profile Picture
//                     Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 4,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                         image: state.avatarBase64.isNotEmpty
//                             ? DecorationImage(
//                                 image: MemoryImage(base64Decode(state.avatarBase64)),
//                                 fit: BoxFit.cover,
//                               )
//                             : const DecorationImage(
//                                 image: AssetImage('assets/images/profile.jpg'), 
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // User Name
//                     Text(
//                       state.username.toUpperCase(),
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     // User Email
//                     Text(
//                       state.email,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     // User Info Card
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 20),
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           // User ID
//                           _buildInfoRow(Icons.person_outline, 'User ID', state.userId),
//                           const SizedBox(height: 15),
//                           // Divider
//                           Divider(color: Colors.grey[300]),
//                           const SizedBox(height: 15),
//                           // Email
//                           _buildInfoRow(Icons.email_outlined, 'Email', state.email),
//                           const SizedBox(height: 15),
//                           // Divider
//                           Divider(color: Colors.grey[300]),
//                           const SizedBox(height: 15),
//                           // Username
//                           _buildInfoRow(Icons.verified_user_outlined, 'Username', state.username),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is UserError) {
//               return Center(
//                 child: Text(
//                   'Error: ${state.message}',
//                   style: const TextStyle(fontSize: 16, color: Colors.red),
//                 ),
//               );
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           context.read<UserBloc>().add(FetchUserEvent());
//         },
//         child: const Icon(Icons.refresh),
//         backgroundColor: Colors.blueAccent,
//       ),
//     );
//   }

//   // Helper method to build a row with icon, title, and value
//   Widget _buildInfoRow(IconData icon, String title, String value) {
//     return Row(
//       children: [
//         Icon(icon, color: Colors.blueGrey[600], size: 24),
//         const SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.grey[50],
//         child: BlocBuilder<UserBloc, UserState>(
//           builder: (context, state) {
//             if (state is UserInitial) {
//               return const Center(
//                 child: Text(
//                   'Press the button to fetch user data.',
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//               );
//             } else if (state is UserLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is UserLoaded) {
//               _usernameController.text = state.username;
//               _emailController.text = state.email;

//               return SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 40),
//                     Container(
//                       width: 120,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 4,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 10,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                         image: state.avatarBase64.isNotEmpty
//                             ? DecorationImage(
//                                 image: MemoryImage(base64Decode(state.avatarBase64)),
//                                 fit: BoxFit.cover,
//                               )
//                             : const DecorationImage(
//                                 image: AssetImage('assets/images/profile.jpg'),
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: TextField(
//                         controller: _usernameController,
//                         decoration: const InputDecoration(
//                           labelText: 'Username',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: TextField(
//                         controller: _emailController,
//                         decoration: const InputDecoration(
//                           labelText: 'Email',
//                           border: OutlineInputBorder(),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     ElevatedButton(
//                       onPressed: () {
//                         context.read<UserBloc>().add(FetchUserEvent(
//                           username: _usernameController.text,
//                           email: _emailController.text,
//                         ));
//                       },
//                       child: const Text('Update Profile'),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state is UserError) {
//               return Center(
//                 child: Text(
//                   'Error: ${state.message}',
//                   style: const TextStyle(fontSize: 16, color: Colors.red),
//                 ),
//               );
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           context.read<UserBloc>().add(FetchUserEvent());
//         },
//         child: const Icon(Icons.refresh),
//         backgroundColor: Colors.blueAccent,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _emailController.dispose();
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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bytes = await file.readAsBytes();
      setState(() {
        _avatarBase64 = base64Encode(bytes);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[50],
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              return const Center(
                child: Text(
                  'Press the button to fetch user data.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            } else if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              _usernameController.text = state.username;
              _emailController.text = state.email;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
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
                              ? DecorationImage(
                                  image: MemoryImage(base64Decode(_avatarBase64)),
                                  fit: BoxFit.cover,
                                )
                              : state.avatarBase64.isNotEmpty
                                  ? DecorationImage(
                                      image: MemoryImage(base64Decode(state.avatarBase64)),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image: AssetImage('assets/images/profile.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        final updateParams = UpdateUserParams(
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          avatar: _avatarBase64,
                        );
                        context.read<UserBloc>().add(UpdateUserEvent(updateParams));
                      },
                      child: const Text('Update Profile'),
                    ),
                  ],
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<UserBloc>().add(FetchUserEvent());
        },
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.blueAccent,
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