// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_state.dart';

// class CommentView extends StatelessWidget {
//   final String listingId;
//   CommentView({super.key, required this.listingId});

//   final commentController = TextEditingController();
//   final _commentViewFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     // Trigger the CommentLoad event when the page is built
//     context.read<CommentBloc>().add(CommentLoad(listingId: listingId));

//     return Scaffold(
//       appBar: AppBar(title: Text('Comments')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _commentViewFormKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: commentController,
//                 decoration: const InputDecoration(
//                   labelText: 'Comment Name',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter comment name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               _buildCurvedButton(
//                 onPressed: () {
//                   if (_commentViewFormKey.currentState!.validate()) {
//                     context.read<CommentBloc>().add(
//                           CreateComment(
//                             comment: commentController.text,
//                             listingId: listingId,
//                           ),
//                         );
//                     commentController.clear(); // Clear the input field after submission
//                   }
//                 },
//                 label: 'Add Comment',
//               ),
//               SizedBox(height: 10),
//               BlocBuilder<CommentBloc, CommentState>(
//                 builder: (context, state) {
//                   if (state.isLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state.comment.isEmpty) {
//                     return Center(child: Text('No Comments Added Yet'));
//                   } else {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: state.comment.length,
//                         itemBuilder: (context, index) {
//                           final comment = state.comment[index];
//                           final isCurrentUser = comment.user == state.currentUserId;

//                           return ListTile(
//                             title: Text(comment.comment),
//                             subtitle: Text(comment.commentId!),
//                             trailing: isCurrentUser
//                                 ? IconButton(
//                                     icon: Icon(Icons.delete),
//                                     onPressed: () {
//                                       context.read<CommentBloc>().add(
//                                             DeleteComment(
//                                               id: comment.commentId!,
//                                               listingId: comment.listing,
//                                             ),
//                                           );
//                                     },
//                                   )
//                                 : null,
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//  Widget _buildCurvedButton({
//     required VoidCallback onPressed,
//     String? label,
//     IconData? icon,
//   }) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (icon != null) Icon(icon, size: 20),
//           if (icon != null && label != null) const SizedBox(width: 8),
//           if (label != null) Text(label),
//         ],
//       ),
//     );
//   }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/app/di/di.dart';
// import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
// import 'package:open_nest/features/auth/data/repository/auth_local_repository/auth_remote_repository.dart';
// import 'package:open_nest/features/auth/domain/use_case/get_user_by_id_for_comment.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_state.dart';
// import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
// import 'package:open_nest/features/comments/presentation/view_model/user_info_cubit/user_info_cubit.dart';

// class CommentView extends StatelessWidget {
//   final String listingId;
//   CommentView({super.key, required this.listingId});

//   final commentController = TextEditingController();
//   final _commentViewFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     // Trigger the CommentLoad event when the page is built
//     context.read<CommentBloc>().add(CommentLoad(listingId: listingId));

//     return Scaffold(
//       appBar: AppBar(title: Text('Comments')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _commentViewFormKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: commentController,
//                 decoration: const InputDecoration(
//                   labelText: 'Comment Name',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter comment name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               _buildCurvedButton(
//                 onPressed: () {
//                   if (_commentViewFormKey.currentState!.validate()) {
//                     context.read<CommentBloc>().add(
//                           CreateComment(
//                             comment: commentController.text,
//                             listingId: listingId,
//                           ),
//                         );
//                     commentController.clear(); // Clear the input field after submission
//                   }
//                 },
//                 label: 'Add Comment',
//               ),
//               SizedBox(height: 10),
//               BlocBuilder<CommentBloc, CommentState>(
//                 builder: (context, state) {
//                   if (state.isLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state.comment.isEmpty) {
//                     return Center(child: Text('No Comments Added Yet'));
//                   } else {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: state.comment.length,
//                         itemBuilder: (context, index) {
//                           final comment = state.comment[index];
//                           final isCurrentUser = comment.user == state.currentUserId;

//                           return BlocProvider(
//                             create: (context) => UserCubit(
//                               fetchUsernameByIdUseCase: FetchUsernameByIdUseCase(
//                                 repository: getIt<AuthRemoteRepository>(), // Replace with your actual repository
//                                 tokenSharedPrefs: getIt<TokenSharedPrefs>(), // Replace with your actual shared prefs
//                               ),
//                             ),
//                             child: BlocBuilder<UserCubit, UserState>(
//                               builder: (context, userState) {
//                                 // Fetch user details when the widget is built
//                                 if (userState is UserInitial) {
//                                   context.read<UserCubit>().fetchUserById(comment.user);
//                                 }

//                                 return ListTile(
//                                   title: Text(comment.comment),
//                                   subtitle: _buildUserSubtitle(userState),
//                                   trailing: isCurrentUser
//                                       ? IconButton(
//                                           icon: Icon(Icons.delete),
//                                           onPressed: () {
//                                             context.read<CommentBloc>().add(
//                                                   DeleteComment(
//                                                     id: comment.commentId!,
//                                                     listingId: comment.listing,
//                                                   ),
//                                                 );
//                                           },
//                                         )
//                                       : null,
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildUserSubtitle(UserState userState) {
//     if (userState is UserLoading) {
//       return Text('Loading...');
//     } else if (userState is UserLoaded) {
//       return Text(userState.user.username ?? 'Unknown User');
//     } else if (userState is UserError) {
//       return Text('Unknown User');
//     } else {
//       return Text('Unknown User');
//     }
//   }

//   Widget _buildCurvedButton({
//     required VoidCallback onPressed,
//     String? label,
//     IconData? icon,
//   }) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (icon != null) Icon(icon, size: 20),
//           if (icon != null && label != null) const SizedBox(width: 8),
//           if (label != null) Text(label),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/app/di/di.dart';
// import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
// import 'package:open_nest/features/auth/data/repository/auth_local_repository/auth_remote_repository.dart';
// import 'package:open_nest/features/auth/domain/use_case/get_user_by_id_for_comment.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_state.dart';
// import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
// import 'package:open_nest/features/comments/presentation/view_model/user_info_cubit/user_info_cubit.dart';

// class CommentView extends StatelessWidget {
//   final String listingId;
//   CommentView({super.key, required this.listingId});

//   final commentController = TextEditingController();
//   final _commentViewFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     // Trigger the CommentLoad event when the page is built
//     context.read<CommentBloc>().add(CommentLoad(listingId: listingId));

//     return Scaffold(
//       appBar: AppBar(title: Text('Comments')),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _commentViewFormKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: commentController,
//                 decoration: const InputDecoration(
//                   labelText: 'Comment Name',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter comment name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               _buildCurvedButton(
//                 onPressed: () {
//                   if (_commentViewFormKey.currentState!.validate()) {
//                     context.read<CommentBloc>().add(
//                           CreateComment(
//                             comment: commentController.text,
//                             listingId: listingId,
//                           ),
//                         );
//                     commentController.clear(); // Clear the input field after submission
//                   }
//                 },
//                 label: 'Add Comment',
//               ),
//               SizedBox(height: 10),
//               BlocBuilder<CommentBloc, CommentState>(
//                 builder: (context, state) {
//                   if (state.isLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state.comment.isEmpty) {
//                     return Center(child: Text('No Comments Added Yet'));
//                   } else {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: state.comment.length,
//                         itemBuilder: (context, index) {
//                           final comment = state.comment[index];
//                           final isCurrentUser = comment.user == state.currentUserId;

//                           return BlocProvider(
//                             create: (context) => UserCubit(
//                               fetchUsernameByIdUseCase: FetchUsernameByIdUseCase(
//                                 repository: getIt<AuthRemoteRepository>(), // Replace with your actual repository
//                                 tokenSharedPrefs: getIt<TokenSharedPrefs>(), // Replace with your actual shared prefs
//                               ),
//                             ),
//                             child: BlocBuilder<UserCubit, UserState>(
//                               builder: (context, userState) {
//                                 // Fetch user details when the widget is built
//                                 if (userState is UserInitial) {
//                                   context.read<UserCubit>().fetchUserById(comment.user);
//                                 }

//                                return ListTile(
//   title: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       // Username with avatar
//       _buildUserSubtitle(userState),
//       SizedBox(height: 4), // Add some spacing between username and comment
//       // Comment text
//       Text(
//         comment.comment,
//         style: TextStyle(fontSize: 20, color: Colors.black87),
//       ),
//     ],
//   ),
//   trailing: isCurrentUser
//       ? IconButton(
//           icon: Icon(Icons.delete, color: Colors.red),
//           onPressed: () {
//             context.read<CommentBloc>().add(
//                   DeleteComment(
//                     id: comment.commentId!,
//                     listingId: comment.listing,
//                   ),
//                 );
//           },
//         )
//       : null,
// );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget _buildUserSubtitle(UserState userState) {
//   //   if (userState is UserLoading) {
//   //     return Text('Loading...');
//   //   } else if (userState is UserLoaded) {
//   //     return Row(
//   //       children: [
//   //         if (userState.user.avatar != null)
//   //           CircleAvatar(
//   //             backgroundImage: MemoryImage(base64Decode(userState.user.avatar!)),),
//   //         SizedBox(width: 8),
//   //         Text(userState.user.username ?? 'Unknown User'),
//   //       ],
//   //     );
//   //   } else if (userState is UserError) {
//   //     return Text('Unknown User');
//   //   } else {
//   //     return Text('Unknown User');
//   //   }
//   // }

//   Widget _buildCurvedButton({
//     required VoidCallback onPressed,
//     String? label,
//     IconData? icon,
//   }) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (icon != null) Icon(icon, size: 20),
//           if (icon != null && label != null) const SizedBox(width: 8),
//           if (label != null) Text(label),
//         ],
//       ),
//     );
//   }
// }
// Widget _buildUserSubtitle(UserState userState) {
//   if (userState is UserLoading) {
//     return Text('Loading...', style: TextStyle(fontWeight: FontWeight.bold));
//   } else if (userState is UserLoaded) {
//     // Remove the "data:image/jpeg;base64," prefix if it exists
//     String? avatarBase64 = userState.user.avatar;
//     if (avatarBase64 != null && avatarBase64.startsWith('data:image')) {
//       avatarBase64 = avatarBase64.split(',').last;
//     }

//     return Row(
//       children: [
//         if (avatarBase64 != null)
//           CircleAvatar(
//             backgroundImage: MemoryImage(base64Decode(avatarBase64)),
//             radius: 12, // Adjust the size of the avatar
//           ),
//         SizedBox(width: 8),
//         Text(
//           userState.user.username ?? 'Unknown User',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
//         ),
//       ],
//     );
//   } else if (userState is UserError) {
//     return Text('Unknown User', style: TextStyle(fontWeight: FontWeight.bold));
//   } else {
//     return Text('Unknown User', style: TextStyle(fontWeight: FontWeight.bold));
//   }
// }



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/app/di/di.dart';
// import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
// import 'package:open_nest/features/auth/data/repository/auth_local_repository/auth_remote_repository.dart';
// import 'package:open_nest/features/auth/domain/use_case/get_user_by_id_for_comment.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_state.dart';
// import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
// import 'package:open_nest/features/comments/presentation/view_model/user_info_cubit/user_info_cubit.dart';

// class CommentView extends StatelessWidget {
//   final String listingId;
//   CommentView({super.key, required this.listingId});

//   final commentController = TextEditingController();
//   final _commentViewFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     // Trigger the CommentLoad event when the page is built
//     context.read<CommentBloc>().add(CommentLoad(listingId: listingId));

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Comments', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _commentViewFormKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: commentController,
//                 decoration: InputDecoration(
//                   labelText: 'Add a comment',
//                   labelStyle: TextStyle(color: Colors.grey),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.black),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a comment';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               _buildCurvedButton(
//                 onPressed: () {
//                   if (_commentViewFormKey.currentState!.validate()) {
//                     context.read<CommentBloc>().add(
//                           CreateComment(
//                             comment: commentController.text,
//                             listingId: listingId,
//                           ),
//                         );
//                     commentController.clear(); // Clear the input field after submission
//                   }
//                 },
//                 label: 'Post Comment',
//               ),
//               SizedBox(height: 16),
//               BlocBuilder<CommentBloc, CommentState>(
//                 builder: (context, state) {
//                   if (state.isLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state.comment.isEmpty) {
//                     return Center(child: Text('No comments yet. Be the first to comment!', style: TextStyle(color: Colors.grey)));
//                   } else {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: state.comment.length,
//                         itemBuilder: (context, index) {
//                           final comment = state.comment[index];
//                           final isCurrentUser = comment.user == state.currentUserId;

//                           return BlocProvider(
//                             create: (context) => UserCubit(
//                               fetchUsernameByIdUseCase: FetchUsernameByIdUseCase(
//                                 repository: getIt<AuthRemoteRepository>(), // Replace with your actual repository
//                                 tokenSharedPrefs: getIt<TokenSharedPrefs>(), // Replace with your actual shared prefs
//                               ),
//                             ),
//                             child: BlocBuilder<UserCubit, UserState>(
//                               builder: (context, userState) {
//                                 // Fetch user details when the widget is built
//                                 if (userState is UserInitial) {
//                                   context.read<UserCubit>().fetchUserById(comment.user);
//                                 }

//                                 return  Card(
//                                   margin: EdgeInsets.symmetric(vertical: 8),
//                                   elevation: 2,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(12.0),
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         // User avatar and username
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               _buildUserSubtitle(userState),
//                                               SizedBox(height: 8),
//                                               Text(
//                                                 comment.comment,
//                                                 style: TextStyle(fontSize: 16, color: Colors.black87),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         // Delete button (only for current user)
//                                         if (isCurrentUser)
//                                           IconButton(
//                                             icon: Icon(Icons.delete, color: Colors.red),
//                                             onPressed: () {
//                                               context.read<CommentBloc>().add(
//                                                     DeleteComment(
//                                                       id: comment.commentId!,
//                                                       listingId: comment.listing,
//                                                     ),
//                                                   );
//                                             },
//                                           ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCurvedButton({
//     required VoidCallback onPressed,
//     String? label,
//     IconData? icon,
//   }) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (icon != null) Icon(icon, size: 20),
//           if (icon != null && label != null) const SizedBox(width: 8),
//           if (label != null) Text(label, style: TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }

//   Widget _buildUserSubtitle(UserState userState) {
//     if (userState is UserLoading) {
//       return Text('Loading...', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey));
//     } else if (userState is UserLoaded) {
//       // Remove the "data:image/jpeg;base64," prefix if it exists
//       String? avatarBase64 = userState.user.avatar;
//       if (avatarBase64 != null && avatarBase64.startsWith('data:image')) {
//         avatarBase64 = avatarBase64.split(',').last;
//       }

//       return Row(
//         children: [
//           if (avatarBase64 != null)
//             CircleAvatar(
//               backgroundImage: MemoryImage(base64Decode(avatarBase64)),
//               radius: 16, // Adjust the size of the avatar
//             ),
//           SizedBox(width: 8),
//           Text(
//             userState.user.username ?? 'Unknown User',
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
//           ),
//         ],
//       );
//     } else if (userState is UserError) {
//       return Text('Unknown User', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey));
//     } else {
//       return Text('Unknown User', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey));
//     }
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/app/di/di.dart';
// import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
// import 'package:open_nest/features/auth/data/repository/auth_local_repository/auth_remote_repository.dart';
// import 'package:open_nest/features/auth/domain/use_case/get_user_by_id_for_comment.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_state.dart';
// import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
// import 'package:open_nest/features/comments/presentation/view_model/user_info_cubit/user_info_cubit.dart';

// class CommentView extends StatelessWidget {
//   final String listingId;
//   CommentView({super.key, required this.listingId});

//   final commentController = TextEditingController();
//   final _commentViewFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     context.read<CommentBloc>().add(CommentLoad(listingId: listingId));

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Comments', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _commentViewFormKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child:
//                 TextFormField(
//                   controller: commentController,
//                   decoration: InputDecoration(
//                     hintText: 'Add a comment...',
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                   prefixIcon: const Icon(Icons.comment_rounded),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a comment';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(height: 16),
//               _buildCurvedButton(
//                 onPressed: () {
//                   if (_commentViewFormKey.currentState!.validate()) {
//                     context.read<CommentBloc>().add(
//                       CreateComment(
//                         comment: commentController.text,
//                         listingId: listingId,
//                       ),
//                     );
//                     commentController.clear();
//                   }
//                 },
//                 label: 'Post Comment',
//               ),
//               SizedBox(height: 16),
//               BlocBuilder<CommentBloc, CommentState>(
//                 builder: (context, state) {
//                   if (state.isLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (state.comment.isEmpty) {
//                     return Center(child: Text('No comments yet. Be the first to comment!', style: TextStyle(color: Colors.grey)));
//                   } else {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: state.comment.length,
//                         itemBuilder: (context, index) {
//                           final comment = state.comment[index];
//                           final isCurrentUser = comment.user == state.currentUserId;

//                           return BlocProvider(
//                             create: (context) => UserCubit(
//                               fetchUsernameByIdUseCase: FetchUsernameByIdUseCase(
//                                 repository: getIt<AuthRemoteRepository>(),
//                                 tokenSharedPrefs: getIt<TokenSharedPrefs>(),
//                               ),
//                             ),
//                             child: BlocBuilder<UserCubit, UserState>(
//                               builder: (context, userState) {
//                                 if (userState is UserInitial) {
//                                   context.read<UserCubit>().fetchUserById(comment.user);
//                                 }

//                                 return Container(
//                                   margin: EdgeInsets.symmetric(vertical: 8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[100],
//                                     borderRadius: BorderRadius.circular(24),
//                                   ),
//                                   child: ListTile(
//                                     leading: userState is UserLoaded && userState.user.avatar != null
//                                         ? CircleAvatar(
//                                             backgroundImage: MemoryImage(base64Decode(userState.user.avatar!.split(',').last)),
//                                           )
//                                         : CircleAvatar(child: Icon(Icons.person, color: Colors.white), backgroundColor: Colors.grey),
//                                     title: Text(
//                                       userState is UserLoaded ? userState.user.username ?? 'Unknown User' : 'Unknown User',
//                                       style: TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                     subtitle: Text(
//                                       comment.comment,
//                                       style: TextStyle(color: Colors.black87),
//                                     ),
//                                     trailing: isCurrentUser
//                                         ? IconButton(
//                                             icon: Icon(Icons.delete, color: Colors.red),
//                                             onPressed: () {
//                                               context.read<CommentBloc>().add(
//                                                 DeleteComment(
//                                                   id: comment.commentId!,
//                                                   listingId: comment.listing,
//                                                 ),
//                                               );
//                                             },
//                                           )
//                                         : null,
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCurvedButton({
//     required VoidCallback onPressed,
//     String? label,
//     IconData? icon,
//   }) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (icon != null) Icon(icon, size: 20),
//           if (icon != null && label != null) const SizedBox(width: 8),
//           if (label != null) Text(label, style: TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/app/di/di.dart';
import 'package:open_nest/app/shared_prefs/token_shared_prefs.dart';
import 'package:open_nest/features/auth/data/repository/auth_local_repository/auth_remote_repository.dart';
import 'package:open_nest/features/auth/domain/use_case/get_user_by_id_for_comment.dart';
import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
import 'package:open_nest/features/comments/presentation/view_model/comment_state.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/comments/presentation/view_model/user_info_cubit/user_info_cubit.dart';

class CommentView extends StatelessWidget {
  final String listingId;
  CommentView({super.key, required this.listingId});

  final commentController = TextEditingController();
  final _commentViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    context.read<CommentBloc>().add(CommentLoad(listingId: listingId));

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Comments', style: TextStyle(color: Colors.black)),
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _commentViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child:  TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),
                  prefixIcon: const Icon(Icons.comment_rounded),
                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                  
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a comment';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              _buildCurvedButton(
                onPressed: () {
                  if (_commentViewFormKey.currentState!.validate()) {
                    context.read<CommentBloc>().add(
                      CreateComment(
                        comment: commentController.text,
                        listingId: listingId,
                      ),
                    );
                    commentController.clear();
                  }
                },
                label: 'Post Comment',
              ),
              SizedBox(height: 16),
              BlocBuilder<CommentBloc, CommentState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.comment.isEmpty) {
                    return Center(child: Text('No comments yet. Be the first to comment!', style: TextStyle(color: Colors.grey)));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.comment.length,
                        itemBuilder: (context, index) {
                          final comment = state.comment[index];
                          final isCurrentUser = comment.user == state.currentUserId;

                          return BlocProvider(
                            create: (context) => UserCubit(
                              fetchUsernameByIdUseCase: FetchUsernameByIdUseCase(
                                repository: getIt<AuthRemoteRepository>(),
                                tokenSharedPrefs: getIt<TokenSharedPrefs>(),
                              ),
                            ),
                            child: BlocBuilder<UserCubit, UserState>(
                              builder: (context, userState) {
                                if (userState is UserInitial) {
                                  context.read<UserCubit>().fetchUserById(comment.user);
                                }

                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.orangeAccent, width: 2.0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ListTile(
                                    leading: userState is UserLoaded && userState.user.avatar != null
                                        ? CircleAvatar(
                                            backgroundImage: MemoryImage(base64Decode(userState.user.avatar!.split(',').last)),
                                          )
                                        : CircleAvatar(child: Icon(Icons.person, color: Colors.white), backgroundColor: Colors.grey),
                                    title: Text(
                                      userState is UserLoaded ? userState.user.username ?? 'Unknown User' : 'Unknown User',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      comment.comment,
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                    trailing: isCurrentUser
                                        ? IconButton(
                                            icon: Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              context.read<CommentBloc>().add(
                                                DeleteComment(
                                                  id: comment.commentId!,
                                                  listingId: comment.listing,
                                                ),
                                              );
                                              
                                            },
                                          )
                                        : null,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
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
          if (label != null) Text(label, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
