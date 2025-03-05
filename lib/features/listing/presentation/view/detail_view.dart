

import 'dart:convert';
import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/app/di/di.dart';
import 'package:open_nest/core/error/failure.dart';
import 'package:open_nest/features/auth/domain/use_case/get_user_by_id_for_comment.dart';
import 'package:open_nest/features/auth/domain/entity/auth_entity.dart';
import 'package:open_nest/features/comments/presentation/view/comment_view.dart';
import 'package:open_nest/features/like/presentation/view_model/like_bloc.dart';
import 'package:open_nest/features/listing/presentation/view/contact_form.dart';
import 'package:open_nest/features/comments/presentation/view_model/comment_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class DetailPage extends StatelessWidget {
  final dynamic listing;
  final PanelController _panelController = PanelController();

  DetailPage({Key? key, required this.listing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<LikeBloc>().add(LikeLoad(listingId: listing.listingId));

    Widget listingImage;
    if (listing.imageUrls.isNotEmpty && listing.imageUrls[0].startsWith("data:image")) {
      try {
        String base64String = listing.imageUrls[0].split(',').last;
        Uint8List imageBytes = base64Decode(base64String);

        listingImage = Image.memory(
          imageBytes,
          // height: double.infinity,
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
        title: Text(
          listing.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orangeAccent,
          ),
        ),
        foregroundColor: Colors.orange,
        backgroundColor: Colors.black,
        elevation: 3,
        shadowColor: Colors.orange,
      ),
      body: SlidingUpPanel(
        controller: _panelController,
        minHeight: 80,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
        panelBuilder: (scrollController) => _buildCommentPanel(scrollController, context),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // For large screens like tablets, we can use a row layout to display content side-by-side
            if (constraints.maxWidth > 600) {
              return Row(
                children: [
                  // Listing Image
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15.0)),
                      child: listingImage,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Details Section
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildDetails(context),
                    ),
                  ),
                ],
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15.0)),
                        child: listingImage,
                      ),
                      const SizedBox(height: 16),
                      _buildDetails(context),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          listing.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "\\${listing.regularPrice} / month",
          style: const TextStyle(fontSize: 18, color: Colors.green),
        ),
        const SizedBox(height: 16),
        const Text(
          "Description",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          listing.description,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.bathtub, color: Colors.grey),
                const SizedBox(width: 8),
                Text('${listing.bathrooms} Baths', style: const TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.bed, color: Colors.grey),
                const SizedBox(width: 8),
                Text('${listing.bedrooms} Beds', style: const TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              children: [
                Icon(listing.furnished ? Icons.tv : Icons.check_box_outline_blank, color: Colors.grey),
              ],
            ),
            Row(
              children: [
                Icon(listing.parking ? Icons.local_parking : Icons.car_crash, color: Colors.grey),
              ],
            ),
            Row(
              children: [
                Icon(Icons.house, color: Colors.grey),
                const SizedBox(width: 8),
                Text(listing.type, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Like Button and Count
        BlocBuilder<LikeBloc, LikeState>(
          builder: (context, state) {
            final isLiked = state.likes.any((like) =>
                like.listing == listing.listingId && like.user == state.currentUserId);
            final likeCount = state.likes
                .where((like) => like.listing == listing.listingId)
                .length;

            return Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (isLiked) {
                      final like = state.likes.firstWhere((like) =>
                          like.listing == listing.listingId &&
                          like.user == state.currentUserId);
                      context.read<LikeBloc>().add(
                          DeleteLike(id: like.likeId!, listingId: listing.listingId));
                    } else {
                      context.read<LikeBloc>().add(
                          CreateLike(listing: listing.listingId));
                    }
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 36,
                  ),
                ),
                Text('$likeCount likes', style: const TextStyle(fontSize: 16)),
              ],
            );
          },
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FutureBuilder<Either<Failure, AuthEntity>>(
            future: getIt<FetchUsernameByIdUseCase>().call(listing.userRef),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text(
                  'Failed to load landlord details',
                  style: TextStyle(color: Colors.red),
                );
              } else if (snapshot.hasData) {
                return snapshot.data!.fold(
                  (failure) => Text(
                    'Failed to load landlord details',
                    style: TextStyle(color: Colors.red),
                  ),
                  (landlord) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Landlord Details',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Name: ${landlord.username ?? 'Unknown'}',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        Text(
                          'Email: ${landlord.email}',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        const SizedBox(height: 200),
                      ],
                    );
                  },
                );
              } else {
                return Text(
                  'No landlord details available',
                  style: TextStyle(color: Colors.grey),
                );
                
              }
            },
            
          ),
          
        ),
      ],
    );
  }

  Widget _buildCommentPanel(ScrollController scrollController, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Comments",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocProvider(
              create: (context) => getIt<CommentBloc>()..add(CommentLoad(listingId: listing.listingId)),
              child: CommentView(listingId: listing.listingId),
            ),
          ),
        ],
      ),
    );
  }
}
