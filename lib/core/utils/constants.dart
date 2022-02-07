class Constants {
  static const String clientID = "";
  static const String appSecret = "";
  static const String redirectUri = 'https://github.com/mopilo/';
  static const String scope = 'user_profile,user_media';
  static const String responseType = "code";
  static const String url =
      'https://api.instagram.com/oauth/authorize?client_id=$clientID&redirect_uri=$redirectUri&scope=user_profile,user_media&response_type=$responseType';

  static const List<String> userFields = ['id', 'username'];
  static const List<String> mediasListFields = ['id', 'caption'];
  static const List<String> mediaFields = [
    'id',
    'media_type',
    'media_url',
    'username',
    'timestamp'
  ];
}
