final baseUrl = 'https://idheaconsult.com.br/api';

class Endpoints {
  static String me = '$baseUrl/user/#id';
  static String user = '$baseUrl/user';
  static String updateUserPicture = '$baseUrl/user/updateUserPicture/';
  static String listPosts = '$baseUrl/timeline/list/';
  static String post = '$baseUrl/timeline';
  static String updateGalery = '$baseUrl/timeline/updateGalery/';
}
