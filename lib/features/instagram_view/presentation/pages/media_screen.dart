import 'package:flutter/material.dart';
import 'package:instagram_media/features/instagram_view/data/model/media_model.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({Key? key, required this.medias, required this.name})
      : super(key: key);
  final List<MediaModel> medias;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $name'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            height: 400,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(medias[index].media_url),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8.0);
        },
        itemCount: medias.length,
      ),
    );
  }
}
