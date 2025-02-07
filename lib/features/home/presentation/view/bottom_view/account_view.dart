// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:open_nest/features/auth/presentation/view_model/profile_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../../../profile/presentation/view_model/profile_bloc.dart';
// import '../../../../profile/presentation/view_model/profile_event.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final _gap = const SizedBox(height: 16);
//   final _key = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();

//   // Variable to hold profile image
//   File? _img;

//   // Check for camera permission
//   Future<void> checkCameraPermission() async {
//     if (await Permission.camera.request().isRestricted ||
//         await Permission.camera.request().isDenied) {
//       await Permission.camera.request();
//     }
//   }

//   Future _browseImage(ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         setState(() {
//           _img = File(image.path);
//           // Send image to server or profile update logic
//           context.read<ProfileBloc>().add(UploadProfilePictureEvent(file: _img!, filePath: ''));
//         });
//       } else {
//         return;
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     // Here, you might want to load the current profile data to pre-fill the form
//     final profileState = context.read<ProfileBloc>().state;
//     _usernameController.text = profileState.username;
//     _emailController.text = profileState.email;
//     // Load profile image if available
//     setState(() {
//       _img = profileState.avatar;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _key,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     height:
//                         isLandscape ? screenHeight * 0.25 : screenHeight * 0.1,
//                     width: isLandscape ? screenWidth * 0.15 : screenWidth * 0.3,
//                     decoration: BoxDecoration(
//                       color: Colors.blueGrey,
//                       image: const DecorationImage(
//                         image: AssetImage('assets/images/logo.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.03),
//                   Text(
//                     "Edit Profile",
//                     style: TextStyle(
//                       fontSize: isLandscape
//                           ? screenHeight * 0.04
//                           : screenHeight * 0.025,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.01),
//                   Text(
//                     "Update your details below.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: isLandscape
//                           ? screenHeight * 0.03
//                           : screenHeight * 0.017,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.01),
//                   InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                         backgroundColor: Colors.grey[300],
//                         context: context,
//                         isScrollControlled: true,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(20),
//                           ),
//                         ),
//                         builder: (context) => Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   checkCameraPermission();
//                                   _browseImage(ImageSource.camera);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(Icons.camera),
//                                 label: const Text('Camera'),
//                               ),
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   _browseImage(ImageSource.gallery);
//                                   Navigator.pop(context);
//                                 },
//                                 icon: const Icon(Icons.image),
//                                 label: const Text('Gallery'),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 60,
//                           backgroundImage: _img != null
//                               ? FileImage(_img!)
//                               : const AssetImage('assets/images/profile.png')
//                                   as ImageProvider,
//                         ),
//                         Container(
//                           height: 120,
//                           width: 120,
//                           decoration: BoxDecoration(
//                             color: Colors.black54,
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.camera_alt,
//                             size: 40,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 25),
//                   _buildTextField(
//                     controller: _usernameController,
//                     label: 'Username',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter username';
//                       }
//                       return null;
//                     },
//                   ),
//                   _gap,
//                   _buildTextField(
//                     controller: _emailController,
//                     label: 'Email',
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter email';
//                       }
//                       return null;
//                     },
//                   ),
//                   _gap,
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         if (_key.currentState!.validate()) {
//                           context.read<ProfileBloc>().add(
//                                 UpdateProfileEvent(
//                                   username: _usernameController.text,
//                                   email: _emailController.text,
//                                   avatar: _img, 
//                                   password: '',
//                                 ),
//                               );
//                         }
//                       },
//                       child: const Text(
//                         'Save Changes',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       ),
//       validator: validator,
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'profile View',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}

