import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/views/poems/poems_category_page.dart';
import '../../../core/controllers/auth/auth_controller.dart';
import '../../settings/settings_page.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final authProvider = ref.watch(authController);
    return Drawer(
      backgroundColor: Colors.grey.shade100,
      child: SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 16),
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
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const SettingsPage();
                        },
                      ));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.settings,
                          color: WPConfig.primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const PoemsCategoryPage();
                        },
                      ));
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/feather.png',
                          width: 25,
                          color: WPConfig.primaryColor,
                        ),
                        const SizedBox(width: 10),
                        const Text('Poems'),
                      ],
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
