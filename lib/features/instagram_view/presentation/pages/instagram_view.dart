import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:instagram_media/core/utils/constants.dart';
import 'package:instagram_media/features/instagram_view/data/datasource/instagram_datasource.dart';
import 'package:instagram_media/features/instagram_view/data/model/media_model.dart';
import 'package:instagram_media/features/instagram_view/presentation/pages/media_screen.dart';

class InstagramView extends StatefulWidget {
  const InstagramView({Key? key}) : super(key: key);

  @override
  State<InstagramView> createState() => _InstagramViewState();
}

class _InstagramViewState extends State<InstagramView> {
  final webview = FlutterWebviewPlugin();
  late InstagramService _instagramService;

  @override
  void initState() {
    super.initState();
    _instagramService = InstagramService();
    if (Platform.isAndroid) {}

    webview.onUrlChanged.listen((String url) async {
      if (url.contains(Constants.redirectUri)) {
        _instagramService.getAuthorizationCode(url);
        await _instagramService.getTokenAndUserID().then((isDone) {
          if (isDone) {
            _instagramService.getUserProfile().then((isDone) async {
              if (isDone) {
                List<MediaModel> medias =
                    await _instagramService.getAllMedias();

                await webview.close();
                await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MediaScreen(
                    name: _instagramService.username.toString(),
                    medias: medias.sublist(0, 6),
                  ),
                ));
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      resizeToAvoidBottomInset: true,
      url: Constants.url,
      appBar: buildAppBar(context),
    );
  }

  AppBar buildAppBar(BuildContext context) => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Instagram Login',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black),
        ),
      );
}
