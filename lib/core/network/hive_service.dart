import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_nest/app/constants/hive_table_constant.dart';
import 'package:open_nest/features/auth/data/model/auth_hive_model.dart';
import 'package:open_nest/features/comments/data/model/comment_hive_model.dart';
import 'package:open_nest/features/like/data/model/like_hive_model.dart';
import 'package:open_nest/features/listing/data/model/listing_hive_model.dart';
// import 'package:open_nest/features/profile/data/model/profile_hive_model.dart'; // Import Profile model
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}db_open_nest_system.db';

    Hive.init(path); 
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(ListingHiveModelAdapter());
    Hive.registerAdapter(CommentHiveModelAdapter());
    Hive.registerAdapter(LikeHiveModelAdapter());

  }

  // Auth Queries
  Future<void> registerAuth(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Login using username and password
  Future<AuthHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    box.close();
    return user;
  }

  Future<void> clearAllAuth() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Clear Student Box
  Future<void> clearAuthBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

//like Queries 
 // Batch Queries
  Future<void> addlike(LikeHiveModel like) async {
    var box = await Hive.openBox<LikeHiveModel>(HiveTableConstant.likeBox);
    await box.put(like.likeId, like);
  }

  Future<void> deleteLike(String id) async {
    var box = await Hive.openBox<LikeHiveModel>(HiveTableConstant.likeBox);
    await box.delete(id);
  }

  Future<List<LikeHiveModel>> getLike() async {
    // Sort by likeId
    var box = await Hive.openBox<LikeHiveModel>(HiveTableConstant.likeBox);
    return box.values.toList()
      ..sort((a, b) => a.likeId.compareTo(b.likeId));
  }

  //comment 
  
  Future<void> addComment(CommentHiveModel comment) async {
    var box = await Hive.openBox<CommentHiveModel>(HiveTableConstant.commentBox);
    await box.put(comment.comment, comment);
  }

  Future<void> deleteComment(String id) async {
    var box = await Hive.openBox<CommentHiveModel>(HiveTableConstant.commentBox);
    await box.delete(id);
  }

  Future<List<CommentHiveModel>> getAllComment() async {
    // Sort by BatchName
    var box = await Hive.openBox<CommentHiveModel>(HiveTableConstant.commentBox);
    return box.values.toList()
      ..sort((a, b) => a.comment.compareTo(b.comment));
  }


   //listing
  
  Future<void> addListing(ListingHiveModel listing) async {
    var box = await Hive.openBox<ListingHiveModel>(HiveTableConstant.listingBox);
    await box.put(listing.listingId, listing);
  }

  Future<void> deleteListing(String id) async {
    var box = await Hive.openBox<ListingHiveModel>(HiveTableConstant.listingBox);
    await box.delete(id);
  }

  Future<List<ListingHiveModel>> getListing() async {
    // Sort by BatchName
    var box = await Hive.openBox<ListingHiveModel>(HiveTableConstant.listingBox);
    return box.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }


  // Profile Queries
  Future<void> saveProfile(AuthHiveModel profile) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(profile.userId, profile);
  }

  Future<void> deleteProfile(String userId) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(userId);
  }

  Future<AuthHiveModel?> getProfile(String userId) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.get(userId);
  }

  Future<List<AuthHiveModel>> getAllProfiles() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Update profile data (username, email, avatar)
  Future<void> updateProfile(AuthHiveModel updatedProfile) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(updatedProfile.userId, updatedProfile);
  }

  // Upload Profile Picture (you could store the URL or local file path)
  Future<void> uploadProfilePicture(String userId, String imagePath) async {
    var profile = await getProfile(userId);
    // if (profile != null) {
    //   profile.avatar = imagePath;  // Assuming avatar is the image path
    //   await updateProfile(profile); // Save the updated profile with the new avatar
    // }
  }

  Future<void> clearAllProfiles() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Close the Hive boxes when done
  Future<void> close() async {
    await Hive.close();
  }
}
