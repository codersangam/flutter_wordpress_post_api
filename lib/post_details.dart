import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:html/parser.dart' show parse;

class PostDeatilsScreen extends StatelessWidget {
  const PostDeatilsScreen({Key? key, required this.post}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parse((post['title']['rendered']).toString())
            .documentElement!
            .text),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: post['id'],
              child: Image(
                image: NetworkImage(
                  post['_embedded']['wp:featuredmedia'][0]['source_url'],
                ),
              ),
            ),
            20.heightBox,
            Text(
              parse((post['title']['rendered']).toString())
                  .documentElement!
                  .text,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            20.heightBox,
            Text(
              parse((post['content']['rendered']).toString())
                  .documentElement!
                  .text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
