import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_media/core/utils/constants.dart';
import 'package:instagram_media/features/instagram_view/data/datasource/instagram_datasource.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'instagram_media_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final client = MockClient();
  InstagramService _instagramService = InstagramService();
  group('Authorize', () {
    test('returns true if the http call completes successfully', () async {
      _instagramService.getAuthorizationCode(Constants.redirectUri);
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.post(
          Uri.parse('https://api.instagram.com/oauth/access_token'),
          body: {
            "client_id": Constants.clientID,
            "redirect_uri": Constants.redirectUri,
            "client_secret": Constants.appSecret,
            "grant_type": "authorization_code",
            "code": _instagramService.authorizationCode,
          })).thenAnswer(
          (_) async => http.Response('{"user_id": 1, "access_token": 2}', 200));

      expect(await _instagramService.getTokenAndUserID(), isA<bool>());
    });
  });
}
