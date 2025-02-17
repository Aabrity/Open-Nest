// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:open_nest/features/listing/presentation/view_model/listing_bloc.dart';


// class ListingView extends StatelessWidget {
//   ListingView({super.key});

//   final listingNameController = TextEditingController();

//   final _listingViewFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox.expand(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _listingViewFormKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: listingNameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Listing Name',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter listing name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_listingViewFormKey.currentState!.validate()) {
//                     context.read<ListingBloc>().add(
//                           CreateListing(
//                               listingName: listingNameController.text),
//                         );
//                   }
//                 },
//                 child: Text('Add Listing'),
//               ),
//               SizedBox(height: 10),
//               BlocBuilder<ListingBloc, ListingState>(
//                 builder: (context, state) {
//                   if (state.listings.isEmpty) {
//                     return Center(child: Text('No Listings Added Yet'));
//                   } else if (state.isLoading) {
//                     return CircularProgressIndicator();
//                   } else {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: state.listings.length,
//                         itemBuilder: (context, index) {
//                           final listing = state.listings[index];
//                           return ListTile(
//                             title: Text(listing.listingName),
//                             subtitle: Text(listing.listingId!),
//                             trailing: IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () {
//                                 context.read<ListingBloc>().add(
//                                       DeleteListing(id: listing.listingId!),
//                                     );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/features/listing/presentation/view_model/listing_bloc.dart';


class ListingView extends StatelessWidget {
  ListingView({super.key});

  final listingNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final regularPriceController = TextEditingController();
  final discountedPriceController = TextEditingController();
  final bathroomsController = TextEditingController();
  final bedroomsController = TextEditingController();
  final imageUrlsController = TextEditingController();

  bool offer = false;  // for the offer checkbox
  String? type = 'Rent';  // for the type dropdown (default: Rent)

  final _listingViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _listingViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: listingNameController,
                decoration: const InputDecoration(
                  labelText: 'Listing Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter listing name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: regularPriceController,
                decoration: const InputDecoration(
                  labelText: 'Regular Price',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter regular price';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: discountedPriceController,
                decoration: const InputDecoration(
                  labelText: 'Discounted Price',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: bathroomsController,
                decoration: const InputDecoration(
                  labelText: 'Bathrooms',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: bedroomsController,
                decoration: const InputDecoration(
                  labelText: 'Bedrooms',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: imageUrlsController,
                decoration: const InputDecoration(
                  labelText: 'Image URLs (comma separated)',
                ),
              ),
              SizedBox(height: 10),
              // Offer Checkbox
              Row(
                children: [
                  Checkbox(
                    value: offer,
                    onChanged: (value) {
                      offer = value!;
                    },
                  ),
                  const Text('Offer Available'),
                ],
              ),
              SizedBox(height: 10),
              // Type Dropdown
              DropdownButtonFormField<String>(
                value: type,
                items: ['Rent', 'Sale'].map((String typeOption) {
                  return DropdownMenuItem<String>(
                    value: typeOption,
                    child: Text(typeOption),
                  );
                }).toList(),
                onChanged: (value) {
                  type = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Listing Type',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_listingViewFormKey.currentState!.validate()) {
                    context.read<ListingBloc>().add(
                          CreateListing(
                            name: listingNameController.text,
                            description: descriptionController.text,
                            address: addressController.text,
                            regularPrice: int.tryParse(regularPriceController.text) ?? 0,
                            discountedPrice: int.tryParse(discountedPriceController.text) ?? 0,
                            bathrooms: int.tryParse(bathroomsController.text) ?? 0,
                            bedrooms: int.tryParse(bedroomsController.text) ?? 0,
                            furnished: false, // You can add a boolean field for furnished here
                            parking: false, // You can add a boolean field for parking here
                            type: type!,
                            offer: offer,
                            imageUrls: imageUrlsController.text.split(','),
                          ),
                        );
                  }
                },
                child: Text('Add Listing'),
              ),
              SizedBox(height: 10),
              BlocBuilder<ListingBloc, ListingState>(
                builder: (context, state) {
                  if (state.listings.isEmpty) {
                    return Center(child: Text('No Listings Added Yet'));
                  } else if (state.isLoading) {
                    return CircularProgressIndicator();
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.listings.length,
                        itemBuilder: (context, index) {
                          final listing = state.listings[index];
                          return ListTile(
                            title: Text(listing.name),
                            subtitle: Text(listing.listingId! ?? 'No ID'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<ListingBloc>().add(
                                      DeleteListing(id: listing.listingId!),
                                    );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
