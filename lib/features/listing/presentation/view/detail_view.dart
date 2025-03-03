
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/app/di/di.dart';
// import 'package:open_nest/features/comments/presentation/view/comment_view.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';

// class DetailPage extends StatelessWidget {
//   final dynamic listing;

//   const DetailPage({Key? key, required this.listing}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Decode Base64 Image
//     Widget listingImage;
//     if (listing.imageUrls.isNotEmpty && listing.imageUrls[0].startsWith("data:image")) {
//       try {
//         String base64String = listing.imageUrls[0].split(',').last;
//         Uint8List imageBytes = base64Decode(base64String);

//         listingImage = Image.memory(
//           imageBytes,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         );
//       } catch (e) {
//         listingImage = Image.asset(
//           'assets/placeholder.jpg',
//           width: double.infinity,
//           fit: BoxFit.cover,
//         );
//       }
//     } else {
//       listingImage = Image.asset(
//         'assets/placeholder.jpg',
//         width: double.infinity,
//         fit: BoxFit.cover,
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(listing.name),
//         backgroundColor: Colors.orange,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
//               child: listingImage,
//             ),
//             SizedBox(height: 16),

//             // Like and Comment Buttons
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Like Button
//                   ElevatedButton(
//                     onPressed: () {
//                       // Add like functionality here (e.g., increment a like count or toggle state)
//                       print('Liked ${listing.name}');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue, // Customize the color if needed
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.thumb_up),
//                         SizedBox(width: 8),
//                         Text("Like"),
//                       ],
//                     ),
//                   ),
                  
//                   // Comment Button
//                   ElevatedButton(
//                     onPressed: () {
//                       // Navigate to comment page and pass listingId
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                            builder: (context) => BlocProvider.value(
//                               value: getIt<CommentBloc>(),
//                               child: CommentView(listingId: listing.listingId),
//                         ),
//                       ));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green, // Customize the color if needed
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.comment),
//                         SizedBox(width: 8),
//                         Text("Comment"),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             // Listing Details
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     listing.name,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "\$${listing.regularPrice} / month",
//                     style: TextStyle(fontSize: 18, color: Colors.green),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "Description",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     listing.description,
//                     style: TextStyle(fontSize: 16, color: Colors.black87),
//                   ),  
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/app/di/di.dart';
// import 'package:open_nest/features/comments/presentation/view/comment_view.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
// import 'package:open_nest/features/like/presentation/view_model/like_bloc.dart';
// import 'package:open_nest/features/like/domain/entity/like_entity.dart';

// class DetailPage extends StatelessWidget {
//   final dynamic listing;

//   const DetailPage({Key? key, required this.listing}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Widget listingImage;
//     if (listing.imageUrls.isNotEmpty && listing.imageUrls[0].startsWith("data:image")) {
//       try {
//         String base64String = listing.imageUrls[0].split(',').last;
//         Uint8List imageBytes = base64Decode(base64String);

//         listingImage = Image.memory(
//           imageBytes,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         );
//       } catch (e) {
//         listingImage = Image.asset(
//           'assets/placeholder.jpg',
//           width: double.infinity,
//           fit: BoxFit.cover,
//         );
//       }
//     } else {
//       listingImage = Image.asset(
//         'assets/placeholder.jpg',
//         width: double.infinity,
//         fit: BoxFit.cover,
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(listing.name),
//         backgroundColor: Colors.orange,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
//               child: listingImage,
//             ),
//             SizedBox(height: 16),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   BlocBuilder<LikeBloc, LikeState>(
//                     builder: (context, state) {
//                       final isLiked = state.likes.any((like) => like.listing == listing.listingId);
//                       final likeCount = state.likes.where((like) => like.listing == listing.listingId).length;

//                       return Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               if (isLiked) {
//                                 final like = state.likes.firstWhere((like) => like.listing == listing.listingId);
//                                 context.read<LikeBloc>().add(DeleteLike(id: like.user, listingId: listing.listingId));
//                               } else {
//                                 context.read<LikeBloc>().add(CreateLike(listing: listing.listingId));
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: isLiked ? Colors.red : Colors.blue,
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(isLiked ? Icons.thumb_down : Icons.thumb_up),
//                                 SizedBox(width: 8),
//                                 Text(isLiked ? "Unlike" : "Like"),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Text('$likeCount likes'),
//                         ],
//                       );
//                     },
//                   ),

//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BlocProvider.value(
//                             value: getIt<CommentBloc>(),
//                             child: CommentView(listingId: listing.listingId),
//                           ),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.comment),
//                         SizedBox(width: 8),
//                         Text("Comment"),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     listing.name,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "\\${listing.regularPrice} / month",
//                     style: TextStyle(fontSize: 18, color: Colors.green),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "Description",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     listing.description,
//                     style: TextStyle(fontSize: 16, color: Colors.black87),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/app/di/di.dart';
// import 'package:open_nest/features/comments/presentation/view/comment_view.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
// import 'package:open_nest/features/like/presentation/view_model/like_bloc.dart';
// import 'package:open_nest/features/like/domain/entity/like_entity.dart';

// class DetailPage extends StatelessWidget {
//   final dynamic listing;

//   const DetailPage({Key? key, required this.listing}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Widget listingImage;
//     if (listing.imageUrls.isNotEmpty && listing.imageUrls[0].startsWith("data:image")) {
//       try {
//         String base64String = listing.imageUrls[0].split(',').last;
//         Uint8List imageBytes = base64Decode(base64String);

//         listingImage = Image.memory(
//           imageBytes,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         );
//       } catch (e) {
//         listingImage = Image.asset(
//           'assets/placeholder.jpg',
//           width: double.infinity,
//           fit: BoxFit.cover,
//         );
//       }
//     } else {
//       listingImage = Image.asset(
//         'assets/placeholder.jpg',
//         width: double.infinity,
//         fit: BoxFit.cover,
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(listing.name),
//         backgroundColor: Colors.orange,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
//               child: listingImage,
//             ),
//             SizedBox(height: 16),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   BlocBuilder<LikeBloc, LikeState>(
//                     builder: (context, state) {
//                       final isLiked = state.likes.any((like) => like.listing == listing.listingId);
//                       final likeCount = state.likes.where((like) => like.listing == listing.listingId).length;

//                       return Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               if (isLiked) {
//                                 final like = state.likes.firstWhere((like) => like.listing == listing.listingId);
//                                 context.read<LikeBloc>().add(DeleteLike(id: like.likeId!, listingId: listing.listingId));
//                               } else {
//                                 context.read<LikeBloc>().add(CreateLike(listing: listing.listingId));
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: isLiked ? Colors.red : Colors.blue,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(isLiked ? Icons.thumb_down : Icons.thumb_up),
//                                 SizedBox(width: 8),
//                                 Text(isLiked ? "Unlike" : "Like"),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Text('$likeCount likes'),
//                         ],
//                       );
//                     },
//                   ),

//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BlocProvider.value(
//                             value: getIt<CommentBloc>(),
//                             child: CommentView(listingId: listing.listingId),
//                           ),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.comment),
//                         SizedBox(width: 8),
//                         Text("Comment"),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     listing.name,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "\\${listing.regularPrice} / month",
//                     style: TextStyle(fontSize: 18, color: Colors.green),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "Description",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     listing.description,
//                     style: TextStyle(fontSize: 16, color: Colors.black87),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/app/di/di.dart';
// import 'package:open_nest/features/comments/presentation/view/comment_view.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
// import 'package:open_nest/features/like/presentation/view_model/like_bloc.dart';
// import 'package:open_nest/features/like/domain/entity/like_entity.dart';

// class DetailPage extends StatelessWidget {
//   final dynamic listing;

//   const DetailPage({Key? key, required this.listing}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Widget listingImage;
//     if (listing.imageUrls.isNotEmpty && listing.imageUrls[0].startsWith("data:image")) {
//       try {
//         String base64String = listing.imageUrls[0].split(',').last;
//         Uint8List imageBytes = base64Decode(base64String);

//         listingImage = Image.memory(
//           imageBytes,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         );
//       } catch (e) {
//         listingImage = Image.asset(
//           'assets/placeholder.jpg',
//           width: double.infinity,
//           fit: BoxFit.cover,
//         );
//       }
//     } else {
//       listingImage = Image.asset(
//         'assets/placeholder.jpg',
//         width: double.infinity,
//         fit: BoxFit.cover,
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(listing.name),
//         backgroundColor: Colors.orange,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
//               child: listingImage,
//             ),
//             SizedBox(height: 16),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   BlocBuilder<LikeBloc, LikeState>(
//                     builder: (context, state) {
//                       final isLiked = state.likes.any((like) => like.listing == listing.listingId);
//                       final likeCount = state.likes.where((like) => like.listing == listing.listingId).length;

//                       return Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               if (isLiked) {
//                                 final like = state.likes.firstWhere((like) => like.listing == listing.listingId);
//                                 context.read<LikeBloc>().add(DeleteLike(id: like.likeId!, listingId: listing.listingId));
//                               } else {
//                                 context.read<LikeBloc>().add(CreateLike(listing: listing.listingId));
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: isLiked ? Colors.red : Colors.blue,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(isLiked ? Icons.thumb_down : Icons.thumb_up),
//                                 SizedBox(width: 8),
//                                 Text(isLiked ? "Unlike" : "Like"),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Text('$likeCount likes'),
//                         ],
//                       );
//                     },
//                   ),

//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BlocProvider.value(
//                             value: getIt<CommentBloc>(),
//                             child: CommentView(listingId: listing.listingId),
//                           ),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.comment),
//                         SizedBox(width: 8),
//                         Text("Comment"),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     listing.name,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "\\${listing.regularPrice} / month",
//                     style: TextStyle(fontSize: 18, color: Colors.green),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "Description",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     listing.description,
//                     style: TextStyle(fontSize: 16, color: Colors.black87),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/app/di/di.dart';
import 'package:open_nest/features/comments/presentation/view/comment_view.dart';
import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
import 'package:open_nest/features/like/presentation/view_model/like_bloc.dart';

class DetailPage extends StatelessWidget {
  final dynamic listing;

  const DetailPage({Key? key, required this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch likes for the listing when the page is loaded
    context.read<LikeBloc>().add(LikeLoad(listingId: listing.listingId));

    Widget listingImage;
    if (listing.imageUrls.isNotEmpty && listing.imageUrls[0].startsWith("data:image")) {
      try {
        String base64String = listing.imageUrls[0].split(',').last;
        Uint8List imageBytes = base64Decode(base64String);

        listingImage = Image.memory(
          imageBytes,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      } catch (e) {
        listingImage = Image.asset(
          'assets/placeholder.jpg',
          width: double.infinity,
          fit: BoxFit.cover,
        );
      }
    } else {
      listingImage = Image.asset(
        'assets/placeholder.jpg',
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(listing.name),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
              child: listingImage,
            ),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              BlocBuilder<LikeBloc, LikeState>(
  builder: (context, state) {
    final isLiked = state.likes.any((like) => like.listing == listing.listingId && like.user == state.currentUserId);
    final likeCount = state.likes.where((like) => like.listing == listing.listingId).length;

    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            if (isLiked) {
              final like = state.likes.firstWhere((like) => like.listing == listing.listingId && like.user == state.currentUserId);
              context.read<LikeBloc>().add(DeleteLike(id: like.likeId!, listingId: listing.listingId));
            } else {
              context.read<LikeBloc>().add(CreateLike(listing: listing.listingId));
            }
          },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isLiked ? Colors.red : Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(isLiked ? Icons.thumb_down : Icons.thumb_up),
                                SizedBox(width: 8),
                                Text(isLiked ? "Unlike" : "Like"),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('$likeCount likes'),
                        ],
                      );
                    },
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: getIt<CommentBloc>(),
                            child: CommentView(listingId: listing.listingId),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.comment),
                        SizedBox(width: 8),
                        Text("Comment"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "\\${listing.regularPrice} / month",
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Description",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    listing.description,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}