import 'package:flutter/material.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/views/poems/one_poem_post_page.dart';

class PoemsCategoryPage extends StatefulWidget {
  const PoemsCategoryPage({Key? key}) : super(key: key);

  @override
  State<PoemsCategoryPage> createState() => _PoemsCategoryPageState();
}

class _PoemsCategoryPageState extends State<PoemsCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF006199),
        title: const Text(
          'Poems',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: 6,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const OnePoemPostPage();
                  },
                ),
              );
            },
            leading: const Text(
              'Post Title',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: WPConfig.primaryColor,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.access_time_filled_rounded,
                  color: WPConfig.primaryColor,
                  size: 22,
                ),
                SizedBox(width: 6),
                Text('July 9th, 2022'),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            indent: 20,
            thickness: 3.5,
            endIndent: 20,
            color: Color(0xFFf5e6ca),
          );
        },
      ),
    );
  }
}
