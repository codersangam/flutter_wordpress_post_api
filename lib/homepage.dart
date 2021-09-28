import 'dart:convert';

import 'package:codersangam_api/post_details.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var api = 'https://codersangam.com/index.php/wp-json/wp/v2/posts?_embed';

  // ignore: prefer_typing_uninitialized_variables
  var response, posts;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    response = await http.get(Uri.parse(api));
    posts = jsonDecode(response.body);
    // print(posts);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'CoderSangam API'.text.make(),
      ),
      body: Center(
        child: response != null
            ? ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  var post = posts[index];
                  var image = posts[index]['_embedded']['wp:featuredmedia'][0]
                      ['source_url'];
                  return ListTile(
                    leading: Hero(
                      tag: post['id'],
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(image),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          parse((post['title']['rendered']).toString())
                              .documentElement!
                              .text,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDeatilsScreen(post: post),
                        ),
                      );
                    },
                  );
                },
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
