import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_nest/core/common/snackbar/my_snackbar.dart';
// import 'package:open_nest/core/common/snackbar/my_snackbar.dart';
import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';

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
  String? type = 'Rent';

  final _listingViewFormKey = GlobalKey<FormState>();

  List<File> selectedImages = [];

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    setState(() {
      selectedImages = pickedFiles.map((file) => File(file.path)).toList();
    });
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _listingViewFormKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: listingNameController,
                    decoration:
                        const InputDecoration(labelText: 'Listing Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter listing name' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter description' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter address' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: regularPriceController,
                    decoration:
                        const InputDecoration(labelText: 'Regular Price'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: discountPriceController,
                    decoration:
                        const InputDecoration(labelText: 'Discounted Price'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: bathroomsController,
                    decoration: const InputDecoration(labelText: 'Bathrooms'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: bedroomsController,
                    decoration: const InputDecoration(labelText: 'Bedrooms'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: pickImages,
                    child: const Text('Pick Images'),
                  ),
                  const SizedBox(height: 10),
                  if (selectedImages.isNotEmpty)
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Stack(
                              children: [
                                Image.file(
                                  selectedImages[index],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.cancel,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        selectedImages.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: offer,
                        onChanged: (value) {
                          setState(() {
                            offer = value!;
                          });
                        },
                      ),
                      const Text('Offer Available'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: furnished,
                        onChanged: (value) {
                          setState(() {
                            furnished = value!;
                          });
                        },
                      ),
                      const Text('Furnished'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: parking,
                        onChanged: (value) {
                          setState(() {
                            parking = value!;
                          });
                        },
                      ),
                      const Text('Parking Available'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: type,
                    items: ['Rent', 'Sale'].map((String typeOption) {
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
                    decoration:
                        const InputDecoration(labelText: 'Listing Type'),
                  ),
                  // const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_listingViewFormKey.currentState!.validate()) {
                        context.read<ListingBloc>().add(
                              CreateListing(
                                name: listingNameController.text,
                                description: descriptionController.text,
                                address: addressController.text,
                                regularPrice: parseInteger(
                                    regularPriceController.text,
                                    'Regular Price'),
                                discountPrice: parseInteger(
                                    discountPriceController.text,
                                    'Discounted Price'),
                                bathrooms: parseInteger(
                                    bathroomsController.text, 'Bathrooms'),
                                bedrooms: parseInteger(
                                    bedroomsController.text, 'Bedrooms'),
                                furnished: furnished,
                                parking: parking,
                                type: type!,
                                offer: offer,
                                imageUrls: selectedImages
                                    .map((file) => file.path)
                                    .toList(),
                              ),
                            );
                      }
                    },
                    child: const Text('Add Listing'),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(height: 10),
                  BlocBuilder<ListingBloc, ListingState>(
                      builder: (context, state) {
                    if (state.listings.isEmpty) {
                      return Center(child: Text('No Batches Added Yet'));
                    } else if (state.isLoading) {
                      return CircularProgressIndicator();
                    } else if (state.error != null) {
                      return showMySnackBar(
                        context: context,
                        message: state.error!,
                        color: Colors.red,
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.listings.length,
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              title: Text(state.listings[index].name),
                              subtitle: Text(state.listings[index].listingId!),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context2) {
                                      return AlertDialog(
                                        title: Text('Delete Batch'),
                                        content: Text(
                                            'Are you sure you want to delete ${state.listings[index].name} batch?'),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Delete'),
                                            onPressed: () {
                                              context.read<ListingBloc>().add(
                                                    DeleteListing(
                                                      id: state.listings[index]
                                                          .listingId!,
                                                    ),
                                                  );

                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                  })
                ]),
          ),
        ),
      ),
    ));
  }
}
