import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/features/home/presentation/view_model/home/home_bloc.dart';
import 'package:open_nest/features/home/presentation/view_model/home/home_event.dart';
import 'package:open_nest/features/home/presentation/view_model/home/home_state.dart';

import 'package:open_nest/core/theme/app_theme.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          int activeIndex = 0;
          double? saleOffset, rentOffset, trendingOffset;

          if (state is CategoryChangedState) {
            activeIndex = state.activeIndex;
            saleOffset = state.saleOffset;
            rentOffset = state.rentOffset;
            trendingOffset = state.trendingOffset;
          }

          final screenHeight = MediaQuery.of(context).size.height;
          final screenWidth = MediaQuery.of(context).size.width;
          final isLandscape = screenWidth > screenHeight;
          final ScrollController scrollController = ScrollController();

          return Scaffold(
            backgroundColor: AppTheme.backgroundColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  children: [
                    Material(
                      elevation: 4.0,
                      color: AppTheme.appBarBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _CategoryLink(
                              label: 'Sale',
                              index: 0,
                              scrollController: scrollController,
                              isActive: activeIndex == 0,
                              onTap: () {
                                context.read<HomeBloc>().add(
                                  CategoryChangedEvent(index: 0, offset: saleOffset),
                                );
                                scrollToSection(scrollController, saleOffset);
                              },
                            ),
                            _CategoryLink(
                              label: 'Rent',
                              index: 1,
                              scrollController: scrollController,
                              isActive: activeIndex == 1,
                              onTap: () {
                                context.read<HomeBloc>().add(
                                  CategoryChangedEvent(index: 1, offset: rentOffset),
                                );
                                scrollToSection(scrollController, rentOffset);
                              },
                            ),
                            _CategoryLink(
                              label: 'Trending',
                              index: 2,
                              scrollController: scrollController,
                              isActive: activeIndex == 2,
                              onTap: () {
                                context.read<HomeBloc>().add(
                                  CategoryChangedEvent(index: 2, offset: trendingOffset),
                                );
                                scrollToSection(scrollController, trendingOffset);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: screenHeight * 0.03),
                              _buildBanner(context, screenHeight),
                              _buildCategoryHeader('Sale', screenHeight, isLandscape),
                              SizedBox(height: screenHeight * 0.02),
                              _buildListingGrid(context, screenHeight, screenWidth, isLandscape),
                              SizedBox(height: screenHeight * 0.03),
                              _buildBanner(context, screenHeight),
                              _buildCategoryHeader('Rent', screenHeight, isLandscape),
                              SizedBox(height: screenHeight * 0.02),
                              _buildListingGrid(context, screenHeight, screenWidth, isLandscape),
                              SizedBox(height: screenHeight * 0.03),
                              _buildBanner(context, screenHeight),
                              _buildCategoryHeader('Trending', screenHeight, isLandscape),
                              SizedBox(height: screenHeight * 0.02),
                              _buildListingGrid(context, screenHeight, screenWidth, isLandscape),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  

  void scrollToSection(ScrollController controller, double? offset) {
    if (offset != null) {
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
 Widget _buildCategoryHeader(String title, double screenHeight, bool isLandscape) {
    return Container(
      padding: EdgeInsets.only(top: screenHeight * 0.02),
      child: Text(
        title,
        style: TextStyle(
          fontSize: isLandscape ? screenHeight * 0.05 : screenHeight * 0.023,
          fontWeight: FontWeight.bold,
          color: AppTheme.textColor,
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context,double screenHeight) {
    final isLandscape = MediaQuery.of(context).size.width > screenHeight;
    double bannerHeight = isLandscape
        ? screenHeight * 0.56
        : screenHeight * 0.25;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      height: bannerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: const AssetImage('assets/images/banner.jpg'),
          fit: isLandscape ? BoxFit.fitWidth : BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _buildListingGrid(BuildContext context, double screenHeight, double screenWidth, bool isLandscape) {
    double childAspectRatio = isLandscape ? 0.6 : 0.85;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 4 : 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return _buildListingCard(context, screenHeight, screenWidth, isLandscape);
      },
    );
  }

  Widget _buildListingCard(BuildContext context, double screenHeight, double screenWidth, bool isLandscape) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.cardBackgroundColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.cardShadowColor,
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double imageWidth = constraints.maxWidth;
                double containerHeight = isLandscape ? screenHeight * 0.4 : screenHeight * 0.14;

                return Container(
                  height: containerHeight,
                  width: imageWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/property.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: screenHeight * 0.01),
            LayoutBuilder(
              builder: (context, constraints) {
                double fontSizeTitle = screenHeight * 0.015;
                double fontSizePrice = screenHeight * 0.016;
                if (screenWidth > screenHeight) {
                  fontSizeTitle = screenHeight * 0.035;
                  fontSizePrice = screenHeight * 0.03;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Beautiful Apartment',
                      style: TextStyle(
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textColor,
                      ),
                    ),
                    Text(
                      '\$1,200 / month',
                      style: TextStyle(
                        fontSize: fontSizePrice,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryLink extends StatelessWidget {
  final String label;
  final int index;
  final ScrollController scrollController;
  final bool isActive;
  final VoidCallback onTap;

  const _CategoryLink({
    required this.label,
    required this.index,
    required this.scrollController,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
        double offset = 0.0;
        if (index == 0) {
          offset = 80; // Start at Sale
        }
        if (index == 1) {
          offset = 1000.0; // Start at Rent
        }
        if (index == 2) {
          offset = 2000.0; // Start at Trending
        }

        scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        onTap(); // This triggers the update in state and sets activeIndex
      },
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.orange : AppTheme.textColor,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w900,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              height: 5.0,
              width: 5.0,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
