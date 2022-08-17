import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/core/constants/constants.dart';

import '../../core/models/article.dart';

class OnePoemPostPage extends StatefulWidget {
  const OnePoemPostPage({Key? key, required this.post}) : super(key: key);

  final ArticleModel post;

  @override
  State<OnePoemPostPage> createState() => _OnePoemPostPageState();
}

class _OnePoemPostPageState extends State<OnePoemPostPage> {
  @override
  Widget build(BuildContext context) {
    ArticleModel post = widget.post;

    return Scaffold(
      backgroundColor: const Color(0xFFf4e6ca),
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          post.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 22,
            fontFamily: 'Freight',
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 4,
        backgroundColor: const Color(0xFFf4e6ca),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.width * 0.25,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: WPConfig.primaryColor,
                ),
                child: Image.asset(
                  'assets/icons/feather.png',
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              indent: MediaQuery.of(context).size.width * 0.18,
              endIndent: MediaQuery.of(context).size.width * 0.18,
              thickness: 3,
              color: WPConfig.primaryColor,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                post.content,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    IconlyBold.timeCircle,
                    color: WPConfig.primaryColor,
                  ),
                  AppSizedBox.w10,
                  Text(
                    DateFormat.yMMMMd(context.locale.toLanguageTag()).format(post.date),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          fontSize: 12,
                          fontFamily: 'Avenir',
                          color: const Color(0xff0f1010),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
