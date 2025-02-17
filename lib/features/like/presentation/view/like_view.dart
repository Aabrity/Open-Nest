import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_nest/features/like/presentation/view_model/like_bloc.dart';

class LikeView extends StatelessWidget {
  LikeView({super.key});

  final listingController = TextEditingController();

  final _likeViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _likeViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: listingController,
                decoration: const InputDecoration(
                  labelText: 'Like Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter like name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_likeViewFormKey.currentState!.validate()) {
                    context.read<LikeBloc>().add(
                          CreateLike(listing: listingController.text),
                        );
                  }
                },
                child: Text('Add Like'),
              ),
              SizedBox(height: 10),
              BlocBuilder<LikeBloc, LikeState>(
                builder: (context, state) {
                  if (state.likes.isEmpty) {
                    return Center(child: Text('No Likes Added Yet'));
                  } else if (state.isLoading) {
                    return CircularProgressIndicator();
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.likes.length,
                        itemBuilder: (context, index) {
                          final like = state.likes[index];
                          return ListTile(
                            title: Text(like.listing),
                            subtitle: Text(like.likeId!),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<LikeBloc>().add(
                                      DeleteLike(id: like.likeId!),
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
