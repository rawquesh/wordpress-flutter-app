import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pro/config/wp_config.dart';
import 'package:news_pro/core/controllers/posts/more_post_controller.dart';
// import 'package:news_pro/core/models/article.dart';
import 'package:news_pro/views/poems/one_poem_post_page.dart';

// import '../../core/repositories/posts/post_repository.dart';

class PoemsCategoryPage extends ConsumerWidget {
  const PoemsCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final morePost = ref.watch(moreRelatedPostController(10));

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
      body: morePost.map(
        data: ((ascdata) {
          final data = ascdata.value;
          return ListView.separated(
            itemCount: data.length,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            itemBuilder: (context, index) {
              final post = data[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OnePoemPostPage(post: post);
                      },
                    ),
                  );
                },
                leading: Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: WPConfig.primaryColor,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time_filled_rounded,
                      color: WPConfig.primaryColor,
                      size: 22,
                    ),
                    const SizedBox(width: 6),
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
          );
        }),
        error: (t) => Text(t.toString()),
        loading: (t) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
      // body: ListView.separated(
      //   itemCount: 6,
      //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) {
      //               return const OnePoemPostPage();
      //             },
      //           ),
      //         );
      //       },
      //       leading: const Text(
      //         'Post Title',
      //         style: TextStyle(
      //           fontSize: 17,
      //           fontWeight: FontWeight.w500,
      //           color: WPConfig.primaryColor,
      //         ),
      //       ),
      //       trailing: Row(
      //         mainAxisSize: MainAxisSize.min,
      //         children: const [
      //           Icon(
      //             Icons.access_time_filled_rounded,
      //             color: WPConfig.primaryColor,
      //             size: 22,
      //           ),
      //           SizedBox(width: 6),
      //           Text('July 9th, 2022'),
      //         ],
      //       ),
      //     );
      //   },
      //   separatorBuilder: (context, index) {
      //     return const Divider(
      //       indent: 20,
      //       thickness: 3.5,
      //       endIndent: 20,
      //       color: Color(0xFFf5e6ca),
      //     );
      //   },
      // ),
    );
  }
}
