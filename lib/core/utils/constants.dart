class Constants {
  static const String clientID = "1352074298563436";
  static const String appSecret = "9ac8319b152ef663d4d4da73c29fa472";
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
