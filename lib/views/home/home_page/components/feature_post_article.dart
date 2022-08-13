import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/ads/ad_state_provider.dart';
import '../../../../core/components/network_image.dart';
import '../../../../core/controllers/posts/saved_post_controller.dart';
import '../../../../core/models/article.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/responsive.dart';

class FeaturedPostArticle extends StatelessWidget {
  const FeaturedPostArticle({
    Key? key,
    required this.onTap,
    required this.isActive,
    required this.article,
  }) : super(key: key);

  final void Function() onTap;
  final bool isActive;
  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          // height: 350,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          article.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Freight',
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.watch_later,
                          // IconlyLight.timeCircle,
                          size: 20,
                          color: Color(0xff006199),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat.yMMMMd(context.locale.toLanguageTag())
                              .format(article.date),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 12,
                                fontFamily: 'Avenir',
                                color: const Color(0xff0f1010),
                              ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 190,
                  child: NetworkImageWithLoader(article.featuredImage),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Html(
                    data: article.content,
                    style: {
                      /*
                       style: TextStyle(
                           color: Colors.black,
                           fontFamily: 'FreightText-Book.otf',
                           fontSize: 15,
                           fontWeight: FontWeight.w600,
                         ),
                       */
                      'body': Style(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        fontSize: Responsive.isTablet(context)
                            ? const FontSize(36.0)
                            : const FontSize(12.0),
                        lineHeight: const LineHeight(1.4),
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                        fontFamily: 'Avenir',
                        color: Colors.black,
                      ),
                      'figure': Style(
                        margin: const EdgeInsets.only(left: 3, right: 3),
                        padding: const EdgeInsets.only(left: 3, right: 3),
                      ),
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 10, right: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: Row(
                    children: [
                      SavePostButtonFromHomePage(article: article),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.comment,
                                      arguments: article);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.solidComment,
                                  color: Color(0xFF278eaa),
                                )
                                // Image.asset('assets/icons/comment.png',color: Colors.orange,)

                                ),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                '14',
                                style: TextStyle(
                                  color: Color(0xFF278eaa),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () async =>
                                    await Share.share(article.link),
                                icon: const Icon(
                                  FontAwesomeIcons.share,
                                  color: Color(0xFF278eaa),
                                )
                                // SvgPicture.asset('assets/icons/share.svg',color: Colors.blue,),

                                ),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                '33',
                                style: TextStyle(
                                  color: Color(0xFF278eaa),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SavePostButtonFromHomePage extends ConsumerWidget {
  const SavePostButtonFromHomePage({
    Key? key,
    required this.article,
    this.iconSize = 18,
  }) : super(key: key);

  final ArticleModel article;
  final double iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(savedPostController);
    bool isSaved = saved.value?.contains(article) ?? false;
    bool isSaving = ref.watch(savedPostController.notifier).isSavingPost;

    return InkWell(
      onTap: () async {
        ref.read(loadInterstitalAd);
        if (isSaved) {
          await ref
              .read(savedPostController.notifier)
              .removePostFromSaved(article.id);
          Fluttertoast.showToast(msg: 'article_removed_message'.tr());
        } else {
          await ref.read(savedPostController.notifier).addPostToSaved(article);
          Fluttertoast.showToast(msg: 'article_saved_message'.tr());
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 4),
            child: GestureDetector(
              onTap: () async {
                ref.read(loadInterstitalAd);
                if (isSaved) {
                  await ref
                      .read(savedPostController.notifier)
                      .removePostFromSaved(article.id);
                  Fluttertoast.showToast(msg: 'article_removed_message'.tr());
                } else {
                  await ref
                      .read(savedPostController.notifier)
                      .addPostToSaved(article);
                  Fluttertoast.showToast(msg: 'article_saved_message'.tr());
                }
              },
              child: Icon(
                Icons.favorite,
                size: 28,
                color: isSaved ? const Color(0xFF8D4436) : Colors.grey[400],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12, right: 12),
            child: Text(
              '222',
              style: TextStyle(
                color: Color(0xFF8D4436),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
