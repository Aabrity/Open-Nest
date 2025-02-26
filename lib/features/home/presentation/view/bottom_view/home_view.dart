
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// import 'package:open_nest/features/listing/presentation/bloc/listing_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/features/listing/presentation/view/detail_view.dart';
import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';
import 'dart:typed_data';
// import 'detail_page.dart'; // Import the Detail Page

class ListingPage extends StatefulWidget {
  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<ListingBloc>().add(ListingLoadAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TabBar(
          controller: _tabController,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.orange,
          tabs: [
            Tab(text: "Sale"),
            Tab(text: "Rent"),
            Tab(text: "Trending"),
          ],
        ),
      ),
      body: BlocBuilder<ListingBloc, ListingState>(
        bloc: GetIt.instance<ListingBloc>(),
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.listings.isEmpty) {
            return Center(child: Text('No listings available.'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: state.listings.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final listing = state.listings[index];

                // Decode Base64 Image
                Widget listingImage;
                if (listing.imageUrls.isNotEmpty && listing.imageUrls[0].startsWith("data:image")) {
                  try {
                    String base64String = listing.imageUrls[0].split(',').last;
                    Uint8List imageBytes = base64Decode(base64String);

                    listingImage = Image.memory(
                      imageBytes,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  } catch (e) {
                    listingImage = Image.asset(
                      'assets/placeholder.jpg',
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }
                } else {
                  listingImage = Image.asset(
                    'assets/placeholder.jpg',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(listing: listing),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                          child: listingImage,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listing.name,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "\$${listing.regularPrice} / month",
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              ),
                               SizedBox(height: 4),
                              Text(
                                "For : ${listing.type}",
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              ),
                              Text(
                                " ${listing.address}",
                                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
