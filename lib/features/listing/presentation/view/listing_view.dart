


import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_nest/app/di/di.dart';
import 'package:open_nest/features/listing/presentation/view/edit_listing_view.dart';
import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';
import 'package:open_nest/features/listing/presentation/view_model/add%20listings/userlisting/user_listing_bloc.dart';

class ListingView extends StatefulWidget {
  const ListingView({super.key});

  @override
  _ListingViewState createState() => _ListingViewState();
}

class _ListingViewState extends State<ListingView> {
  final listingNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final regularPriceController = TextEditingController();
  final discountPriceController = TextEditingController();
  final bathroomsController = TextEditingController();
  final bedroomsController = TextEditingController();

  bool offer = false;
  bool furnished = false;
  bool parking = false;
  String? type = 'rent';

  final _listingViewFormKey = GlobalKey<FormState>();

  List<String> base64Images = []; // To store Base64 encoded images

  final _picker = ImagePicker();

  // Function to pick multiple images and convert to Base64
  Future<void> pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        base64Images = pickedFiles
            .map((file) => base64Encode(File(file.path).readAsBytesSync()))
            .toList();
      });
    }
  }

  int parseInteger(String value, String fieldName) {
    if (value.isEmpty) {
      throw Exception('$fieldName cannot be empty');
    }
    final parsedValue = int.tryParse(value);
    if (parsedValue == null) {
      throw Exception('Invalid number entered for $fieldName');
    }
    return parsedValue;
  }

  @override
  void initState() {
    super.initState();
  
    context.read<UserListingBloc>().add(LoadUserListing('currentUserId')); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Listing', style: TextStyle(color: Color.fromARGB(255, 111, 110, 110))),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _listingViewFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Listing Name
                TextFormField(
                  controller: listingNameController,
                  decoration: const InputDecoration(
                    labelText: 'Listing Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter listing name' : null,
                ),
                const SizedBox(height: 16),

                // Description
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter description' : null,
                ),
                const SizedBox(height: 16),

                // Address
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter address' : null,
                ),
                const SizedBox(height: 16),

                // Price and Details
                Column(
                  children: [
                    TextFormField(
                      controller: regularPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Regular Price',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: discountPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Discounted Price',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: bathroomsController,
                      decoration: const InputDecoration(
                        labelText: 'Bathrooms',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: bedroomsController,
                      decoration: const InputDecoration(
                        labelText: 'Bedrooms',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Image Picker
                _buildCurvedButton(
                  onPressed: pickImages,
                  icon: Icons.photo_library,
                  label: 'Pick Images',
                ),
                const SizedBox(height: 16),

                // Display Selected Images
                if (base64Images.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: base64Images.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            Image.memory(
                              base64Decode(base64Images[index]),
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.cancel, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    base64Images.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 16),

                // Checkboxes
                Column(
                  children: [
                    CheckboxListTile(
                      title: const Text('Offer Available'),
                      value: offer,
                      onChanged: (value) {
                        setState(() {
                          offer = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Furnished'),
                      value: furnished,
                      onChanged: (value) {
                        setState(() {
                          furnished = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Parking Available'),
                      value: parking,
                      onChanged: (value) {
                        setState(() {
                          parking = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Listing Type Dropdown
                DropdownButtonFormField<String>(
                  value: type,
                  items: ['rent', 'sale'].map((String typeOption) {
                    return DropdownMenuItem<String>(
                      value: typeOption,
                      child: Text(typeOption),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Listing Type',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Add Listing Button
                _buildCurvedButton(
                  onPressed: () {
                    if (_listingViewFormKey.currentState!.validate()) {
                      try {
                        context.read<ListingBloc>().add(
                              CreateListing(
                                context: context,
                                name: listingNameController.text,
                                description: descriptionController.text,
                                address: addressController.text,
                                regularPrice: parseInteger(
                                    regularPriceController.text, 'Regular Price'),
                                discountedPrice: parseInteger(
                                    discountPriceController.text, 'Discounted Price'),
                                bathrooms: parseInteger(
                                    bathroomsController.text, 'Bathrooms'),
                                bedrooms: parseInteger(
                                    bedroomsController.text, 'Bedrooms'),
                                furnished: furnished,
                                parking: parking,
                                type: type!,
                                offer: offer,
                                imageUrls: base64Images
                                    .map((base64) =>
                                        'data:image/jpeg;base64,$base64')
                                    .toList(),
                              ),
                            );
                            context.read<UserListingBloc>().add(LoadUserListing('currentUserId')); 

                                 // Clear the fields after adding a listing
        listingNameController.clear();
        descriptionController.clear();
        addressController.clear();
        regularPriceController.clear();
        discountPriceController.clear();
        bathroomsController.clear();
        bedroomsController.clear();
        setState(() {
          offer = false;
          furnished = false;
          parking = false;
          type = 'rent';
          base64Images.clear(); 
        });
         context.read<UserListingBloc>().add(LoadUserListing('currentUserId')); 
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    }
                  },
                  label: 'Add Listing',
                ),
                const SizedBox(height: 16),

                // Listings List
        



BlocBuilder<UserListingBloc, UserListingState>(
  builder: (context, state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.error != null) {
      return Center(child: Text(state.error!));
    } else if (state.listings.isEmpty) {
      return const Center(
        child: Text('No Listings Added Yet'),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.listings.length,
        itemBuilder: (context, index) {
          final listing = state.listings[index];

          /// Handle Base64 image decoding
          Widget listingImage;
          if (listing.imageUrls.isNotEmpty && listing.imageUrls[0].startsWith("data:image")) {
            try {
              String base64String = listing.imageUrls[0].split(',').last;
              Uint8List imageBytes = base64Decode(base64String);

              listingImage =  Container(
  width: 100,
  height: 100,
  decoration: BoxDecoration(
    border: Border.all(color: Colors.orangeAccent, width: 2), // Black border
    borderRadius: BorderRadius.circular(12), // Rounded corners
  ),
  child: Image.memory(
    imageBytes,
    width: 60,
    height: 80,
    fit: BoxFit.cover,
  ),
);
            } catch (e) {
              listingImage = Container(
  width: 60,
  height: 80,
  decoration: BoxDecoration(
    border: Border.all(color: Colors.orangeAccent, width: 2), // Black border
    borderRadius: BorderRadius.circular(12), // Rounded corners
  ),
  child: Image.asset(
    'assets/placeholder.jpg',
    width: 60,
    height: 80,
    fit: BoxFit.cover,
  ),
);
            }
          } else {
            listingImage =  Container(
  width: 60,
  height: 80,
  decoration: BoxDecoration(
    border: Border.all(color: Colors.orangeAccent, width: 2), // Black border
    borderRadius: BorderRadius.circular(12), // Rounded corners
  ),
  child: Image.asset(
    'assets/placeholder.jpg',
    width: 60,
    height: 80,
    fit: BoxFit.cover,
  ),
);
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                 side: BorderSide(color: Colors.white, width: 1.8),
                
              ),
              elevation: 5,
              shadowColor: Colors.orangeAccent,
              color: Colors.white,
              
              child: ListTile(
                
                contentPadding: const EdgeInsets.all(10),
                leading: ClipRRect(
                  
                  borderRadius: BorderRadius.circular(12),
                  child: listingImage,
                ),
                title: Text(
                  listing.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${listing.address}, ${listing.type}"),
                    const SizedBox(height: 4),
                    Text(
                      "NRP ${listing.regularPrice}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: getIt<ListingBloc>(),
                              child: EditListingView(listing: listing),
                            ),
                          ),
                        ).then((_) {
                          context.read<UserListingBloc>().add(
                                LoadUserListing(state.currentUserId!),
                              );
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        context.read<ListingBloc>().add(
                              DeleteListing(id: listing.listingId!),
                            );
                        context.read<UserListingBloc>().add(
                              LoadUserListing(state.currentUserId!),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  },
)


            ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper to create a curved rectangular button
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