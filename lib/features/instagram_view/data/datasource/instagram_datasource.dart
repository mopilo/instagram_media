import "dart:convert";

import "package:http/http.dart" as http;
import 'package:instagram_media/core/utils/constants.dart';
import 'package:instagram_media/features/instagram_view/data/model/media_model.dart';
import 'package:logger/logger.dart';

class InstagramService {
  late String authorizationCode;
  late String? userID;
  late String? accessToken;
  late String? username;

  var logger = Logger();

  // Gets the authorization code from the redirect url.
  void getAuthorizationCode(String url) {
    authorizationCode = url
        .replaceAll("${Constants.redirectUri}?code=", "")
        .replaceAll("#_", "");
  }

  // Get the token and the userId.
  Future<bool> getTokenAndUserID() async {
    final uri = Uri.parse("https://api.instagram.com/oauth/access_token");
    final response = await http.post(
      uri,
      body: {
        "client_id": Constants.clientID,
        "redirect_uri": Constants.redirectUri,
        "client_secret": Constants.appSecret,
        "grant_type": "authorization_code",
        "code": authorizationCode,
      },
    );

    accessToken = json.decode(response.body)["access_token"];
    userID = json.decode(response.body)["user_id"].toString();
    return (accessToken != null && userID != null) ? true : false;
  }

  Future<bool> getUserProfile() async {
    final fields = Constants.userFields.join(',');
    final responseNode = await http.get(Uri.parse(
        'https://graph.instagram.com/$userID?fields=$fields&access_token=$accessToken'));
    Map instaProfile = {
      'id': json.decode(responseNode.body)['id'].toString(),
      'username': json.decode(responseNode.body)['username'],
    };
    username = json.decode(responseNode.body)['username'];
    return instaProfile.isNotEmpty ? true : false;
  }

  Future<List<MediaModel>> getAllMedias() async {
    /// Parse according fieldsList.
    /// Request instagram user medias list.
    /// Request for each media id the details.
    /// Set all medias as list Object.
    /// Returning the List<MediaModel>.
    final String fields = Constants.mediaFields.join(",");

    final uri = Uri.parse(
        "https://graph.instagram.com/$userID/media?fields=$fields&access_token=$accessToken");

    final responseMedia = await http.get(uri);

    Map<String, dynamic> mediasList = json.decode(responseMedia.body);
    logger.d(mediasList);
    final List<MediaModel> medias = [];

    await mediasList["data"].forEach((media) async {
      // Map<String, dynamic> m = await getMediaDetails(media["id"]);
      MediaModel instaMedia = MediaModel.fromJson(media);
      medias.add(instaMedia);
    });

    // need delay before returning the List<InstaMedia>
    await Future.delayed(const Duration(seconds: 1));
    return medias;
  }

  Future<Map<String, dynamic>> getMediaDetails(String mediaID) async {
    /// Parse according fieldsList.
    /// Request complete media info.
    /// Returning the response as Map<String, dynamic>
    final String fields = Constants.mediaFields.join(",");

    final uri = Uri.parse(
        "https://graph.instagram.com/$mediaID?fields=$fields&access_token=$accessToken");

    final responseMediaSingle = await http.get(uri);

    return json.decode(responseMediaSingle.body);
  }
}
