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
    // Trigger the CommentLoad event when the page is built
    context.read<CommentBloc>().add(CommentLoad(listingId: listingId));

    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _commentViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: commentController,
                decoration: const InputDecoration(
                  labelText: 'Comment Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter comment name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              _buildCurvedButton(
                onPressed: () {
                  if (_commentViewFormKey.currentState!.validate()) {
                    context.read<CommentBloc>().add(
                          CreateComment(
                            comment: commentController.text,
                            listingId: listingId,
                          ),
                        );
                    commentController.clear(); // Clear the input field after submission
                  }
                },
                label: 'Add Comment',
              ),
              SizedBox(height: 10),
              BlocBuilder<CommentBloc, CommentState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.comment.isEmpty) {
                    return Center(child: Text('No Comments Added Yet'));
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
                                repository: getIt<AuthRemoteRepository>(), // Replace with your actual repository
                                tokenSharedPrefs: getIt<TokenSharedPrefs>(), // Replace with your actual shared prefs
                              ),
                            ),
                            child: BlocBuilder<UserCubit, UserState>(
                              builder: (context, userState) {
                                // Fetch user details when the widget is built
                                if (userState is UserInitial) {
                                  context.read<UserCubit>().fetchUserById(comment.user);
                                }

                                return ListTile(
                                  title: Text(comment.comment),
                                  subtitle: _buildUserSubtitle(userState),
                                  trailing: isCurrentUser
                                      ? IconButton(
                                          icon: Icon(Icons.delete),
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

  Widget _buildUserSubtitle(UserState userState) {
    if (userState is UserLoading) {
      return Text('Loading...');
    } else if (userState is UserLoaded) {
      return Text(userState.user.username ?? 'Unknown User');
    } else if (userState is UserError) {
      return Text('Unknown User');
    } else {
      return Text('Unknown User');
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
}