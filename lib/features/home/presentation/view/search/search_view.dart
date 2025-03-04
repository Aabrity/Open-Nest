

// import 'dart:convert'; // For base64 decoding
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/app/di/di.dart';
// import 'package:open_nest/features/like/presentation/view_model/like_bloc.dart';
// import 'package:open_nest/features/listing/presentation/view/detail_view.dart';
// import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';

// class SearchListingView extends StatefulWidget {
//   const SearchListingView({super.key});

//   @override
//   _SearchListingViewState createState() => _SearchListingViewState();
// }

// class _SearchListingViewState extends State<SearchListingView> {
//   final TextEditingController _searchController = TextEditingController();

//   // Helper function to strip the data URL prefix
//   String _stripDataUrlPrefix(String base64String) {
//     return base64String.replaceFirst(RegExp(r'data:image\/[^;]+;base64,'), '');
//   }

//   // Helper function to check if a string is a valid base64 image
//   bool _isBase64Image(String? imageUrl) {
//     if (imageUrl == null || imageUrl.isEmpty) return false;
//     return imageUrl.startsWith('data:image/') && imageUrl.contains('base64,');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Listings', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   labelText: 'Search',
//                   border: OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.search),
//                     onPressed: () {
//                       setState(() {}); // Trigger filtering
//                     },
//                   ),
//                 ),
//                 onChanged: (value) {
//                   setState(() {}); // Trigger filtering on text change
//                 },
//               ),
//             ),
//             Expanded(
//               child: BlocBuilder<ListingBloc, ListingState>(
//                 builder: (context, state) {
//                   // Show loading indicator while fetching data
//                   if (state.isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   }

//                   // If data is loaded but no listings are found
//                   if (state.listings.isEmpty) {
//                     return const Center(
//                       child: Text('No Listings Found'),
//                     );
//                   }

//                   // Filter listings based on search query
//                   final filteredListings = state.listings.where((listing) {
//                     final query = _searchController.text.toLowerCase();
//                     return listing.name.toLowerCase().contains(query) ||
//                         listing.description.toLowerCase().contains(query) ||
//                         listing.address.toLowerCase().contains(query) ||
//                         listing.type!.toLowerCase().contains(query);
//                   }).toList();

//                   // If no listings match the search query
//                   if (filteredListings.isEmpty) {
//                     return const Center(
//                       child: Text('No Listings Match Your Search'),
//                     );
//                   }

//                   // Display filtered listings
//                   return ListView.builder(
//                     itemCount: filteredListings.length,
//                     itemBuilder: (context, index) {
//                       final listing = filteredListings[index];
//                       return GestureDetector(
//                         onTap: () {
//                           // Navigate to the detail page
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                builder: (context) =>    BlocProvider.value(
//                                             value: getIt<LikeBloc>(),
//                                             child: DetailPage(listing: listing),),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           elevation: 2,
//                           margin: const EdgeInsets.symmetric(vertical: 8),
//                           child: ListTile(
//                             leading: listing.imageUrls.isNotEmpty && _isBase64Image(listing.imageUrls[0])
//                                 ? Image.memory(
//                                     base64Decode(_stripDataUrlPrefix(listing.imageUrls[0])),
//                                     width: 50,
//                                     height: 50,
//                                     fit: BoxFit.cover,
//                                   )
//                                 : const Icon(Icons.image, size: 50),
//                             title: Text(listing.name),
//                             subtitle: Text(listing.type!),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }










import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/app/di/di.dart';
import 'package:open_nest/features/like/presentation/view_model/like_bloc.dart';
import 'package:open_nest/features/listing/presentation/view/detail_view.dart';
import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';

class SearchListingView extends StatefulWidget {
  const SearchListingView({super.key});

  @override
  _SearchListingViewState createState() => _SearchListingViewState();
}

class _SearchListingViewState extends State<SearchListingView> {
  final TextEditingController _searchController = TextEditingController();

  String _stripDataUrlPrefix(String base64String) {
    return base64String.replaceFirst(RegExp(r'data:image\/[^;]+;base64,'), '');
  }

  bool _isBase64Image(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return false;
    return imageUrl.startsWith('data:image/') && imageUrl.contains('base64,');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search something...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) => setState(() {}),
              ),
            ),
            Expanded(
              child: BlocBuilder<ListingBloc, ListingState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final filteredListings = state.listings.where((listing) {
                    final query = _searchController.text.toLowerCase();
                    return listing.name.toLowerCase().contains(query);
                  }).toList();

                  if (filteredListings.isEmpty) {
                    return const Center(child: Text('No Listings Match Your Search'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filteredListings.length,
                    itemBuilder: (context, index) {
                      final listing = filteredListings[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: getIt<LikeBloc>(),
                                child: DetailPage(listing: listing),
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              listing.imageUrls.isNotEmpty && _isBase64Image(listing.imageUrls[0])
                                  ? Image.memory(
                                      base64Decode(_stripDataUrlPrefix(listing.imageUrls[0])),
                                      fit: BoxFit.cover,
                                    )
                                  : Container(color: Colors.grey),
                              Container(
                                color: Colors.black.withOpacity(0.4),
                                alignment: Alignment.center,
                                child: Text(
                                  listing.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
