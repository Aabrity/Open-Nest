import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_nest/app/constants/hive_table_constant.dart';
import 'package:open_nest/features/auth/data/model/auth_hive_model.dart';
// import 'package:open_nest/features/profile/data/model/profile_hive_model.dart'; // Import Profile model
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}db_open_nest_system.db';

    Hive.init(path); 
    Hive.registerAdapter(AuthHiveModelAdapter());

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
