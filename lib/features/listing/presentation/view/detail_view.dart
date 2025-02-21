// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';

// class ListingDetailsPage extends StatelessWidget {
//   final int index;

//   // Constructor to pass the index dynamically
//   const ListingDetailsPage({Key? key, required this.index}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Listing Details'),
//       ),
//       body: BlocBuilder<ListingBloc, ListingState>(
//         builder: (context, state) {
//           if (state.listings.isEmpty) {
//             return const Center(child: Text('No Listings Available'));
//           } else if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.error != null) {
//             return Center(child: Text(state.error!));
//           } else {
//             // Get the listing details based on the provided index
//             final listing = state.listings[index];

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       listing.name,
//                       style: Theme.of(context).textTheme.headlineSmall,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Description: ${listing.description}',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Address: ${listing.address}',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Regular Price: \$${listing.regularPrice}',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     Text(
//                       'Discount Price: \$${listing.discountedPrice}',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Bathrooms: ${listing.bathrooms}',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     Text(
//                       'Bedrooms: ${listing.bedrooms}',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Furnished: ${listing.furnished ? 'Yes' : 'No'}',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     Text(
//                       'Parking: ${listing.parking ? 'Yes' : 'No'}',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Listing Type: ${listing.type}',
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     const SizedBox(height: 10),
//                     // Displaying images
//                     if (listing.imageUrls.isNotEmpty)
//                       SizedBox(
//                         height: 150,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: listing.imageUrls.length,
//                           itemBuilder: (context, imageIndex) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 5),
//                               child: Image.file(
//                                 File(listing.imageUrls[imageIndex]),
//                                 width: 120,
//                                 height: 120,
//                                 fit: BoxFit.cover,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     const SizedBox(height: 20),
//                     // Button to go back
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: const Text('Back to Listings'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }



// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:open_nest/features/comments/presentation/bloc/comment_bloc.dart';
// import 'package:open_nest/features/comments/domain/entity/comment_entity.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
// import 'package:open_nest/features/comments/presentation/view_model/comment_state.dart';

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

//     // Fetch comments for this specific listing when the page is first built
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<CommentBloc>().add(GetCommentsByListing(listingId: listing.listingId));
//     });

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
//                   SizedBox(height: 32),

//                   // Comments Section
//                   Text(
//                     "Comments",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),

//                   // Display Comments
//                   BlocBuilder<CommentBloc, CommentState>(
//                     builder: (context, state) {
//                       if (state.isLoading) {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                       if (state.error.isNotEmpty) {
//                         return Center(child: Text('Error: ${state.error}'));
//                       }

//                       if (state.comment.isEmpty) {
//                         return Center(child: Text("No comments yet."));
//                       }

//                       return ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: state.comment.length,
//                         itemBuilder: (context, index) {
//                           CommentEntity comment = state.comment[index];
//                           return ListTile(
//                             title: Text(comment.comment),
//                             subtitle: Text('By: ${comment.user}'),
//                           );
//                         },
//                       );
//                     },
//                   ),

//                   SizedBox(height: 16),

//                   // Add Comment Section
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: TextField(
//                       onSubmitted: (commentText) {
//                         if (commentText.isNotEmpty) {
//                           // Dispatch CreateComment event
//                           context.read<CommentBloc>().add(CreateComment(comment: commentText, listingId: listing.listingId));
//                         }
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Add a comment...',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
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
// import 'package:open_nest/features/comments/presentation/view/comment_view.dart';

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

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/app/di/di.dart';
import 'package:open_nest/features/comments/presentation/view/comment_view.dart';
import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';

class DetailPage extends StatelessWidget {
  final dynamic listing;

  const DetailPage({Key? key, required this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decode Base64 Image
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
            // Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
              child: listingImage,
            ),
            SizedBox(height: 16),

            // Like and Comment Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Like Button
                  ElevatedButton(
                    onPressed: () {
                      // Add like functionality here (e.g., increment a like count or toggle state)
                      print('Liked ${listing.name}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Customize the color if needed
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.thumb_up),
                        SizedBox(width: 8),
                        Text("Like"),
                      ],
                    ),
                  ),
                  
                  // Comment Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to comment page and pass listingId
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                           builder: (context) => BlocProvider.value(
                              value: getIt<CommentBloc>(),
                              child: CommentView(listingId: listing.listingId),
                        ),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Customize the color if needed
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

            // Listing Details
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
                    "\$${listing.regularPrice} / month",
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

