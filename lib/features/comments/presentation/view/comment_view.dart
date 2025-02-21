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
//     return SizedBox.expand(
//       child: Padding(
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
//               ElevatedButton(
//                 onPressed: () {
//                   if (_commentViewFormKey.currentState!.validate()) {
//                     context.read<CommentBloc>().add(
//                           CreateComment(
//                               comment: commentController.text, listingId:listingId ),
//                         );
//                   }
//                 },
//                 child: Text('Add Comment'),
//               ),
//               SizedBox(height: 10),
//               BlocBuilder<CommentBloc, CommentState>(
//                 builder: (context, state) {
//                   if (state.comment.isEmpty) {
//                     return Center(child: Text('No Comments Added Yet'));
//                   } else if (state.isLoading) {
//                     return CircularProgressIndicator();
//                   } else {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: state.comment.length,
//                         itemBuilder: (context, index) {
//                           final comment = state.comment[index];
//                           return ListTile(
//                             title: Text(comment.comment),
//                             subtitle: Text(comment.commentId!),
//                             trailing: IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () {
//                                 context.read<CommentBloc>().add(
//                                       DeleteComment(id: comment.commentId!),
//                                     );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
import 'package:open_nest/features/comments/presentation/view_model/comment_state.dart';

class CommentView extends StatelessWidget {
  final String listingId;
  CommentView({super.key, required this.listingId});

  final commentController = TextEditingController();
  final _commentViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(  // Wrap with Scaffold to provide Material ancestor
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
              ElevatedButton(
                onPressed: () {
                  if (_commentViewFormKey.currentState!.validate()) {
                    context.read<CommentBloc>().add(
                          CreateComment(
                            comment: commentController.text, 
                            listingId: listingId,
                          ),
                        );
                  }
                },
                child: Text('Add Comment'),
              ),
              SizedBox(height: 10),
              BlocBuilder<CommentBloc, CommentState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.comment.isEmpty) {
                    return Center(child: Text('No Comments Added Yet'));
                  } else {
                    return Expanded(  // Ensure the list view expands
                      child: ListView.builder(
                        itemCount: state.comment.length,
                        itemBuilder: (context, index) {
                          final comment = state.comment[index];
                          return ListTile(
                            title: Text(comment.comment),
                            subtitle: Text(comment.commentId!),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<CommentBloc>().add(
                                      DeleteComment(id: comment.commentId!),
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
}

