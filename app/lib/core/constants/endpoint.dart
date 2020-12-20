final baseUrl = 'https://idheaconsult.com.br/api';

class Endpoints {
  static String me = '$baseUrl/user/#id/provider/#provider';
  static String user = '$baseUrl/user';
  static String updateUserPicture = '$baseUrl/user/updateUserPicture/';
  static String listPosts = '$baseUrl/timeline/list/';
  static String savePost = '$baseUrl/timeline/post';
  static String deltePost = '$baseUrl/timeline/delete/';
  static String updateGalery = '$baseUrl/timeline/updateGalery/';
}
