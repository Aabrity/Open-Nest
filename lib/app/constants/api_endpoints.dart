class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/";
  // For iPhone
  //static const String baseUrl = "http://localhost:3000/api/";

  // ====================== Auth Routes ======================
  // static const String login = "auth/login";
  // static const String register = "auth/signup";
    static const String login = "auth/login";
  static const String register = "auth/signup";
  // static const String getAllStudent = "auth/getAllStudents";
  // static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  // static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  static const String updateUser = "user/updateUser/";
  static const String deleteUser = "user/deleteUser/";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";
  static const String getMe = "user/getme";

  // ====================== Batch Routes ======================
  static const String createLike = "batch/createBatch";
  static const String getAllLike = "batch/getAllBatches";
  static const String deleteLike = "batch/";

  static const String createComment = "comments/createComment";
  static const String getAllComment = "comments/getAllComment";
  static const String deleteComment = "comments/";

  static const String createListing = "listing/createListing";
  static const String getAllListing = "listing/getAllListing";
  static const String deleteListing = "listing/";

  // ====================== Course Routes ======================
  // static const String createCourse = "course/createCourse";
  // static const String deleteCourse = "course/";
  // static const String getAllCourse = "course/getAllCourse";
}
