import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';

class ListingDetailsPage extends StatelessWidget {
  final int index;

  // Constructor to pass the index dynamically
  const ListingDetailsPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing Details'),
      ),
      body: BlocBuilder<ListingBloc, ListingState>(
        builder: (context, state) {
          if (state.listings.isEmpty) {
            return const Center(child: Text('No Listings Available'));
          } else if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text(state.error!));
          } else {
            // Get the listing details based on the provided index
            final listing = state.listings[index];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listing.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Description: ${listing.description}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Address: ${listing.address}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Regular Price: \$${listing.regularPrice}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Discount Price: \$${listing.discountedPrice}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Bathrooms: ${listing.bathrooms}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Bedrooms: ${listing.bedrooms}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Furnished: ${listing.furnished ? 'Yes' : 'No'}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Parking: ${listing.parking ? 'Yes' : 'No'}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Listing Type: ${listing.type}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    // Displaying images
                    if (listing.imageUrls.isNotEmpty)
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listing.imageUrls.length,
                          itemBuilder: (context, imageIndex) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.file(
                                File(listing.imageUrls[imageIndex]),
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 20),
                    // Button to go back
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Back to Listings'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
