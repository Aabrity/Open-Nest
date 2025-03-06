
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/app/di/di.dart';
import 'package:open_nest/features/comments/presentation/view_model/user_info_cubit/user_info_cubit.dart';
import 'package:open_nest/features/like/presentation/view_model/like_bloc.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/presentation/view/detail_view.dart';
import 'dart:typed_data';

import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';

class ListingPage extends StatefulWidget {
  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<ListingBloc>().add(ListingLoadAll());

    // Listen to tab index changes to scroll to the appropriate section
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        _scrollController.animateTo(
          1.0, // Scroll to the sale section
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else if (_tabController.index == 1) {
        _scrollController.animateTo(
          1200.0, // Scroll to the rent section (adjust the value as needed)
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Check if the screen is a tablet or mobile
    bool isTablet = screenWidth > 600;

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

          // Divide the listings into Sale and Rent
          List<ListingEntity> saleListings = state.listings.where((listing) => listing.type == 'sale').toList();
          List<ListingEntity> rentListings = state.listings.where((listing) => listing.type == 'rent').toList();

          // Set the number of items per row for grid based on device type
          int crossAxisCount = isTablet ? 4 : 2;

          return SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_tabController.index == 0) ...[
                    // Sale Listings Section
                    Text("SALE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: saleListings.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75, // Adjust for tablets
                      ),
                      itemBuilder: (context, index) {
                        final listing = saleListings[index];
                        return _buildListingCard(context, listing);
                      },
                    ),
                  ],
                  if (_tabController.index == 0 || _tabController.index == 1) ...[
                    // Rent Listings Section
                    Text("RENT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: rentListings.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75, // Adjust for tablets
                      ),
                      itemBuilder: (context, index) {
                        final listing = rentListings[index];
                        return _buildListingCard(context, listing);
                      },
                    ),
                     SizedBox(height: 50),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListingCard(BuildContext context, ListingEntity listing) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: getIt<LikeBloc>()),
                BlocProvider(create: (context) => getIt<UserCubit>()), // Ensure UserCubit stays alive
              ],
              child: DetailPage(listing: listing),
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: listing.imageUrls.isNotEmpty &&
                      listing.imageUrls[0].startsWith("data:image")
                  ? Image.memory(
                      base64Decode(listing.imageUrls[0].split(',').last),
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/placeholder.jpg',
                      height: 420,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              height: 420,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white, size: 14),
                      SizedBox(width: 5),
                      Text(
                        listing.address,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 70,
              left: 15,
              child: Text(
                "NRP ${listing.regularPrice}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
