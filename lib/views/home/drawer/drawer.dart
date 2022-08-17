import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/views/poems/poems_category_page.dart';
import '../../../core/controllers/auth/auth_controller.dart';
import '../../settings/settings_page.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProvider = ref.watch(authController);
    // ignore: avoid_print
    print(authProvider.member?.toJson());
    return Drawer(
      backgroundColor: Colors.grey.shade100,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 16),
          children: [
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/others/man.jpeg'),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${authProvider.member?.name}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    indent: 12,
                    endIndent: 12,
                    thickness: 3.5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12.0,
              ),
              child: Column(
                children: [
                  _buttons(
                    context,
                    path: 'assets/icons/home.svg',
                    text: 'Home',
                  ),
                  _buttons(
                    context,
                    path: 'assets/icons/about.svg',
                    text: 'About',
                  ),
                  _buttons(
                    context,
                    path: 'assets/icons/settings.svg',
                    text: '10 Minute transformation',
                  ),
                  _buttons(
                    context,
                    widget: const PoemsCategoryPage(),
                    path: 'assets/icons/poems.svg',
                    text: 'Poems',
                  ),
                  _buttons(
                    context,
                    path: 'assets/icons/messages.svg',
                    text: 'Messages',
                  ),
                  _buttons(
                    context,
                    path: 'assets/icons/videos.svg',
                    text: 'Popular videos',
                  ),
                  _buttons(
                    context,
                    path: 'assets/icons/website.svg',
                    text: 'Website',
                  ),
                  _buttons(
                    context,
                    widget: const SettingsPage(),
                    path: 'assets/icons/settings.svg',
                    text: 'Settings',
                  ),
                  _buttons(
                    context,
                    path: 'assets/icons/contact.svg',
                    text: 'Contact',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttons(
    BuildContext context, {
    required String text,
    Widget? widget,
    required String path,
  }) {
    return InkWell(
      onTap: () {
        if (widget == null) {
          return;
        }
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              path,
              height: 20,
              color: WPConfig.primaryColor,
            ),
            const SizedBox(width: 10),
            Text(text),
          ],
        ),
      ),
    );
  }
}
