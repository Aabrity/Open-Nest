import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/app/di/di.dart';

import 'package:open_nest/features/home/presentation/view/bottom_view/home_view.dart';
import 'package:open_nest/features/home/presentation/view_model/home/home_bloc.dart';
import 'package:open_nest/features/listing/presentation/view/listing_view.dart';
import 'package:open_nest/features/listing/presentation/view_model/listing_bloc.dart';


class DashboardState extends Equatable {
   final int selectedIndex;
  final List<Widget> views;


 const  DashboardState({required this.selectedIndex, required this.views});

// Initial state
  static DashboardState initial() {
    return DashboardState(
      selectedIndex: 0,
      views: [
         BlocProvider(
          create: (context) => getIt<HomeBloc>(),
          child: HomeScreen(),
        ),
         BlocProvider(
          create: (context) => getIt<ListingBloc>(),
          child: ListingView(),
        ),
         const Center(
          child: Text('Add'),
        ),
         const Center(
          child: Text('Profile')
        ),
      
      ],
    );
  }


  DashboardState copyWith({int? selectedIndex,
    List<Widget>? views,
  }) { 
    return DashboardState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }
  
  @override
  // TODO: implement props
  List<Object?> get props =>  [selectedIndex, views];
}

