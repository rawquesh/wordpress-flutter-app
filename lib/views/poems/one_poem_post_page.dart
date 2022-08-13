import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/core/constants/constants.dart';

class OnePoemPostPage extends StatefulWidget {
  const OnePoemPostPage({Key? key}) : super(key: key);

  @override
  State<OnePoemPostPage> createState() => _OnePoemPostPageState();
}

class _OnePoemPostPageState extends State<OnePoemPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf4e6ca),
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          'Poem Title',
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Lorem ipsum dolor sit amet, con\nsectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit \nesse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,\nsunt in culpa qui officia deserunt mollit anim id est laborum.',
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
                    DateFormat.yMMMMd(context.locale.toLanguageTag()).format(
                      DateTime(2022, 7, 22),
                    ),
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.black,
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
