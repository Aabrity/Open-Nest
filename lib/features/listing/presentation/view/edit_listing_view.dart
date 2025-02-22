// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// // import 'package:dartz/dartz_streaming.dart' hide Text;
// import 'package:dartz/dartz_streaming.dart' as dartz;
// // import 'package:dartz/dartz_streaming.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
// import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';

// class EditListingView extends StatefulWidget {
//   final ListingEntity listing;

//   const EditListingView({super.key, required this.listing});

//   @override
//   _EditListingViewState createState() => _EditListingViewState();
// }

// class _EditListingViewState extends State<EditListingView> {
//   final listingNameController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final addressController = TextEditingController();
//   final regularPriceController = TextEditingController();
//   final discountPriceController = TextEditingController();
//   final bathroomsController = TextEditingController();
//   final bedroomsController = TextEditingController();

//   bool offer = false;
//   bool furnished = false;
//   bool parking = false;
//   String? type = 'Rent';

//   List<String> base64Images = [];
//   final _picker = ImagePicker(); // To store Base64 encoded images

//   @override
//   void initState() {
//     super.initState();
//     // Pre-fill the form with existing listing data
//     listingNameController.text = widget.listing.name;
//     descriptionController.text = widget.listing.description;
//     addressController.text = widget.listing.address;
//     regularPriceController.text = widget.listing.regularPrice.toString();
//     discountPriceController.text = widget.listing.discountedPrice.toString();
//     bathroomsController.text = widget.listing.bathrooms.toString();
//     bedroomsController.text = widget.listing.bedrooms.toString();
//     offer = widget.listing.offer;
//     furnished = widget.listing.furnished;
//     parking = widget.listing.parking;
//     type = widget.listing.type;
//      base64Images = widget.listing.imageUrls
//       .map((url) => url) // Directly use the image URL or base64 string
//       .toList();
//   }

//   Future<void> pickImages() async {
//     final List<XFile> pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         base64Images = pickedFiles
//             .map((file) => base64Encode(File(file.path).readAsBytesSync()))
//             .toList();
//       });
//     }
//   }

//   int parseInteger(String value, String fieldName) {
//     if (value.isEmpty) {
//       throw Exception('$fieldName cannot be empty');
//     }
//     final parsedValue = int.tryParse(value);
//     if (parsedValue == null) {
//       throw Exception('Invalid number entered for $fieldName');
//     }
//     return parsedValue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SizedBox.expand(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             child: Form(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SingleChildScrollView(
//                     child: TextFormField(
//                       controller: listingNameController,
//                       decoration:
//                           const InputDecoration(labelText: 'Listing Name'),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Please enter listing name' : null,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   SingleChildScrollView(
//                     child: TextFormField(
//                       controller: descriptionController,
//                       decoration: const InputDecoration(labelText: 'Description'),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Please enter description' : null,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: addressController,
//                     decoration: const InputDecoration(labelText: 'Address'),
//                     validator: (value) =>
//                         value!.isEmpty ? 'Please enter address' : null,
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: regularPriceController,
//                     decoration:
//                         const InputDecoration(labelText: 'Regular Price'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: discountPriceController,
//                     decoration:
//                         const InputDecoration(labelText: 'Discounted Price'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: bathroomsController,
//                     decoration: const InputDecoration(labelText: 'Bathrooms'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: bedroomsController,
//                     decoration: const InputDecoration(labelText: 'Bedrooms'),
//                     keyboardType: TextInputType.number,
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: pickImages,
//                     child: const Text('Pick Images'),
//                   ),
//                   const SizedBox(height: 10),
//                   if (base64Images.isNotEmpty)
//                   SizedBox(
//   height: 120,
//   child: ListView.builder(
//     scrollDirection: Axis.horizontal,
//     itemCount: base64Images.length,
//     itemBuilder: (context, index) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 5),
//         child: Stack(
//           children: [
//             // Adjust width and height of the image using BoxFit.contain
//             Image.memory(
//               Uint8List.fromList(base64Decode(base64Images[index])),
//               width: 100,
//               height: 100,
//               fit: BoxFit.contain,  // This ensures the image fits within its container
//             ),
//             Positioned(
//               right: 0,
//               child: IconButton(
//                 icon: const Icon(Icons.cancel, color: Colors.red),
//                 onPressed: () {
//                   setState(() {
//                     base64Images.removeAt(index);
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   ),
// ),

//                     // SizedBox(
//                     //   height: 120,
//                     //   child: ListView.builder(
//                     //     scrollDirection: Axis.horizontal,
//                     //     itemCount: base64Images.length,
//                     //     itemBuilder: (context, index) {
//                     //       return Padding(
//                     //         padding: const EdgeInsets.symmetric(horizontal: 5),
//                     //         child: Stack(
//                     //           children: [
//                     //             Image.memory(
//                     //               Uint8List.fromList(
//                     //                   base64Decode(base64Images[index])),
//                     //               width: 100,
//                     //               height: 100,
//                     //               fit: BoxFit.cover,
//                     //             ),
//                     //             Positioned(
//                     //               right: 0,
//                     //               child: IconButton(
//                     //                 icon: const Icon(Icons.cancel,
//                     //                     color: Colors.red),
//                     //                 onPressed: () {
//                     //                   setState(() {
//                     //                     base64Images.removeAt(index);
//                     //                   });
//                     //                 },
//                     //               ),
//                     //             ),
//                     //           ],
//                     //         ),
//                     //       );
//                     //     },
//                     //   ),
//                     // ),
//                    SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: offer,
//                         onChanged: (value) {
//                           setState(() {
//                             offer = value!;
//                           });
//                         },
//                       ),
//                       const Text('Offer Available'),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: furnished,
//                         onChanged: (value) {
//                           setState(() {
//                             furnished = value!;
//                           });
//                         },
//                       ),
//                       const Text('Furnished'),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: parking,
//                         onChanged: (value) {
//                           setState(() {
//                             parking = value!;
//                           });
//                         },
//                       ),
//                       const Text('Parking Available'),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   DropdownButtonFormField<String>(
//                     value: type,
//                     items: ['Rent', 'Sale'].map((String typeOption) {
//                       return DropdownMenuItem<String>(
//                         value: typeOption,
//                         child: Text(typeOption),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         type = value;
//                       });
//                     },
//                     decoration:
//                         const InputDecoration(labelText: 'Listing Type'),
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Trigger update event here
//                       context.read<ListingBloc>().add(
//                             UpdateListing(
//                               id: widget.listing.listingId!,
//                               name: listingNameController.text,
//                               description: descriptionController.text,
//                               address: addressController.text,
//                               regularPrice: parseInteger(
//                                   regularPriceController.text, 'Regular Price'),
//                               discountedPrice: parseInteger(
//                                   discountPriceController.text,
//                                   'Discounted Price'),
//                               bathrooms: parseInteger(
//                                   bathroomsController.text, 'Bathrooms'),
//                               bedrooms: parseInteger(
//                                   bedroomsController.text, 'Bedrooms'),
//                               furnished: furnished,
//                               parking: parking,
//                               type: type!,
//                               offer: offer,
//                               imageUrls: base64Images
//                                   .map((base64) =>
//                                       'data:image/jpeg;base64,$base64')
//                                   .toList(),
//                             ),
//                           );
//                     },
//                     child: const Text('Update Listing'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
// import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';

// class EditListingView extends StatefulWidget {
//   final ListingEntity listing;

//   const EditListingView({super.key, required this.listing});

//   @override
//   _EditListingViewState createState() => _EditListingViewState();
// }

// class _EditListingViewState extends State<EditListingView> {
//   final listingNameController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final addressController = TextEditingController();
//   final regularPriceController = TextEditingController();
//   final discountPriceController = TextEditingController();
//   final bathroomsController = TextEditingController();
//   final bedroomsController = TextEditingController();

//   bool offer = false;
//   bool furnished = false;
//   bool parking = false;
//   String? type = 'Rent';
//   final _listingViewFormKey = GlobalKey<FormState>();
//   List<String> base64Images = [];
//   final _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     // Pre-fill the form with existing listing data
//     listingNameController.text = widget.listing.name;
//     descriptionController.text = widget.listing.description;
//     addressController.text = widget.listing.address;
//     regularPriceController.text = widget.listing.regularPrice.toString();
//     discountPriceController.text = widget.listing.discountedPrice.toString();
//     bathroomsController.text = widget.listing.bathrooms.toString();
//     bedroomsController.text = widget.listing.bedrooms.toString();
//     offer = widget.listing.offer;
//     furnished = widget.listing.furnished;
//     parking = widget.listing.parking;
//     type = widget.listing.type;
//     base64Images = widget.listing.imageUrls
//         .map((url) => url) // Directly use the image URL or base64 string
//         .toList();
//   }

//   Future<void> pickImages() async {
//     final List<XFile> pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         base64Images = pickedFiles
//             .map((file) => base64Encode(File(file.path).readAsBytesSync()))
//             .toList();
//       });
//     }
//   }

//   int parseInteger(String value, String fieldName) {
//     if (value.isEmpty) {
//       throw Exception('$fieldName cannot be empty');
//     }
//     final parsedValue = int.tryParse(value);
//     if (parsedValue == null) {
//       throw Exception('Invalid number entered for $fieldName');
//     }
//     return parsedValue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Listing'),
//       ),
//       body: SafeArea(
//         child: SizedBox.expand(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               // The entire page is now scrollable
//               child: Form(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextFormField(
//                       controller: listingNameController,
//                       decoration:
//                           const InputDecoration(labelText: 'Listing Name'),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Please enter listing name' : null,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: descriptionController,
//                       decoration:
//                           const InputDecoration(labelText: 'Description'),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Please enter description' : null,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: addressController,
//                       decoration: const InputDecoration(labelText: 'Address'),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Please enter address' : null,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: regularPriceController,
//                       decoration:
//                           const InputDecoration(labelText: 'Regular Price'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: discountPriceController,
//                       decoration:
//                           const InputDecoration(labelText: 'Discounted Price'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: bathroomsController,
//                       decoration: const InputDecoration(labelText: 'Bathrooms'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: bedroomsController,
//                       decoration: const InputDecoration(labelText: 'Bedrooms'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: pickImages,
//                       child: const Text('Pick Images'),
//                     ),
//                     const SizedBox(height: 10),
//                     // Wrap image list with Flexible and ListView.builder for better performance
//                     if (base64Images.isNotEmpty)
//                       SizedBox(
//                         height: 120,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: base64Images.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: Stack(
//                                 children: [
//                                   Image.memory(
//                                     Uint8List.fromList(
//                                         base64Decode(base64Images[index])),
//                                     width: 100,
//                                     height: 100,
//                                     fit: BoxFit.contain,
//                                   ),
//                                   Positioned(
//                                     right: 0,
//                                     child: IconButton(
//                                       icon: const Icon(Icons.cancel,
//                                           color: Colors.red),
//                                       onPressed: () {
//                                         setState(() {
//                                           base64Images.removeAt(index);
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     const SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: offer,
//                           onChanged: (value) {
//                             setState(() {
//                               offer = value!;
//                             });
//                           },
//                         ),
//                         const Text('Offer Available'),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: furnished,
//                           onChanged: (value) {
//                             setState(() {
//                               furnished = value!;
//                             });
//                           },
//                         ),
//                         const Text('Furnished'),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: parking,
//                           onChanged: (value) {
//                             setState(() {
//                               parking = value!;
//                             });
//                           },
//                         ),
//                         const Text('Parking Available'),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     DropdownButtonFormField<String>(
//                       value: type,
//                       items: ['Rent', 'Sale'].map((String typeOption) {
//                         return DropdownMenuItem<String>(
//                           value: typeOption,
//                           child: Text(typeOption),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           type = value;
//                         });
//                       },
//                       decoration:
//                           const InputDecoration(labelText: 'Listing Type'),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         //  if (_listingViewFormKey.currentState!.validate()) {
//                         // Trigger update event here
//                         context.read<ListingBloc>().add(
//                               UpdateListing(
//                                 id: widget.listing.listingId!,
//                                 name: listingNameController.text,
//                                 description: descriptionController.text,
//                                 address: addressController.text,
//                                 regularPrice: parseInteger(
//                                     regularPriceController.text,
//                                     'Regular Price'),
//                                 discountedPrice: parseInteger(
//                                     discountPriceController.text,
//                                     'Discounted Price'),
//                                 bathrooms: parseInteger(
//                                     bathroomsController.text, 'Bathrooms'),
//                                 bedrooms: parseInteger(
//                                     bedroomsController.text, 'Bedrooms'),
//                                 furnished: furnished,
//                                 parking: parking,
//                                 type: type!,
//                                 offer: offer,
//                                 imageUrls: base64Images
//                                     .map((base64) =>
//                                         'data:image/jpeg;base64,$base64')
//                                     .toList(),
//                               ),
//                             );
//                         //  }
//                       },
//                       child: const Text('Update Listing'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
// import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';

// class EditListingView extends StatefulWidget {
//   final ListingEntity listing;

//   const EditListingView({super.key, required this.listing});

//   @override
//   _EditListingViewState createState() => _EditListingViewState();
// }

// class _EditListingViewState extends State<EditListingView> {
//   final listingNameController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final addressController = TextEditingController();
//   final regularPriceController = TextEditingController();
//   final discountPriceController = TextEditingController();
//   final bathroomsController = TextEditingController();
//   final bedroomsController = TextEditingController();

//   bool offer = false;
//   bool furnished = false;
//   bool parking = false;
//   String? type = 'Rent';
//   final _listingViewFormKey = GlobalKey<FormState>();
//   List<String> base64Images = [];
//   final _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     // Pre-fill the form with existing listing data
//     listingNameController.text = widget.listing.name;
//     descriptionController.text = widget.listing.description;
//     addressController.text = widget.listing.address;
//     regularPriceController.text = widget.listing.regularPrice.toString();
//     discountPriceController.text = widget.listing.discountedPrice.toString();
//     bathroomsController.text = widget.listing.bathrooms.toString();
//     bedroomsController.text = widget.listing.bedrooms.toString();
//     offer = widget.listing.offer;
//     furnished = widget.listing.furnished;
//     parking = widget.listing.parking;
//     type = widget.listing.type;
//     base64Images = widget.listing.imageUrls
//         .map((url) => url.replaceFirst('data:image/jpeg;base64,', '')) // Remove prefix if present
//         .toList();
//   }

//   Future<void> pickImages() async {
//     final List<XFile> pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles.isNotEmpty) {
//       setState(() {
//         base64Images = pickedFiles
//             .map((file) => base64Encode(File(file.path).readAsBytesSync()))
//             .toList();
//       });
//     }
//   }

//   int parseInteger(String value, String fieldName) {
//     if (value.isEmpty) {
//       throw Exception('$fieldName cannot be empty');
//     }
//     final parsedValue = int.tryParse(value);
//     if (parsedValue == null) {
//       throw Exception('Invalid number entered for $fieldName');
//     }
//     return parsedValue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Listing'),
//       ),
//       body: SafeArea(
//         child: SizedBox.expand(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               // The entire page is now scrollable
//               child: Form(
//                 key: _listingViewFormKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextFormField(
//                       controller: listingNameController,
//                       decoration:
//                           const InputDecoration(labelText: 'Listing Name'),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Please enter listing name' : null,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: descriptionController,
//                       decoration:
//                           const InputDecoration(labelText: 'Description'),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Please enter description' : null,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: addressController,
//                       decoration: const InputDecoration(labelText: 'Address'),
//                       validator: (value) =>
//                           value!.isEmpty ? 'Please enter address' : null,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: regularPriceController,
//                       decoration:
//                           const InputDecoration(labelText: 'Regular Price'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: discountPriceController,
//                       decoration:
//                           const InputDecoration(labelText: 'Discounted Price'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: bathroomsController,
//                       decoration: const InputDecoration(labelText: 'Bathrooms'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: bedroomsController,
//                       decoration: const InputDecoration(labelText: 'Bedrooms'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: pickImages,
//                       child: const Text('Pick Images'),
//                     ),
//                     const SizedBox(height: 10),
//                     // Wrap image list with Flexible and ListView.builder for better performance
//                     if (base64Images.isNotEmpty)
//                       SizedBox(
//                         height: 120,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: base64Images.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: Stack(
//                                 children: [
//                                   // Decode and display the image
//                                   Image.memory(
//                                     Uint8List.fromList(base64Decode(base64Images[index])),
//                                     width: 100,
//                                     height: 100,
//                                     fit: BoxFit.contain,
//                                   ),
//                                   Positioned(
//                                     right: 0,
//                                     child: IconButton(
//                                       icon: const Icon(Icons.cancel,
//                                           color: Colors.red),
//                                       onPressed: () {
//                                         setState(() {
//                                           base64Images.removeAt(index);
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     const SizedBox(height: 10),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: offer,
//                           onChanged: (value) {
//                             setState(() {
//                               offer = value!;
//                             });
//                           },
//                         ),
//                         const Text('Offer Available'),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: furnished,
//                           onChanged: (value) {
//                             setState(() {
//                               furnished = value!;
//                             });
//                           },
//                         ),
//                         const Text('Furnished'),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: parking,
//                           onChanged: (value) {
//                             setState(() {
//                               parking = value!;
//                             });
//                           },
//                         ),
//                         const Text('Parking Available'),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     DropdownButtonFormField<String>(
//                       value: type,
//                       items: ['Rent', 'Sale'].map((String typeOption) {
//                         return DropdownMenuItem<String>(
//                           value: typeOption,
//                           child: Text(typeOption),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           type = value;
//                         });
//                       },
//                       decoration:
//                           const InputDecoration(labelText: 'Listing Type'),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_listingViewFormKey.currentState!.validate()) {
//                           // Trigger update event here
//                           context.read<ListingBloc>().add(
//                                 UpdateListing(
//                                   id: widget.listing.listingId!,
//                                   name: listingNameController.text,
//                                   description: descriptionController.text,
//                                   address: addressController.text,
//                                   regularPrice: parseInteger(
//                                       regularPriceController.text,
//                                       'Regular Price'),
//                                   discountedPrice: parseInteger(
//                                       discountPriceController.text,
//                                       'Discounted Price'),
//                                   bathrooms: parseInteger(
//                                       bathroomsController.text, 'Bathrooms'),
//                                   bedrooms: parseInteger(
//                                       bedroomsController.text, 'Bedrooms'),
//                                   furnished: furnished,
//                                   parking: parking,
//                                   type: type!,
//                                   offer: offer,
//                                   imageUrls: base64Images
//                                       .map((base64) =>
//                                           'data:image/jpeg;base64,$base64') // Add prefix here
//                                       .toList(),
//                                 ),
//                               );
//                         }
//                       },
//                       child: const Text('Update Listing'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_nest/features/listing/domain/entity/listing_entity.dart';
import 'package:open_nest/features/listing/presentation/view_model/add%20listings/listing_bloc.dart';

class EditListingView extends StatefulWidget {
  final ListingEntity listing;

  const EditListingView({super.key, required this.listing});

  @override
  _EditListingViewState createState() => _EditListingViewState();
}

class _EditListingViewState extends State<EditListingView> {
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
  List<String> base64Images = [];
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Pre-fill the form with existing listing data
    listingNameController.text = widget.listing.name;
    descriptionController.text = widget.listing.description;
    addressController.text = widget.listing.address;
    regularPriceController.text = widget.listing.regularPrice.toString();
    discountPriceController.text = widget.listing.discountedPrice.toString();
    bathroomsController.text = widget.listing.bathrooms.toString();
    bedroomsController.text = widget.listing.bedrooms.toString();
    offer = widget.listing.offer;
    furnished = widget.listing.furnished;
    parking = widget.listing.parking;
    type = widget.listing.type;
    base64Images = widget.listing.imageUrls
        .map((url) => url.replaceFirst('data:image/jpeg;base64,', '')) // Remove prefix if present
        .toList();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Listing', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
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
                              Uint8List.fromList(base64Decode(base64Images[index])),
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
                  decoration: const InputDecoration(
                    labelText: 'Listing Type',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Update Listing Button
                _buildCurvedButton(
                  onPressed: () {
                    if (_listingViewFormKey.currentState!.validate()) {
                      try {
                        context.read<ListingBloc>().add(
                              UpdateListing(
                                context: context,
                                id: widget.listing.listingId!,
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
                                        'data:image/jpeg;base64,$base64') // Add prefix here
                                    .toList(),
                              ),
                            );
                            
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    }
                  },
                  label: 'Update Listing',
                ),
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