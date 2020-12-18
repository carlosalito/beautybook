final baseUrl = 'https://us-central1-n2book.cloudfunctions.net/api';

class Endpoints {
  static String me = '$baseUrl/user/me/';
  static String updateUser = '$baseUrl/user/update';
  static String createUser = '$baseUrl/user/create';
  static String updateUserPicture = '$baseUrl/user/updateUserPicture/';
  static String listPosts = '$baseUrl/timeline/list/';
  static String savePost = '$baseUrl/timeline/post';
  static String deltePost = '$baseUrl/timeline/delete/';
  static String updateGalery = '$baseUrl/timeline/updateGalery/';
}
