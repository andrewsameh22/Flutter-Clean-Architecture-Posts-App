class AppConstants {
  static const String baseurl = "https://jsonplaceholder.typicode.com";
  static const String getAllPostsPath = "$baseurl/posts/";
  static String updateOrDeletePost({required int postId}) {
    return "$baseurl/posts/$postId";
  }
}
